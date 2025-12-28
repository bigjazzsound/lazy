return {
  "bngarren/checkmate.nvim",
  ft = "markdown",
  cmd = "Checkmate",
  opts = {
    files = {
      "**/todo.md",
    },
  },
  keys = {
    {
      "<leader>tt",
      function()
        return require("checkmate").toggle()
      end,
      desc = "Toggle todo item",
      mode = { "n", "v", "i" },
      buffer = true,
    },
    {
      "<leader>tc",
      function()
        return require("checkmate").check()
      end,
      desc = "Set todo item as checked (done)",
      mode = { "n", "v", "i" },
      buffer = true,
    },
    {
      "<leader>tu",
      function()
        return require("checkmate").uncheck()
      end,
      desc = "Set todo item as unchecked (not done)",
      mode = { "n", "v", "i" },
      buffer = true,
    },
    {
      "<leader>tn",
      function()
        return require("checkmate").create()
      end,
      desc = "Create todo item",
      mode = { "n", "v", "i" },
      buffer = true,
    },
    {
      "<leader>tR",
      function()
        return require("checkmate").remove_all_metadata()
      end,
      desc = "Remove all metadata from a todo item",
      mode = { "n", "v", "i" },
      buffer = true,
    },
    {
      "<leader>ta",
      function()
        return require("checkmate").archive()
      end,
      desc = "Archive checked/completed todo items (move to bottom section)",
      mode = { "n" },
      buffer = true,
    },
  },
}
