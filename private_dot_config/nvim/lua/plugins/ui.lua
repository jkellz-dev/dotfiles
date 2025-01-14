return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "night" },
  },

  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "onedark_vivid",
  --   },
  -- },

  { import = "lazyvim.plugins.extras.ui.mini-starter" },

  { "echasnovski/mini.icons" },

  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "numToStr/FTerm.nvim",
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("FTerm").setup({
        border = "double",
        ---@diagnostic disable-next-line: missing-fields
        dimensions = {
          height = 0.9,
          width = 0.9,
        },
      })
    end,
  },
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader><leader>", LazyVim.pick("files", { root = false }), desc = "Find Files" },
      { "<leader>fR", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
      { "<leader>fr", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
      { "<leader>sG", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
      { "<leader>sg", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
    },
  },

  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "super-tab",
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
      },
    },
  },
}
