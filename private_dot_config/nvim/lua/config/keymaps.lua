-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.del("n", "<C-h>")
vim.keymap.del("n", "<C-j>")
vim.keymap.del("n", "<C-k>")
vim.keymap.del("n", "<C-l>")

local wk = require("which-key")

wk.add({
  { ",cc", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" } },
  { ",,", "m`A,<Esc>``j", desc = "Append comma and move down", group = "Append" },
  { ";;", "m`A;<Esc>``j", desc = "Append semicolon and move down", group = "Append" },
  {
    "<leader>se",
    function()
      require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
    end,
    mode = { "n" },
    desc = "Replace (current file)",
  },

  { "<leader>N", "<cmd>Neotree toggle<CR>", desc = "Neotree Toggle" },
})

local fterm = require("FTerm")

---@diagnostic disable-next-line: missing-fields
local btm = fterm:new({
  cmd = "btm",
})

wk.add({
  {
    "<leader><C-t>",
    group = "Terminal",
    mode = { "n" },
  },
  {
    "<leader><C-t><C-b>",
    function()
      btm:toggle()
    end,
    desc = "Toggle BTM",
  },
})

---@diagnostic disable-next-line: missing-fields
local jjui = fterm:new({
  cmd = "lazyjj",
})

wk.add({
  { "<leader>j", mode = { "n" }, group = "JJ" },
  {
    "<leader>jj",
    function()
      jjui:toggle()
    end,
    desc = "JJ UI",
  },
})
