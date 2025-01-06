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
      "fsautocomplete",
      "golangci_lint_ls",
      "gopls",
      "harper_ls",
      "html",
      "jsonls",
      "lua_ls",
      "marksman",
      "ruff",
      "rust_analyzer",
      "sqlls",
      "sqls",
      "terraformls",
      "tflint",
      "ts_ls",
      "tinymist",
      "yamlls",
      "vale_ls",
      -- "omnisharp",
      -- "pyright",
    },
    -- Automatic_installation = true,
    automatic_installation = { exclude = { "clangd", "helm_ls" } },
  })
end

return M
