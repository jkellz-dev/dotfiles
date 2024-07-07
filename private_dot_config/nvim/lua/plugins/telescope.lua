local M = {}

function M.setup()
  local actions = require("telescope.actions")
  local open_with_trouble = require("trouble.sources.telescope").open
  local add_to_trouble = require("trouble.sources.telescope").add
  local telescope = require("telescope")

  telescope.setup({
    defaults = {
      -- Default configuration for telescope goes here:
      -- config_key = value,
      file_ignore_patterns = {
        ".git",
        "node_modules",
      },
      mappings = {
        i = {
          -- map actions.which_key to <C-h> (default: <C-/>)
          -- actions.which_key shows the mappings for your picker,
          -- e.g. git_{create, delete, ...}_branch for the git_branches picker
          ["<C-h>"] = "which_key",
          ["<C-t>"] = open_with_trouble,
          ["<C-q>"] = add_to_trouble,
        },
        n = {
          ["<C-t>"] = open_with_trouble,
          ["<C-q>"] = add_to_trouble,
        },
      },
    },
    pickers = {
      -- live_grep = {
      --   additional_args = function(opts)
      --     return { "--hidden" }
      --   end
      -- },
    },
    extensions = {
      -- Your extension configuration goes here:
      -- extension_name = {
      --   extension_config_key = value,
      -- }
      -- please take a look at the readme of the extension you want to configure
      undo = {
        use_delta = true,
        use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
        side_by_side = false,
        diff_context_lines = vim.o.scrolloff,
        entry_format = "state #$ID, $STAT, $TIME",
        time_format = "",
        saved_only = false,
      },
    },
  })

  telescope.load_extension("chezmoi")
  telescope.load_extension("undo")
end

return M
