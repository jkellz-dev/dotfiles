local M = {}

function M.setup()
  require("trouble").setup({
    auto_close = true,
    height = 15,
    padding = false,
    modes = {
      diagnostics = {
        -- auto_open = true,
        preview = {
          type = "split",
          relative = "win",
          position = "right",
          size = 0.5,
        },
      },
    },
  })
end

return M
