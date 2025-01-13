-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local wk = require("which-key")

wk.add({
  { ",cc", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" } },
  { ",,", "m`A,<Esc>``j", desc = "Append comma and move down", group = "Append" },
  { ";;", "m`A;<Esc>``j", desc = "Append semicolon and move down", group = "Append" },
})

local fterm = require("FTerm")

---@diagnostic disable-next-line: missing-fields
local gitui = fterm:new({
  cmd = "lazygit",
  ---@diagnostic disable-next-line: missing-fields
  dimensions = {
    height = 0.9,
    width = 0.9,
  },
})

-- git
wk.add({
  { "<leader>g", mode = { "n" }, group = "git" },
  {
    "<leader>gg",
    function()
      gitui:toggle()
    end,
    desc = "Git UI",
  },
  { "<leader>gd", ":DiffviewOpen<cr>", desc = "Open DiffView" },
  { "<leader>gc", ":DiffviewClose<cr>", desc = "Close DiffView" },
})

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
