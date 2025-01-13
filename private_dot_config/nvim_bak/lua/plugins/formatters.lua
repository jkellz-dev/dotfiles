local M = {}

function M.setup()
  require("conform").setup({
    formatters_by_ft = {
      -- ["*"] = { "codespell" },
      ["_"] = { "trim_whitespace" },
      cs = { "csharpier" },
      elm = { "elm_format" },
      fish = { "fish_indent" },
      go = { "goimports", "gofmt" },
      javascript = { { "prettierd", "prettier" } },
      json = { "fixjson", "jq" },
      justfile = { "just" },
      lua = { "stylua" },
      markdown = { "markdownlint-cli2", "mdsf" },
      mysql = { "sqlfluff" },
      postgresql = { "sqlfluff" },
      -- proto = { "buf" },
      psql = { "sqlfluff" },
      python = { "ruff_organize_imports", "ruff_format", "ruff_fix" },
      rust = { "rustfmt" },
      sh = { "shellcheck", "shellharden" },
      sql = { "sqlfluff" },
      sqlite = { "sqlfluff" },
      terraform = { "terraform_fmt" },
      typst = { "typstyle" },
      -- yaml = { "yamlfix" },
    },
    formatters = {
      codespell = {
        command = "codespell",
        args = { "-I", os.getenv("HOME") .. "/.config/codespell/.codespellignore", "$FILENAME" },
      },
      terraform_fmt = {
        command = "/opt/homebrew/bin/tofu",
      },
      sqlfmt = {
        command = "sqlfmt",
        args = { "--indent", "2" },
      },
      -- sqlfluff = {
      --   command = "sqlfluff",
      --   args = { "fix", "--dialect", "postgres", "$FILENAME" },
      -- },
    },
    format_on_save = { timeout_ms = 500, lsp_fallback = true },
  })
end

return M
