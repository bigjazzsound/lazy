return {
  "folke/snacks.nvim",
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
          -- patterns = {
          --   -- ".git", -- git repo
          --   -- "HEAD", -- git worktree
          --   -- "README.md",
          -- },
          layout = {
            preview = false,
          },
          -- format = function(item, _)
          --   vim.print(item)
          --   return {
          --     { item.text, item.text_hl },
          --   }
          -- end,
        })
      end,
      desc = "Projects",
    },
  },
}
