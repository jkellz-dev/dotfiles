-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_augroup("previews", { clear = true })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = "previews",
  pattern = { "*.typst", "*.typ" },
  callback = function()
    vim.opt_local.spell = true

    local wk = require("which-key")
    wk.add({
      { "<leader>m", mode = { "n" }, group = "Typst Preview" },
      { "<leader>mm", "<cmd>TypstPreview<cr>", desc = "Start Typst Preview" },
      { "<leader>ms", "<cmd>TypstPreviewStop<cr>", desc = "Stop Typst Preview" },
      { "<leader>mt", "<cmd>TypstPreviewToggle<cr>", desc = "Toggle Typst Preview" },
    })
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = "previews",
  pattern = { "*.md" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
    vim.opt_local.spell = true

    local wk = require("which-key")
    wk.add({
      { "<leader>m", mode = { "n" }, group = "Markdown Preview" },
      { "<leader>mm", "<cmd>MarkdownPreview<cr>", desc = "Start Markdown Preview" },
      { "<leader>ms", "<cmd>MarkdownPreviewStop<cr>", desc = "Stop Markdown Preview" },
      { "<leader>mt", "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle Markdown Preview" },
    })
  end,
})
