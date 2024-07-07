local M = {}

function M.setup()
  require("aerial").setup({
    autojump = true,
    backends = { "treesitter", "lsp", "markdown", "man" },
    layout = {
      width = 25,
      default_direction = "right",
      placement = "edge",
    },
    open_automatic = true,
    close_automatic_events = { "switch_buffer", "unfocus", "unsupported" },
    attach_mode = "global",
    ignore = {
      filetypes = { "trouble" },
      buftypes = "special",
      wintypes = "special",
    },
    post_jump_cmd = "normal! zz",
    show_guides = true,
  })
end

return M
