return {
  "stevearc/overseer.nvim",
  lazy = true,
  keys = {
    {
      "<c-p>",
      function()
        return require("overseer").toggle()
      end,
      desc = "Toggle overseer window",
    },
  },
  opts = function(_, opts)
    opts.task_list.max_height = 0.7
  end,
}
