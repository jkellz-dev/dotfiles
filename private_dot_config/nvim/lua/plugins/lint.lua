local M = {}

function M.setup()
  local lint = require("lint")

  local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    group = lint_augroup,
    callback = function()
      lint.try_lint()
    end,
  })

  require("mason-nvim-lint").setup({
    ensure_installed = { "oxlint" },
    -- Whether linters that are set up (via nvim-lint) should be automatically installed if they're not already installed.
    -- It tries to find the specified linters in the mason's registry to proceed with installation.
    -- This setting has no relation with the `ensure_installed` setting.
    automatic_installation = false,
    -- ignore_install = { "custom-linter" },
  })
end

return M
