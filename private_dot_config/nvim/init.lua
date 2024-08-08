-- plugins
require("plugins")
require("keybindings").setup()

-- vim settings
local set = vim.opt
local keymap = vim.api.nvim_set_keymap

set.number = true
set.relativenumber = true
set.nu = true
set.rnu = true
set.mouse = "a"

set.ic = true

set.tabstop = 2
set.shiftwidth = 2
set.expandtab = true

set.cursorline = true

set.clipboard = "unnamedplus"

vim.g.python3_host_prog = "/Users/jonathan/.venv/py3nvim/bin/python"

local undodir = vim.fn.expand("~/.local/share/nvim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "", 0700)
end

set.undodir = undodir
set.undofile = true

vim.api.nvim_create_autocmd("VimEnter", {
  command = "set nornu nonu | Neotree reveal",
})

vim.api.nvim_create_augroup("filetypes", { clear = true })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = "filetypes",
  callback = function()
    set.fileformat = "unix"
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = "filetypes",
  pattern = { "*.secrets" },
  callback = function()
    set.filetype = "yaml"
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = "filetypes",
  pattern = { "*.typst", "*.typ" },
  callback = function()
    set.filetype = "typst"
    set.spell = true

    require("which-key").register({
      ["<leader>"] = {
        m = {
          m = { "<cmd>TypstPreview<cr>", "Start Typst Preview" },
          s = { "<cmd>TypstPreviewStop<cr>", "Stop Typst Preview" },
          t = { "<cmd>TypstPreviewToggle<cr>", "Toggle Typst Preview" },
        },
      },
    })

    -- keymap("n", "<leader>mm", "<cmd>TypstPreview<cr>", { noremap = true, silent = true })
    -- keymap("n", "<leader>ms", "<cmd>TypstPreviewStop<cr>", { noremap = true, silent = true })
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = "filetypes",
  pattern = { "*.md" },
  callback = function()
    set.tabstop = 2
    set.shiftwidth = 2
    set.expandtab = true
    set.spell = true

    require("section-wordcount").wordcounter()

    require("which-key").register({
      ["<leader>"] = {
        m = {
          m = { "<cmd>MarkdownPreview<cr>", "Start Markdown Preview" },
          s = { "<cmd>MarkdownPreviewStop<cr>", "Stop Markdown Preview" },
          t = { "<cmd>MarkdownPreviewToggle<cr>", "Toggle Markdown Preview" },
        },
      },
    })
    -- keymap("n", "<leader>mm", "<cmd>MarkdownPreview<cr>", { noremap = true, silent = true })
    -- keymap("n", "<leader>ms", "<cmd>MarkdownPreviewStop<cr>", { noremap = true, silent = true })
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = "filetypes",
  pattern = { "*.cs" },
  callback = function()
    set.tabstop = 4
    set.shiftwidth = 4
    set.expandtab = true
  end,
})

-- add inlay support to all buffers
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end
    -- whatever other lsp config you want
  end,
})
--  e.g. ~/.local/share/chezmoi/*
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { os.getenv("HOME") .. "/.local/share/chezmoi/*" },
  callback = function()
    vim.schedule(require("chezmoi.commands.__edit").watch)
  end,
})
