local M = {}

function M.setup()
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      "bash",
      "c",
      "c_sharp",
      "comment",
      "cmake",
      "cpp",
      "css",
      "csv",
      "diff",
      "dockerfile",
      "elm",
      "fish",
      "git_config",
      "git_rebase",
      "gitcommit",
      "gitignore",
      "go",
      "gomod",
      "gowork",
      "hcl",
      "helm",
      "html",
      "http",
      "java",
      "javascript",
      "json",
      "kotlin",
      "latex",
      "llvm",
      "lua",
      "make",
      "markdown",
      "markdown_inline",
      "mermaid",
      "passwd",
      "proto",
      "python",
      "regex",
      "rego",
      "ruby",
      "rust",
      "scss",
      "sql",
      "ssh_config",
      "swift",
      "terraform",
      "tmux",
      "todotxt",
      "toml",
      "typescript",
      "typst",
      "vim",
      "xml",
      "yaml",
      "zig",
    },
    sync_install = false,
    highlight = {
      enable = true,
    },
    rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = nil,
      ---- list of languages you want to disable the plugin for
      disable = { "jsx", "cpp" },
      -- Which query to use for finding delimiters
      -- query = 'rainbow-parens',
      -- Highlight the entire buffer all at once
      -- strategy = require('ts-rainbow').strategy.global,
    },
  })
  -- local vim = vim
  -- local opt = vim.opt

  -- opt.foldmethod = "expr"
  -- opt.foldexpr = "nvim_treesitter#foldexpr()"
  --
  -- local autoCommands = {
  --   open_folds = {
  --     { "BufReadPost,FileReadPost", "*", "normal zR" },
  --   },
  -- }
  --
  -- require("utils/autocommands").nvim_create_augroups(autoCommands)
end

return M
