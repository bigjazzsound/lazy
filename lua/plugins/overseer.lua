return {
  "stevearc/overseer.nvim",
  cmd = {
    "OverseerRun",
    "OverseerToggle",
  },
  keys = {
    {
      "<leader>rl",
      function()
        return require("overseer").run_template()
      end,
      desc = "List run targets",
    },
    {
      "<leader>ro",
      function()
        return require("overseer").toggle()
      end,
      desc = "Toggle overseer window",
    },
  },
  opts = {
    task_list = {
      max_height = 0.9,
    },
  },
}
