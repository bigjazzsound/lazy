return {
  "nickjvandyke/opencode.nvim",
  dependencies = {
    {
      ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
      "folke/snacks.nvim",
      optional = true,
      opts = {
        input = {},
        picker = {
          actions = {
            opencode_send = function(...)
              return require("opencode").snacks_picker_send(...)
            end,
          },
          win = {
            input = {
              keys = {
                ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
              },
            },
          },
        },
      },
    },
  },
  config = function()
    ---@type opencode.Opts

    vim.o.autoread = true

    -- `a` is used here since I am already familiar with the avante bindings
    vim.keymap.set({ "n", "x" }, "<leader>an", function()
      require("opencode").ask("@this: ", { submit = true })
    end, { desc = "Ask opencode" })

    vim.keymap.set({ "n", "x" }, "<leader>ax", function()
      require("opencode").select()
    end, { desc = "Execute opencode action" })

    vim.keymap.set({ "n", "t" }, "<leader>aa", function()
      require("opencode").toggle()
    end, { desc = "Toggle opencode" })

    vim.keymap.set({ "n", "x" }, "<leader>ae", function()
      return require("opencode").operator("@this ")
    end, { desc = "Add range to opencode", expr = true })
  end,
}
