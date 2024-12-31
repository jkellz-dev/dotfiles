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
  local wk = require("which-key")

  -- insert mode
  wk.add({
    mode = { "i" },
    { "jj", "<esc>", desc = "escape" },
  })

  -- terminal
  wk.add({
    {
      "<C-t>",
      group = "Terminal",
      mode = { "n" },
    },
    {
      { "<C-t><C-t>", '<CMD>lua require("FTerm").toggle()<CR>', desc = "Toggle Terminal" },
    },
    {
      "<C-t><C-b>",
      function()
        btm:toggle()
      end,
      desc = "Toggle BTM",
    },

    -- terminal mode
    {
      "<C-t>",
      '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>',
      desc = "Toggle Terminal",
      mode = { "t" },
      nowait = true,
    },
  })

  -- misc
  wk.add({
    { ",cc", "<cmd>Lspsaga code_action<cr>", desc = "Code actions" },
    { ",,", "m`A,<Esc>``j", desc = "Append comma and move down", group = "Append" },
    { ";;", "m`A;<Esc>``j", desc = "Append semicolon and move down", group = "Append" },

    -- Ariel
    { "<C-[>", "<cmd>AerialPrev<CR>", desc = "Ariel Prev" },
    { "<C-]>", "<cmd>AerialNext<CR>", desc = "Ariel Next" },
  })

  -- window movement
  wk.add({
    { "<C-h>", "<C-w>h", desc = "Go to the window to the left" },
    { "<C-l>", "<C-w>l", desc = "Go to the window to the right" },
    { "<C-j>", "<C-w>j", desc = "Go to the window below" },
    { "<C-k>", "<C-w>k", desc = "Go to the window above" },
    { "<C-w>w", ":tabclose<cr>", desc = "Close Tab" },
  })

  -- GOTO
  wk.add({
    { "g", mode = { "n" }, group = "Go To" },
    { "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", desc = "Go to declaration" },
    { "gd", "<cmd>Lspsaga goto_definition<CR>", desc = "Go to Definition" },
    { "gr", "<cmd>Lspsaga finder<CR>", desc = "Show References" },
    { "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "Go to implementation" },
    { "gr", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "Go to references" },
    { "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", desc = "Go to Signature Help" },
    { "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", desc = "Go to Type Definition" },
    { "g?", "<cmd>Lspsaga hover_doc<CR>", desc = "Show Docs" },
  })

  -- Folds
  wk.add({
    { "z", mode = { "n" }, group = "Folds" },
    { "zo", "<cmd>foldopen<cr>", desc = "Open fold" },
    { "zc", "<cmd>foldclose<cr>", desc = "Close fold" },
    { "zO", "<cmd>lua require('ufo').openAllFolds<cr>", desc = "Open all folds" },
    { "zC", "<cmd>lua require('ufo').closeAllFolds<cr>", desc = "Close all folds" },
  })

  -- Files
  wk.add({
    { "<tab>", mode = { "n" }, group = "Files" },
    { "<leader><leader>", "<cmd>Telescope fd hidden=true<cr>", desc = "Find files" },
    { "<leader><tab>", "<cmd>Neotree toggle<CR>", desc = "Toggle Neotree" },
    { "<tab><tab>", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
    { "<tab>\\", '<cmd>lua require("yazi").yazi()<cr>', desc = "Open File Explorer" },
    { "<tab>w", ":WhichKey<cr>", desc = "Show WhichKey Help" },
  })

  -- Line Numbers
  wk.add({
    { "<leader>n", mode = { "n" }, group = "Line Numbers" },
    { "<leader>nn", ":set number<cr>:set norelativenumber<cr>", desc = "Enable Line Numbers" },
    { "<leader>nr", ":set number<cr>:set relativenumber<cr>", desc = "Enable Relative Line Numbers" },
    { "<leader>no", ":set number!<cr>:set relativenumber!<cr>", desc = "Disable Line Numbers" },
  })

  -- Buffers
  wk.add({
    { "<leader>b", mode = { "n" }, group = "Buffers" },
    { "<leader>bf", "<cmd>Neoformat<cr><cmd>w<cr>", desc = "Format" },
    { "<leader>bn", "<cmd>bnext<cr>", desc = "Next Buffer" },
    { "<leader>bp", "<cmd>bprev<cr>", desc = "Previous Buffer" },
    { "<leader>bu", "<cmd>undo<cr>", desc = "Undo" },
    { "<leader>br", "<cmd>redo<cr>", desc = "Redo" },
    { "<leader>bh", "<C-w>h", desc = "Go to the window to the left" },
    { "<leader>bl", "<C-w>l", desc = "Go to the window to the right" },
    { "<leader>bj", "<C-w>j", desc = "Go to the window below" },
    { "<leader>bk", "<C-w>k", desc = "Go to the window above" },
    { "<leader>b<", "15<C-w><", desc = "Decrease buffer width" },
    { "<leader>b>", "15<C-w>>", desc = "Increase buffer width" },
    { "<leader>b-", "15<C-w>-", desc = "Decrease buffer height" },
    { "<leader>b+", "15<C-w>+", desc = "Increase buffer height" },
  })

  -- Debug
  wk.add({
    { "<leader>d", mode = { "n" }, group = "Debug" },
    { "<leader>da", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Toggle breakpoint" },
    {
      "<leader>dB",
      "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
      desc = "Conditional breakpoint",
    },
    { "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", desc = "Continue" },
    {
      "<leader>dl",
      "<cmd>lua require'dap.ext.vscode'.load_launchjs()<cr><cmd>lua require'dap'.continue()<cr>",
      desc = "Launch debug session",
    },
    { "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", desc = "Step into" },
    { "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", desc = "Step over" },
    {
      "<leader>dp",
      "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
      desc = "Log point message",
    },
    { "<leader>du", "<cmd>lua require'dap'.step_out()<cr>", desc = "Step out" },
    {
      "<leader>dt",
      "<cmd>lua require'dap'.terminate()<cr><cmd>lua require'dapui'.close()<cr>",
      desc = "Terminate debug session",
    },
  })

  -- Fuzzy Finder
  wk.add({
    { "<leader>f", mode = { "n" }, group = "Fuzzy Finder" },
    { "<leader>fa", "<cmd>Telescope ast_grep<cr>", desc = "AST Grep" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>fc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader>ff", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    { "<leader>fg", "<cmd>Telescope git_status<cr>", desc = "Git files" },
    { "<leader>fh", "<cmd>Telescope search_history<cr>", desc = "Search History" },
    { "<leader>fi", "<cmd>Telescope lsp_implementations<cr>", desc = "Jumplist" },
    { "<leader>fj", "<cmd>Telescope jumplist<cr>", desc = "Jumplist" },
    { "<leader>fk", "<cmd>Telescope chezmoi find_files<cr>", desc = "Chezmoi" },
    { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Marks" },
    { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
    { "<leader>fq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix" },
    { "<leader>fr", "<cmd>Telescope lsp_references<cr>", desc = "LSP References" },
    { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Symbols" },
    { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "TODOs" },
    {
      "<leader>fu",
      "<cmd>lua require('telescope').extensions.undo.undo({ side_by_side = false })<cr>",
      desc = "Undos",
    },
    { "<leader>fz", "<cmd>Telescope spell_suggest<cr>", desc = "Spelling Suggestions" },
    { "<leader>f?", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
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

  -- LSP
  wk.add({
    { "<leader>l", mode = { "n" }, group = "LSP" },
    { "<leader>la", "<cmd>Lspsaga code_action<cr>", desc = "Code actions" },
    { "<leader>ld", "<cmd>Trouble lsp_definiStions<cr>", desc = "Go to definition" },
    { "<leader>lf", "<cmd>Lspsaga finder<CR>", desc = "Show References" },
    { "<leader>lh", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Toggle header/source" },
    { "<leader>lp", "<cmd>Lspsaga peek_definition<cr>", desc = "Peek definition" },
    { "<leader>lr", "<cmd>Lspsaga rename<cr>", desc = "Rename" },
    { "<leader>lu", "<cmd>Trouble lsp_references<cr>", desc = "Show usages" },
    { "<leader>lx", "<cmd>Lspsaga show_line_diagnostics<cr>", desc = "Show line diagnostics" },
  })

  -- Rust
  wk.add({
    { "<leader>r", mode = { "n" }, group = "Rust" },
    { "<leader>rh", "<cmd>RustLsp hover actions<cr>", desc = "Hover actions" },
    { "<leader>ra", "<cmd>RustLsp codeAction<cr>", desc = "Code actions" },
    { "<leader>rr", "<cmd>RustLsp runnables<cr>", desc = "Runnables" },
    { "<leader>rd", "<cmd>RustLsp debuggables<cr>", desc = "Debuggables" },
    { "<leader>rt", "<cmd>RustLsp testables<cr>", desc = "Testables" },
    { "<leader>re", "<cmd>RustLsp expandMacro<cr>", desc = "Expand macro" },
  })

  -- Search
  wk.add({
    { "<leader>s", mode = { "n" }, group = "Search" },
    { "<leader>ss", "<cmd>lua require('searchbox').incsearch()<cr>", desc = "Incremental search" },
    { "<leader>sa", "<cmd>lua require('searchbox').match_all()<cr>", desc = "Match all" },
    { "<leader>sr", "<cmd>lua require('searchbox').replace()<cr>", desc = "Replace" },
    { "<leader>so", "<cmd>lua require('grug-far').open({ transient = true })<cr>", desc = "Open search dialogue" },
    {
      "<leader>sw",
      "<cmd>lua require('grug-far').open({ prefills = { search = vim.fn.expand('<cword>') } })<cr>",
      desc = "Search current word",
    },
    {
      "<leader>sf",
      "<cmd>require('grug-far').open({ prefills = { paths = vim.fn.expand('%') } })<cr>",
      desc = "Search in current file",
    },
  })

  -- Undo
  wk.add({
    { "<leader>u", mode = { "n" }, group = "Undo" },
    { "<leader>ut", "<cmd>lua require('undotree').toggle()<cr>", desc = "Toggle Undotree" },
  })

  -- Trouble
  wk.add({
    { "<leader>x", mode = { "n" }, group = "Trouble" },
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
    { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
    {
      "<leader>xl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
    { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
    { "<leader>xn", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "Jump to next diagnostic" },
    { "<leader>xp", "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "Jump to previous diagnostic" },
    {
      "<leader>xe",
      "<cmd>lua require('lspsaga.diagnostic'):goto_next({ severity = vim.diagnostic.severity.ERROR })<cr>",
      desc = "Jump to next error",
    },
    {
      "<leader>xE",
      "<cmd>lua require('lspsaga.diagnostic'):goto_prev({ severity = vim.diagnostic.severity.ERROR })<cr>",
      desc = "Jump to previous error",
    },
  })

  -- Zen Mode
  wk.add({
    { "<leader>z", mode = { "n" }, group = "ZenMode" },
    { "<leader>zz", "<cmd>ZenMode<cr>", desc = "Zen Mode for current Buffer" },
  })

  -- require("which-key").setup({})

  -- normal mode
  -- require("which-key").register({
  -- ["<C-h>"] = { "<C-w>h", "Go to the window to the left" },
  -- ["<C-l>"] = { "<C-w>l", "Go to the window to the right" },
  -- ["<C-j>"] = { "<C-w>j", "Go to the window below" },
  -- ["<C-k>"] = { "<C-w>k", "Go to the window above" },
  --
  -- ["<C-w>w"] = { ":tabclose<cr>", "Close Tab" },

  -- ["<C-w>!!"] = {"<esc>:lua require'utils'.sudo_write()<CR>", }

  -- [",cc"] = { "<cmd>Lspsaga code_action<cr>", "Code actions" },

  -- Ariel
  -- ["<C-[>"] = { "<cmd>AerialPrev<CR>", "Ariel Prev" },
  -- ["<C-]>"] = { "<cmd>AerialNext<CR>", "Ariel Next" },

  -- terminal
  -- ["<C-t>"] = {
  --   ["<C-t>"] = { '<CMD>lua require("FTerm").toggle()<CR>', "Toggle Terminal" },
  --   ["<C-b>"] = {
  --     function()
  --       btm:toggle()
  --     end,
  --     "Toggle BTM",
  --   },
  -- },

  -- ["g"] = {
  --   name = "Go To",
  --   D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Goto Declaration" },
  --   -- d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to Definition" },
  --   d = { "<cmd>Lspsaga goto_definition<CR>", "Go to Definition" },
  --   r = { "<cmd>Lspsaga finder<CR>", "Show References" },
  --   s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Go to Signature Help" },
  --   i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to Implementation" },
  --   t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Go to Type Definition" },
  --   ["?"] = { "<cmd>Lspsaga hover_doc<CR>", "Show Docs" },
  -- },
  -- ["z"] = {
  --   name = "Folds",
  --   o = { "<cmd>foldopen<cr>", "Open fold" },
  --   c = { "<cmd>foldclose<cr>", "Close fold" },
  --   O = { "<cmd>lua require('ufo').openAllFolds<cr>", "Open all folds" },
  --   C = { "<cmd>lua require('ufo').closeAllFolds<cr>", "Close all folds" },
  -- },
  -- ["<tab>"] = {
  --   ["<tab>"] = { "<cmd>Telescope oldfiles<cr>", "Recent files" },
  --   ["\\"] = { '<cmd>lua require("yazi").yazi()<cr>', "Open File Explorer" },
  --   ["w"] = { ":WhichKey<cr>", "Show WhichKey Help" },
  -- },
  -- ["<leader>"] = {
  -- ["<leader>"] = { "<cmd>Telescope fd hidden=true<cr>", "Find files" },
  -- ["<tab>"] = { "<cmd>Neotree toggle<CR>", "Toggle Neotree" },
  -- ["n"] = {
  --   name = "Numbers",
  --   n = { ":set number<cr>:set norelativenumber<cr>", "Enable Line Numbers" },
  --   r = { ":set number<cr>:set relativenumber<cr>", "Enable Relative Line Numbers" },
  --   o = { ":set number!<cr>:set relativenumber!<cr>", "Disable Line Numbers" },
  -- },
  -- b = {
  --   name = "Buffer",
  --   f = { "<cmd>Neoformat<cr><cmd>w<cr>", "Format" },
  --   n = { "<cmd>bnext<cr>", "Next Buffer" },
  --   p = { "<cmd>bprev<cr>", "Previous Buffer" },
  --   u = { "<cmd>undo<cr>", "Undo" },
  --   r = { "<cmd>redo<cr>", "Redo" },
  --   h = { "<C-w>h", "Go to the window to the left" },
  --   l = { "<C-w>l", "Go to the window to the right" },
  --   j = { "<C-w>j", "Go to the window below" },
  --   k = { "<C-w>k", "Go to the window above" },
  --   ["<"] = { "15<C-w><", "Decrease buffer width" },
  --   [">"] = { "15<C-w>>", "Increase buffer width" },
  --   ["-"] = { "15<C-w>-", "Decrease buffer height" },
  --   ["+"] = { "15<C-w>+", "Increase buffer height" },
  -- },
  -- d = {
  --   name = "Debug",
  --   b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle breakpoint" },
  --   B = {
  --     "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
  --     "Conditional breakpoint",
  --   },
  --   c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
  --   l = {
  --     "<cmd>lua require'dap.ext.vscode'.load_launchjs()<cr><cmd>lua require'dap'.continue()<cr>",
  --     "Launch debug session",
  --   },
  --   i = { "<cmd>lua require'dap'.step_into()<cr>", "Step into" },
  --   o = { "<cmd>lua require'dap'.step_over()<cr>", "Step over" },
  --   p = {
  --     "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
  --     "Log point message",
  --   },
  --   u = { "<cmd>lua require'dap'.step_out()<cr>", "Step out" },
  --   t = {
  --     "<cmd>lua require'dap'.terminate()<cr><cmd>lua require'dapui'.close()<cr>",
  --     "Terminate debug session",
  --   },
  -- },
  -- f = {
  --   name = "Fuzzy finder",
  --   b = { "<cmd>Telescope buffers<cr>", "Buffers" },
  --   c = { "<cmd>Telescope command_history<cr>", "Command History" },
  --   f = { "<cmd>Telescope live_grep<cr>", "Live grep" },
  --   g = { "<cmd>Telescope git_status<cr>", "Git files" },
  --   h = { "<cmd>Telescope search_history<cr>", "Search History" },
  --   i = { "<cmd>Telescope lsp_implementations<cr>", "Jumplist" },
  --   j = { "<cmd>Telescope jumplist<cr>", "Jumplist" },
  --   k = { "<cmd>Telescope chezmoi find_files<cr>", "Chezmoi" },
  --   m = { "<cmd>Telescope marks<cr>", "Marks" },
  --   o = { "<cmd>Telescope oldfiles<cr>", "Recent files" },
  --   q = { "<cmd>Telescope quickfix<cr>", "Quickfix" },
  --   r = { "<cmd>Telescope lsp_references<cr>", "LSP References" },
  --   s = { "<cmd>Telescope lsp_document_symbols<cr>", "Symbols" },
  --   t = { "<cmd>TodoTelescope<cr>", "TODOs" },
  --   u = { "<cmd>lua require('telescope').extensions.undo.undo({ side_by_side = false })<cr>", "Undos" },
  --   z = { "<cmd>Telescope spell_suggest<cr>", "Spelling Suggestions" },
  --   ["?"] = { "<cmd>Telescope help_tags<cr>", "Help tags" },
  -- },
  -- g = {
  --   name = "git",
  --   g = {
  --     function()
  --       gitui:toggle()
  --     end,
  --     "Git UI",
  --   },
  --   d = { ":DiffviewOpen<cr>", "Open DiffView" },
  --   c = { ":DiffviewClose<cr>", "Close DiffView" },
  -- },
  -- l = {
  --   name = "LSP",
  --   a = { "<cmd>Lspsaga code_action<cr>", "Code actions" },
  --   d = { "<cmd>Trouble lsp_definitions<cr>", "Go to definition" },
  --   f = { "<cmd>Lspsaga finder<CR>", "Show References" },
  --   h = { "<cmd>ClangdSwitchSourceHeader<cr>", "Toggle header/source" },
  --   p = { "<cmd>Lspsaga peek_definition<cr>", "Peek definition" },
  --   r = { "<cmd>Lspsaga rename<cr>", "Rename" },
  --   u = { "<cmd>Trouble lsp_references<cr>", "Show usages" },
  --   x = { "<cmd>Lspsaga show_line_diagnostics<cr>", "Show line diagnostics" },
  -- },
  -- r = {
  --   name = "Rust",
  --   h = { "<cmd>RustLsp hover actions<cr>", "Hover actions" },
  --   a = { "<cmd>RustLsp codeAction<cr>", "Code actions" },
  --   r = { "<cmd>RustLsp runnables<cr>", "Runnables" },
  --   d = { "<cmd>RustLsp debuggables<cr>", "Debuggables" },
  --   t = { "<cmd>RustLsp testables<cr>", "Testables" },
  --   e = { "<cmd>RustLsp expandMacro<cr>", "Expand macro" },
  -- },
  -- s = {
  --   name = "Search",
  --   s = { "<cmd>lua require('searchbox').incsearch()<cr>", "Incremental search" },
  --   a = { "<cmd>lua require('searchbox').match_all()<cr>", "Match all" },
  --   r = { "<cmd>lua require('searchbox').replace()<cr>", "Replace" },
  --   o = { "<cmd>lua require('spectre').open()<cr>", "Open search dialogue" },
  --   w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Search current word" },
  --   f = { "<cmd>lua require('spectre').open_file_search()<cr>", "Search in current file" },
  -- },
  -- u = {
  --   name = "Undotree",
  --   t = { "<cmd>lua require('undotree').toggle()<cr>", "Toggle Undotree" },
  -- },
  -- x = {
  --   name = "Trouble",
  --   x = { "<cmd>Trouble diagnostics toggle<cr>", "Diagnostics (Trouble)" },
  --   X = { "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", "Buffer Diagnostics (Trouble)" },
  --   s = { "<cmd>Trouble symbols toggle focus=false<cr>", "Symbols (Trouble)" },
  --   l = {
  --     "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
  --     "LSP Definitions / references / ... (Trouble)",
  --   },
  --   L = { "<cmd>Trouble loclist toggle<cr>", "Location List (Trouble)" },
  --   Q = { "<cmd>Trouble qflist toggle<cr>", "Quickfix List (Trouble)" },
  --   n = { "<cmd>Lspsaga diagnostic_jump_next<cr>", "Jump to next diagnostic" },
  --   p = { "<cmd>Lspsaga diagnostic_jump_prev<cr>", "Jump to previous diagnostic" },
  --   e = {
  --     "<cmd>lua require('lspsaga.diagnostic'):goto_next({ severity = vim.diagnostic.severity.ERROR })<cr>",
  --     "Jump to next error",
  --   },
  --   E = {
  --     "<cmd>lua require('lspsaga.diagnostic'):goto_prev({ severity = vim.diagnostic.severity.ERROR })<cr>",
  --     "Jump to previous error",
  --   },
  -- },
  -- z = {
  --   z = { "<cmd>ZenMode<cr>", "Zen Mode for current Buffer" },
  -- },
  --   },
  -- }, { mode = "n" })
end

return M
