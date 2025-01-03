-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

return require("lazy").setup({
  -- better UI
  {
    "stevearc/dressing.nvim",
    config = function()
      require("plugins.dressing").setup()
    end,
  },

  -- code outline window
  {
    "stevearc/aerial.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("plugins.symbols").setup()
    end,
  },

  -- better notifications
  {
    "rcarriga/nvim-notify",
    -- "ls-devs/nvim-notify",
    config = function()
      vim.notify = require("notify")
    end,
  },

  -- Mason package manager for lsp servers, dap, etc.
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("plugins.lsp.mason_config").setup()
    end,
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },

  {
    "mfussenegger/nvim-lint",
  },
  {
    "rshkarin/mason-nvim-lint",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-lint",
    },
    config = function()
      require("plugins.lint").setup()
    end,
  },
  {
    "towolf/vim-helm",
    ft = "helm",
    config = function()
      require("plugins.helm").setup()
    end,
  },

  -- creates little spinner
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup()
    end,
  }, -- LSP UI

  -- Keybindings configuration / visualisation
  -- Note: Keybindings are configured in keybindings.lua for better self-documentation
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },

  -- File Explorer
  {
    "mikavilpas/yazi.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    keys = {
      -- 👇 in this section, choose your own keymappings!
      -- {
      --   "<leader>-",
      --   function()
      --     require("yazi").yazi()
      --   end,
      --   desc = "Open the file manager",
      -- },
      {
        -- Open in the current working directory
        "<leader>cw",
        function()
          require("yazi").yazi(nil, vim.fn.getcwd())
        end,
        desc = "Open the file manager in nvim's working directory",
      },
    },
    opts = {
      open_for_directories = false,
    },
  },
  {
    "sharklasers996/eza-preview.yazi",
    lazy = true,
    build = function(plugin)
      require("yazi.plugin").build_plugin(plugin)
    end,
  },
  -- TODO: these get put in `flavors` instead of `plugins` for some reason
  -- {
  --   "ndtoan96/ouch.yazi",
  --   lazy = true,
  --   build = function(plugin)
  --     require("yazi.plugin").build_flavor(plugin)
  --   end,
  -- },
  {
    -- example: include a flavor
    "BennyOe/onedark.yazi",
    lazy = true,
    build = function(plugin)
      require("yazi.plugin").build_flavor(plugin)
    end,
  },
  {
    -- Starship prompt plugin for yazi
    -- https://github.com/Rolv-Apneseth/starship.yazi
    "Rolv-Apneseth/starship.yazi",
    lazy = true,
    build = function(plugin)
      -- NOTE: you can customize the yazi directory, by default it is
      -- `~/.config/yazi/`
      require("yazi.plugin").build_plugin(plugin, { yazi_dir = vim.fs.normalize("~/.config/yazi/") })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      "s1n7ax/nvim-window-picker",
    },
    config = function()
      require("plugins.neotree").setup()
    end,
  },

  -- -- Preview vim register contents
  { "tversteeg/registers.nvim" },

  -- bufferline ("tabs")
  {
    "akinsho/bufferline.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "catppuccin/nvim",
    },
    config = function()
      require("plugins.bufferline").setup()
    end,
    version = "*",
  },

  -- Telescope, for file finders/browsers
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "BurntSushi/ripgrep",
      "folke/trouble.nvim",
    },
    config = function()
      require("plugins.telescope").setup()
    end,
  },

  {
    "Marskey/telescope-sg",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
  },

  -- Code completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "f3fora/cmp-spell",
      "L3mon4d3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "onsails/lspkind.nvim",
      "p00f/clangd_extensions.nvim",
    },
    config = function()
      require("plugins.autocompletion").setup()
    end,
  },

  {
    "s1n7ax/nvim-window-picker",
    version = "v1.*",
    config = function()
      require("plugins.windowpicker").setup()
    end,
  },

  -- Code snippets
  {
    "L3mon4d3/LuaSnip",
    config = function()
      require("plugins.snippets").setup()
    end,
  },

  -- Configs for the built-in Language Server Protocol
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.lsp.config").setup()
    end,
  },

  -- Lsp additions
  {
    "nvimdev/lspsaga.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
      "catppuccin/nvim",
      -- "lewis6991/gitsigns.nvim",
    },
    config = function()
      require("plugins.lspsaga").setup()
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("plugins.lsp.null_ls").setup()
    end,
  },

  -- Formatters
  {
    "stevearc/conform.nvim",
    config = function()
      require("plugins.formatters").setup()
    end,
    cmd = { "ConformInfo" },
    event = { "BufWritePre" },
    init = function()
      -- If you want the formatexpr, here is the place to set it
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },

  { "lukas-reineke/lsp-format.nvim" },
  { "sbdchd/neoformat" },

  {
    "ahmedkhalf/jupyter-nvim",
    cmd = "UpdateRemotePlugins",
    config = function()
      require("plugins.python_notebooks")
    end,
  },

  -- inlay hints
  -- {
  --   "lvimuser/lsp-inlayhints.nvim",
  -- },
  -- {
  --   "simrat39/inlay-hints.nvim",
  --   config = function()
  --     require("inlay-hints").setup()
  --   end,
  -- },

  -- clangd extensions (such as inlay hints)
  {
    "p00f/clangd_extensions.nvim",
    config = function()
      require("plugins.lsp.clangd").setup()
    end,
  },

  -- Displaying errors/warnings in a window
  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("plugins.trouble").setup()
    end,
  },

  -- cmake
  -- {
  --   -- "cdelledonne/vim-cmake",
  --   "Civitasv/cmake-tools.nvim",
  --   dependencies = "nvim-lua/plenary.nvim",
  --   config = function()
  --     require("plugins.cmake").setup()
  --   end,
  -- },

  -- rust
  -- {
  --   "simrat39/rust-tools.nvim",
  --   config = function()
  --     require("plugins.rust").setup()
  --   end,
  -- },

  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },

    config = function()
      vim.g.rustaceanvim = {
        -- Plugin configuration
        -- tools = {},
        -- LSP configuration
        server = {
          -- on_attach = function(client, bufnr)
          --   -- you can also put keymaps in here
          --   -- vim.lsp.inlay_hint.(bufnr, true)
          --   -- require("inlay-hints").on_attach(client, bufnr)
          --   -- require("lsp-inlayhints").on_attach(client, bufnr)
          -- end,
          settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
              checkOnSave = {
                command = "clippy",
                allFeatures = true,
                overrideCommand = {
                  "cargo",
                  "clippy",
                  "--workspace",
                  "--all-targets",
                  "--all-features",
                  "--message-format=json",
                  "--",
                  "-D",
                  "warnings",
                },
              },
              assist = {
                importGranularity = "module",
                importPrefix = "self",
              },
              cargo = {
                buildScripts = {
                  enable = true,
                },
                loadOutDirsFromCheck = true,
              },
              procMacro = {
                enable = true,
              },
            },
          },
        },
      }
    end,
  },
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
      require("plugins.rust.crates").setup()
    end,
  },

  {
    "rhaiscript/vim-rhai",
  },

  -- Golang

  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({
        lsp_inlay_hints = {
          enable = true,
        },
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },

  -- Test
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("rustaceanvim.neotest"),
        },
      })
    end,
  },
  -- csv
  { "mechatroner/rainbow_csv" },

  -- comments
  {
    "numToStr/Comment.nvim",
    config = function()
      require("plugins.comment").setup()
    end,
  },

  -- git
  {
    "f-person/git-blame.nvim",
    config = function()
      require("plugins.git").gitblame_setup()
    end,
  },

  -- diffing/merging
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
  },

  {
    "julienvincent/hunk.nvim",
    cmd = { "DiffEditor" },
    config = function()
      require("hunk").setup()
    end,
  },

  -- debugging

  {
    "mfussenegger/nvim-dap",
  },

  { "folke/neodev.nvim", opts = {} },
  {
    "rcarriga/nvim-dap-ui",
    -- version = "v3.2.2",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
      "mfussenegger/nvim-dap-python",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-telescope/telescope-dap.nvim",
      "jbyuki/one-small-step-for-vimkind",
    },
    config = function()
      require("plugins.debugging").setup()
    end,
  },

  -- Mason configuration for dap
  {
    "jayp0521/mason-nvim-dap.nvim",
    config = function()
      require("plugins.debugging").mason_setup()
    end,
  },

  -- Tresitter for minimal source code highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "nushell/tree-sitter-nu" },
    },
    build = ":TSUpdate",
    run = ":TSUpdate",
    config = function()
      require("plugins.treesitter").setup()
    end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "mortepau/codicons.nvim" },
    config = function()
      require("plugins.lualine").setup()
    end,
  },

  -- undovisualiser
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
    },
    config = true,
  },
  -- Highlight & search todos
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("plugins.todo-comments").setup()
    end,
  },

  -- UI based search/replace
  {
    "VonHeikemen/searchbox.nvim",
    dependencies = {
      { "MunifTanjim/nui.nvim" },
    },
    config = function()
      require("plugins.searchbox").setup()
    end,
  },

  -- terminal
  -- { 'voldikss/vim-floaterm' },
  {
    "numToStr/FTerm.nvim",
    config = function()
      require("plugins.terminal").setup()
    end,
  },

  {
    "folke/zen-mode.nvim",
    config = function()
      require("plugins.zenmode").setup()
    end,
  },

  -- Color theme
  { "EdenEast/nightfox.nvim" },
  {
    "navarasu/onedark.nvim",
    -- "catppuccin/nvim",
    config = function()
      require("plugins.colourscheme").setup()
    end,
  },

  -- Indentation guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    config = function()
      require("plugins.guides.indent_blankline").setup()
    end,
  },

  -- colors delimiters in alternating colors (Rainbow Parens)
  {
    "HiPhish/rainbow-delimiters.nvim",
    url = "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
    config = function()
      require("plugins.guides.rainbow").setup()
    end,
  },

  -- colors hex codes
  {
    "nvchad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
  -- jump motions
  {
    "ggandor/leap.nvim",
    dependencies = "tpope/vim-repeat",
    config = function()
      require("plugins.leap").setup()
    end,
  },

  -- folds
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("plugins.nvim_ufo").setup()
    end,
  },

  -- statuscol
  {
    "luukvbaal/statuscol.nvim",
    dependencies = {
      -- "mfussenegger/nvim-dap",
      "lewis6991/gitsigns.nvim",
    },
    config = function()
      require("plugins.statuscol").setup()
    end,
  },

  -- camel case or snake case motion
  {
    "chaoren/vim-wordmotion",
    config = function() end,
  },

  -- Highlight git changes in statuscol
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("plugins.git").gitsigns_setup()
    end,
  },

  -- Show current code context
  {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig",
    config = function()
      require("plugins.navic").setup()
    end,
  },

  -- Statusline built on navic to show the current code context
  {
    "utilyre/barbecue.nvim",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    config = function()
      require("plugins.barbecue").setup()
    end,
  },

  -- Autopairs
  {
    "echasnovski/mini.pairs",
    version = false,
    config = function()
      require("plugins.mini-pairs").setup()
    end,
  },

  -- Jump forward/backward to various target types (e.g conflict marker, comment block)
  {
    "echasnovski/mini.bracketed",
    version = false,
    config = function()
      require("plugins.mini-bracketed").setup()
    end,
  },

  {
    "echasnovski/mini.surround",
    version = false,
    config = function()
      require("plugins.mini-surround").setup()
    end,
  },

  {
    "echasnovski/mini.align",
    version = false,
    config = function()
      require("plugins.mini-align").setup()
    end,
  },
  {
    "echasnovski/mini.icons",
    version = false,
    config = function()
      require("plugins.mini-icons").setup()
    end,
  },

  -- Search & replace
  {
    "MagicDuck/grug-far.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "BurntSushi/ripgrep",
    },
    config = function()
      require("grug-far").setup({
        -- options, see Configuration section below
        -- there are no required options atm
        -- engine = 'ripgrep' is default, but 'astgrep' can be specified

        -- engines = {
        --   ripgrep = {
        --     extraArgs = " --hidden",
        --   },
        -- },
      })
    end,
  },

  -- { "kevinhwang91/promise-async" },
  { "mracos/mermaid.vim" },

  -- Markdown Syntax Highlight

  -- {
  --   'ixru/nvim-markdown',
  --   init = function()
  --     vim.g.vim_markdown_conceal = 0
  --   end
  --
  -- },
  -- {
  --   'jakewvincent/mkdnflow.nvim',
  --   config = function()
  --     require('mkdnflow').setup({
  --       -- Config goes here; leave blank for defaults
  --     })
  --   end
  -- },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    -- config = function()
    --   vim.g.mkdp_browser = "/usr/bin/firefox"
    -- end,
  },
  {
    "dimfeld/section-wordcount.nvim",
    config = function()
      require("section-wordcount").setup({ highlight = "String", virt_text_pos = "eol" })
    end,
  },
  {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    version = "0.3.*",
    build = function()
      require("typst-preview").update()
    end,
  },

  -- Justfile syntax highlighting
  { "NoahTheDuke/vim-just" },
  { "martinda/Jenkinsfile-vim-syntax" },

  -- AI
  -- {
  --   'Exafunction/codeium.vim',
  --   event = 'BufEnter'
  -- },
  {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
      "onsails/lspkind.nvim",
    },
    config = function()
      require("codeium").setup({})
    end,
    event = "BufEnter",
  },

  -- CQL
  { "elubow/cql-vim" },

  -- Oso/Polar
  { "osohq/polar.vim" },

  -- dotnet
  { "Decodetalkers/csharpls-extended-lsp.nvim" },

  -- code screenshots
  {
    "mistricky/codesnap.nvim",
    build = "make build_generator",
    keys = {
      { "<leader>cc", "<cmd>CodeSnap<cr>", mode = "x", desc = "Save selected code snapshot into clipboard" },
      { "<leader>cs", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "Save selected code snapshot in ~/Pictures" },
    },
    opts = {
      save_path = "~/Desktop",
      has_breadcrumbs = true,
      bg_theme = "bamboo",
    },
  },

  -- chezmoi dotfile management
  {
    "xvzc/chezmoi.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "alker0/chezmoi.vim",
    },
    config = function()
      require("chezmoi").setup({
        -- your configurations
        edit = {
          watch = true,
          force = false,
        },
        notification = {
          on_open = false,
          on_apply = true,
          on_watch = false,
        },
        telescope = {
          select = { "<CR>" },
        },
      })
    end,
  },
})
