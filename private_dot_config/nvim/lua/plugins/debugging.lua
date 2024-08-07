local debugging = {}

function debugging.mason_setup()
  require("mason-nvim-dap").setup({
    automatic_installation = true,
    ensure_installed = { "python", "cpptools", "codelldb", "delve" },
  })
end

function debugging.setup()
  local dap = require("dap")

  local sign = vim.fn.sign_define

  -- These are to override the default highlight groups for catppuccin (see https://github.com/catppuccin/nvim/#special-integrations)
  sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
  sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
  sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })

  local mason_registry = require("mason-registry")
  local codelldb = mason_registry.get_package("codelldb") -- note that this will error if you provide a non-existent package name
  -- codelldb:get_install_path() -- returns a string like "/home/user/.local/share/nvim/mason/packages/codelldb"

  local extension_path = codelldb:get_install_path() .. "/extension/"
  local codelldb_path = extension_path .. "adapter/codelldb"
  -- local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

  -- codelldb
  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      command = codelldb_path,
      args = { "--port", "${port}" },
    },
  }
  -- To use the venv for debugpy that is installed with mason, obtain the path and pass it to `setup` as shown below.
  -- I don't think this is the best idea right now, because it requires that the user installs the packages into a venv that they didn't create and may not know of.

  -- local debugpy_root = mason_registry.get_package("debugpy"):get_install_path()
  -- require("dap-python").setup([[ debugpy_root.. "/venv/bin/python" ]])
  -- require("dap-python").test_runner = "pytest"

  dap.configurations.lua = {
    {
      type = "nlua",
      request = "attach",
      name = "Attach to running Neovim instance",
    },
  }

  dap.adapters.coreclr = {
    type = "executable",
    command = "/usr/local/bin/netcoredbg/netcoredbg",
    args = { "--interpreter=vscode" },
  }

  dap.configurations.cs = {
    {
      type = "coreclr",
      name = "launch - netcoredbg",
      request = "launch",
      program = function()
        return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
      end,
    },
  }

  -- dap.configurations.rust = {
  --   {
  --     type = "codelldb",
  --     request = "launch",
  --     -- This is where cargo outputs the executable
  --     program = function()
  --       os.execute("cargo build &> /dev/null")
  --       return "target/debug/${workspaceFolderBasename}"
  --     end,
  --     args = function()
  --       local argv = {}
  --       arg = vim.fn.input(string.format("argv: "))
  --       for a in string.gmatch(arg, "%S+") do
  --         table.insert(argv, a)
  --       end
  --       return argv
  --     end,
  --     cwd = "${workspaceFolder}",
  --     -- Uncomment if you want to stop at main
  --     -- stopOnEntry = true,
  --     MIMode = "gdb",
  --     miDebuggerPath = "/usr/bin/gdb",
  --     setupCommands = {
  --       {
  --         text = "-enable-pretty-printing",
  --         description = "enable pretty printing",
  --         ignoreFailures = false,
  --       },
  --     },
  --   },
  -- }

  dap.adapters.nlua = function(callback, config)
    callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
  end

  require("nvim-dap-virtual-text").setup({
    enabled = true,
    enabled_commands = true,
    highlight_changed_variables = true,
    highlight_new_as_changed = true,
    show_stop_reason = true,
    commented = true,
    only_first_definition = true,
    all_references = true,
    display_callback = function(variable, _buf, _stackframe, _node)
      return " " .. variable.name .. " = " .. variable.value .. " "
    end,
    -- experimental features:
    virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
    all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
    virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
    virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
  })

  local dapui = require("dapui")
  dapui.setup({
    icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
    mappings = {
      -- Use a table to apply multiple mappings
      expand = { "<CR>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      edit = "e",
      repl = "r",
      toggle = "t",
    },
    -- Expand lines larger than the window
    -- Requires >= 0.7
    expand_lines = vim.fn.has("nvim-0.7") == 1,
    -- Layouts define sections of the screen to place windows.
    -- The position can be "left", "right", "top" or "bottom".
    -- The size specifies the height/width depending on position. It can be an Int
    -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
    -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
    -- Elements are the elements shown in the layout (in order).
    -- Layouts are opened in order so that earlier layouts take priority in window sizing.
    layouts = {
      {
        elements = {
          -- Elements can be strings or table with id and size keys.
          "breakpoints",
          "stacks",
          "watches",
          { id = "scopes", size = 0.25 },
        },
        size = 40, -- 40 columns
        position = "left",
      },
      {
        elements = {
          "repl",
          "console",
        },
        size = 0.25, -- 25% of total lines
        position = "bottom",
      },
    },
    controls = {
      -- Requires Neovim nightly (or 0.8 when released)
      enabled = true,
      -- Display controls in this element
      element = "repl",
      icons = {
        pause = "",
        play = "",
        step_into = "",
        step_over = "",
        step_out = "",
        step_back = "",
        run_last = "↻",
        terminate = "□",
      },
    },
    floating = {
      max_height = nil, -- These can be integers or a float between 0 and 1.
      max_width = nil, -- Floats will be treated as percentage of your screen.
      border = "single", -- Border style. Can be "single", "double" or "rounded"
      mappings = {
        close = { "q", "<Esc>" },
      },
    },
    windows = { indent = 1 },
    render = {
      max_type_length = nil, -- Can be integer or nil.
      max_value_lines = 100, -- Can be integer or nil.
    },
  })

  local symbol_bar = require("aerial")

  dap.listeners.after.event_initialized["dapui_config"] = function()
    symbol_bar.close()
    require("neo-tree.command").execute({ action = "close" })
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    symbol_bar.close()
    require("neo-tree.command").execute({ action = "close" })
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    symbol_bar.open()
    require("neo-tree.command").execute({ action = "open" })
    dapui.close()
  end
end

return debugging
