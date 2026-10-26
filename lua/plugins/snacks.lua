return {
  "folke/snacks.nvim",
  version = "v2.31.0",
  ---@type snacks.Config
  opts = {
    picker = {
      win = {
        input = {
          keys = {
            ["jk"] = { "close", mode = { "n", "i" } },
            ["<c-x>"] = { "edit_split", mode = { "i", "n" } },
            ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
            ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
          },
        },
      },
    },
    zen = {
      toggles = {
        dim = false,
      },
    },
  },
  keys = {
    {
      "<leader>fp",
      function()
        Snacks.picker.projects({
          dev = {
            "~/work",
            "~/work/ref",
          },
          layout = {
            preview = false,
          },
        })
      end,
      desc = "Projects",
    },
  },
}
