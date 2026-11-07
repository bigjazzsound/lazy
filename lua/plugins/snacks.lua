return {
  "folke/snacks.nvim",
  commit = "882c996cf28183f4d63640de0b4c02ec886d01f2",
  opts = function(_, opts)
    -- I prefer oil.nvim
    opts.explorer = nil

    opts.picker = {
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
    }

    opts.zen = {
      toggles = {
        dim = false,
      },

      zoom = {
        win = {
          width = 0.45,
        },
      },
    }

    return opts
  end,
  keys = {
    {
      "<leader>ff",
      function()
        Snacks.picker.files({ hidden = true })
      end,
      desc = "Find Files",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.files({ hidden = true })
      end,
      desc = "Find Files",
    },
  },
}
