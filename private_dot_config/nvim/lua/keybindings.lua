vim.g.mapleader = "\\"

local fterm = require("FTerm")

local gitui = fterm:new({
  cmd = "lazygit",
  dimensions = {
    height = 0.9,
    width = 0.9,
  },
})

local btm = fterm:new({
  cmd = "btm",
})

local M = {}

function M.setup()
  require("which-key").setup({})

  -- insert mode
  require("which-key").register({
    ["j"] = {
      ["j"] = { "<esc>", "escape" },
    },
  }, { mode = "i" })

  -- terminal mode
  require("which-key").register({
    ["<C-t>"] = { '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', "Toggle Terminal" },
  }, { mode = "t", nowait = true })
  -- normal mode
  require("which-key").register({
    ["<C-h>"] = { "<C-w>h", "Go to the window to the left" },
    ["<C-l>"] = { "<C-w>l", "Go to the window to the right" },
    ["<C-j>"] = { "<C-w>j", "Go to the window below" },
    ["<C-k>"] = { "<C-w>k", "Go to the window above" },

    ["<C-w>w"] = { ":tabclose<cr>", "Close Tab" },

    -- ["<C-w>!!"] = {"<esc>:lua require'utils'.sudo_write()<CR>", }

    [",cc"] = { "<cmd>Lspsaga code_action<cr>", "Code actions" },
    [",,"] = { "m`A,<Esc>``j", "Append comma and move down" },
    [";;"] = { "m`A;<Esc>``j", "Append semicolon and move down" },

    -- Ariel
    ["<C-[>"] = { "<cmd>AerialPrev<CR>", "Ariel Prev" },
    ["<C-]>"] = { "<cmd>AerialNext<CR>", "Ariel Next" },

    -- terminal
    ["<C-t>"] = {
      ["<C-t>"] = { '<CMD>lua require("FTerm").toggle()<CR>', "Toggle Terminal" },
      ["<C-b>"] = {
        function()
          btm:toggle()
        end,
        "Toggle BTM",
      },
    },

    ["g"] = {
      name = "Go To",
      D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Goto Declaration" },
      -- d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to Definition" },
      d = { "<cmd>Lspsaga goto_definition<CR>", "Go to Definition" },
      r = { "<cmd>Lspsaga finder<CR>", "Show References" },
      s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Go to Signature Help" },
      i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to Implementation" },
      t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Go to Type Definition" },
      ["?"] = { "<cmd>Lspsaga hover_doc<CR>", "Show Docs" },
    },
    ["z"] = {
      name = "Folds",
      o = { "<cmd>foldopen<cr>", "Open fold" },
      c = { "<cmd>foldclose<cr>", "Close fold" },
      O = { "<cmd>lua require('ufo').openAllFolds<cr>", "Open all folds" },
      C = { "<cmd>lua require('ufo').closeAllFolds<cr>", "Close all folds" },
    },
    ["<tab>"] = {
      ["<tab>"] = { "<cmd>Telescope oldfiles<cr>", "Recent files" },
      ["\\"] = { '<cmd>lua require("yazi").yazi()<cr>', "Open File Explorer" },
      ["w"] = { ":WhichKey<cr>", "Show WhichKey Help" },
    },
    ["<leader>"] = {
      ["<leader>"] = { "<cmd>Telescope fd hidden=true<cr>", "Find files" },
      ["<tab>"] = { "<cmd>Neotree toggle<CR>", "Toggle Neotree" },
      ["n"] = {
        name = "Numbers",
        n = { ":set number<cr>:set norelativenumber<cr>", "Enable Line Numbers" },
        r = { ":set number<cr>:set relativenumber<cr>", "Enable Relative Line Numbers" },
        o = { ":set number!<cr>:set relativenumber!<cr>", "Disable Line Numbers" },
      },
      b = {
        name = "Buffer",
        f = { "<cmd>Neoformat<cr><cmd>w<cr>", "Format" },
        n = { "<cmd>bnext<cr>", "Next Buffer" },
        p = { "<cmd>bprev<cr>", "Previous Buffer" },
        u = { "<cmd>undo<cr>", "Undo" },
        r = { "<cmd>redo<cr>", "Redo" },
        h = { "<C-w>h", "Go to the window to the left" },
        l = { "<C-w>l", "Go to the window to the right" },
        j = { "<C-w>j", "Go to the window below" },
        k = { "<C-w>k", "Go to the window above" },
        ["<"] = { "15<C-w><", "Decrease buffer width" },
        [">"] = { "15<C-w>>", "Increase buffer width" },
        ["-"] = { "15<C-w>-", "Decrease buffer height" },
        ["+"] = { "15<C-w>+", "Increase buffer height" },
      },
      d = {
        name = "Debug",
        b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle breakpoint" },
        B = {
          "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
          "Conditional breakpoint",
        },
        c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
        l = {
          "<cmd>lua require'dap.ext.vscode'.load_launchjs()<cr><cmd>lua require'dap'.continue()<cr>",
          "Launch debug session",
        },
        i = { "<cmd>lua require'dap'.step_into()<cr>", "Step into" },
        o = { "<cmd>lua require'dap'.step_over()<cr>", "Step over" },
        p = {
          "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
          "Log point message",
        },
        u = { "<cmd>lua require'dap'.step_out()<cr>", "Step out" },
        t = {
          "<cmd>lua require'dap'.terminate()<cr><cmd>lua require'dapui'.close()<cr>",
          "Terminate debug session",
        },
      },
      f = {
        name = "Fuzzy finder",
        b = { "<cmd>Telescope buffers<cr>", "Buffers" },
        c = { "<cmd>Telescope command_history<cr>", "Command History" },
        f = { "<cmd>Telescope live_grep<cr>", "Live grep" },
        g = { "<cmd>Telescope git_status<cr>", "Git files" },
        h = { "<cmd>Telescope search_history<cr>", "Search History" },
        i = { "<cmd>Telescope lsp_implementations<cr>", "Jumplist" },
        j = { "<cmd>Telescope jumplist<cr>", "Jumplist" },
        k = { "<cmd>Telescope chezmoi find_files<cr>", "Chezmoi" },
        m = { "<cmd>Telescope marks<cr>", "Marks" },
        o = { "<cmd>Telescope oldfiles<cr>", "Recent files" },
        q = { "<cmd>Telescope quickfix<cr>", "Quickfix" },
        r = { "<cmd>Telescope lsp_references<cr>", "LSP References" },
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Symbols" },
        t = { "<cmd>TodoTelescope<cr>", "TODOs" },
        u = { "<cmd>lua require('telescope').extensions.undo.undo({ side_by_side = false })<cr>", "Undos" },
        z = { "<cmd>Telescope spell_suggest<cr>", "Spelling Suggestions" },
        ["?"] = { "<cmd>Telescope help_tags<cr>", "Help tags" },
      },
      g = {
        name = "git",
        g = {
          function()
            gitui:toggle()
          end,
          "Git UI",
        },
        d = { ":DiffviewOpen<cr>", "Open DiffView" },
        c = { ":DiffviewClose<cr>", "Close DiffView" },
      },
      l = {
        name = "LSP",
        a = { "<cmd>Lspsaga code_action<cr>", "Code actions" },
        d = { "<cmd>Trouble lsp_definitions<cr>", "Go to definition" },
        f = { "<cmd>Lspsaga finder<CR>", "Show References" },
        h = { "<cmd>ClangdSwitchSourceHeader<cr>", "Toggle header/source" },
        p = { "<cmd>Lspsaga peek_definition<cr>", "Peek definition" },
        r = { "<cmd>Lspsaga rename<cr>", "Rename" },
        u = { "<cmd>Trouble lsp_references<cr>", "Show usages" },
        x = { "<cmd>Lspsaga show_line_diagnostics<cr>", "Show line diagnostics" },
      },
      r = {
        name = "Rust",
        h = { "<cmd>RustLsp hover actions<cr>", "Hover actions" },
        a = { "<cmd>RustLsp codeAction<cr>", "Code actions" },
        r = { "<cmd>RustLsp runnables<cr>", "Runnables" },
        d = { "<cmd>RustLsp debuggables<cr>", "Debuggables" },
        t = { "<cmd>RustLsp testables<cr>", "Testables" },
        e = { "<cmd>RustLsp expandMacro<cr>", "Expand macro" },
      },
      s = {
        name = "Search",
        s = { "<cmd>lua require('searchbox').incsearch()<cr>", "Incremental search" },
        a = { "<cmd>lua require('searchbox').match_all()<cr>", "Match all" },
        r = { "<cmd>lua require('searchbox').replace()<cr>", "Replace" },
        o = { "<cmd>lua require('spectre').open()<cr>", "Open search dialogue" },
        w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Search current word" },
        f = { "<cmd>lua require('spectre').open_file_search()<cr>", "Search in current file" },
      },
      u = {
        name = "Undotree",
        t = { "<cmd>lua require('undotree').toggle()<cr>", "Toggle Undotree" },
      },
      x = {
        name = "Trouble",
        x = { "<cmd>Trouble diagnostics toggle<cr>", "Diagnostics (Trouble)" },
        X = { "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", "Buffer Diagnostics (Trouble)" },
        s = { "<cmd>Trouble symbols toggle focus=false<cr>", "Symbols (Trouble)" },
        l = {
          "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
          "LSP Definitions / references / ... (Trouble)",
        },
        L = { "<cmd>Trouble loclist toggle<cr>", "Location List (Trouble)" },
        Q = { "<cmd>Trouble qflist toggle<cr>", "Quickfix List (Trouble)" },
        n = { "<cmd>Lspsaga diagnostic_jump_next<cr>", "Jump to next diagnostic" },
        p = { "<cmd>Lspsaga diagnostic_jump_prev<cr>", "Jump to previous diagnostic" },
        e = {
          "<cmd>lua require('lspsaga.diagnostic'):goto_next({ severity = vim.diagnostic.severity.ERROR })<cr>",
          "Jump to next error",
        },
        E = {
          "<cmd>lua require('lspsaga.diagnostic'):goto_prev({ severity = vim.diagnostic.severity.ERROR })<cr>",
          "Jump to previous error",
        },
      },
      z = {
        z = { "<cmd>ZenMode<cr>", "Zen Mode for current Buffer" },
      },
    },
  }, { mode = "n" })
end

return M
