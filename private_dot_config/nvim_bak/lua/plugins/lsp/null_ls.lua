local M = {}

function M.setup()
  local null_ls = require("null-ls")

  null_ls.setup({
    sources = {
      null_ls.builtins.completion.spell,
      require("none-ls.diagnostics.eslint"), -- requires none-ls-extras.nvim
    },
  })
end

return M
