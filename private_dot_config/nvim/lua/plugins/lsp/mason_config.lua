local M = {}

function M.setup()
  require("mason-lspconfig").setup({
    ensure_installed = {
      "awk_ls",
      "bashls",
      "clangd",
      "clojure_lsp",
      "cmake",
      "csharp_ls",
      "cssls",
      "dockerls",
      "elixirls",
      "elixirls",
      "fsautocomplete",
      "fsautocomplete",
      "golangci_lint_ls",
      "gopls",
      "html",
      "jsonls",
      "lua_ls",
      "marksman",
      "ruff_lsp",
      "rust_analyzer",
      "sqlls",
      "sqls",
      "terraformls",
      "tflint",
      "tsserver",
      "typst_lsp",
      "yamlls",
      -- "omnisharp",
      -- "pyright",
    },
    -- automatic_installation = true,
    automatic_installation = { exclude = { "clangd", "helm_ls" } },
  })
end

return M
