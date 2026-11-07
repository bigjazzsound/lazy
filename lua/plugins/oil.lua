return {
  "stevearc/oil.nvim",
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  lazy = true,
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    skip_confirm_for_simple_edits = true,
    keymaps = {
      ["<C-h>"] = false,
      ["<C-l>"] = false,
      ["<C-o>"] = { "actions.parent", mode = "n" },
      ["-"] = { "actions.open_cwd", mode = "n" },
      ["<C-v>"] = { "actions.select", opts = { vertical = true } },
      ["<C-x>"] = { "actions.select", opts = { horizontal = true } },
      ["<C-t>"] = { "actions.select", opts = { tab = true } },
      ["<C-r>"] = { "actions.refresh", opts = { vertical = true } },
      ["t"] = { "actions.tcd", mode = "n" },
    },
  },
  cmd = "Oil",
  keys = {
    {
      "<leader>e",
      function()
        return require("oil").open(vim.uv.cwd())
      end,
      desc = "Open parent directory",
    },
  },
}
