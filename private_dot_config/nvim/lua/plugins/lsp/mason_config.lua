local M = {}

function M.setup()
  require("mason-lspconfig").setup({
    ensure_installed = {
      "awk_ls",
      "bashls",
      "bufls",
      "clangd",
      "clojure_lsp",
      "cmake",
      "csharp_ls",
      "cssls",
      "dockerls",
      "elixirls",
      "fsautocomplete",
      "golangci_lint_ls",
      "gopls",
      "html",
      "jsonls",
      "lua_ls",
      "marksman",
      -- "pyright",
      "ruff_lsp",
      "rust_analyzer",
      "sqlls",
      "terraformls",
      "tflint",
      "tsserver",
      "yamlls",
      "fsautocomplete",
      "elixirls",
      "typst_lsp",
      -- "omnisharp",
    },
    -- automatic_installation = true,
    automatic_installation = { exclude = { "clangd", "helm_ls" } },
  })
end

return M
