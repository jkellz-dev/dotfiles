return {
  {
    "mrjones2014/smart-splits.nvim",
    lazy = true,
    keys = {
      -- -- moving between splits
      {
        "<M-h>",
        function()
          require("smart-splits").move_cursor_left()
        end,
        desc = "Move to Left Pane",
        mode = { "n", "v" },
      },

      {
        "<M-j>",
        function()
          require("smart-splits").move_cursor_down()
        end,
        desc = "Move to Down Pane",
        mode = { "n", "v" },
      },
      {
        "<M-k>",
        function()
          require("smart-splits").move_cursor_up()
        end,
        desc = "Move to Up Pane",
        mode = { "n", "v" },
      },
      {
        "<M-l>",
        function()
          require("smart-splits").move_cursor_right()
        end,
        desc = "Move to Right Pane",
        mode = { "n", "v" },
      },
      {
        "<M-\\>",
        function()
          require("smart-splits").move_cursor_previous()
        end,
        desc = "Move to Previous Pane",
        mode = { "n", "v" },
      },
      -- resizing splits
      {
        "<M-S-H>",
        function()
          require("smart-splits").resize_left()
        end,
        desc = "Resize Left",
        mode = { "n", "v" },
      },
      {
        "<M-S-J>",
        function()
          require("smart-splits").resize_down()
        end,
        desc = "Resize Down",
        mode = { "n", "v" },
      },
      {
        "<M-S-K>",
        function()
          require("smart-splits").resize_up()
        end,
        desc = "Resize Up",
        mode = { "n", "v" },
      },
      {
        "<M-S-L>",
        function()
          require("smart-splits").resize_right()
        end,
        desc = "Resize Right",
        mode = { "n", "v" },
      },
      -- -- swapping buffers between windows
      {
        "<C-S-H>",
        function()
          require("smart-splits").swap_buf_left()
        end,
        desc = "Swap Left",
        mode = { "n", "v" },
      },
      {
        "<C-S-J>",
        function()
          require("smart-splits").swap_buf_down()
        end,
        desc = "Swap Down",
        mode = { "n", "v" },
      },
      {
        "<C-S-K>",
        function()
          require("smart-splits").swap_buf_up()
        end,
        desc = "Swap Up",
        mode = { "n", "v" },
      },
      {
        "<C-S-L>",
        function()
          require("smart-splits").swap_buf_right()
        end,
        desc = "Swap Right",
        mode = { "n", "v" },
      },
    },
    config = function()
      require("smart-splits").setup({
        ignored_filetypes = { "Neotree" },
        at_edge = "mux",
      })
    end,
  },
}
