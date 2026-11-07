return {
  "catppuccin/nvim",
  commit = "8edd468af4d63212b84d69b2ddb5ffc9023ef5eb",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  opts = {
    compile_path = string.format("%s/catppuccin", vim.fn.stdpath("cache")),
    flavour = "macchiato",
    integrations = {
      indent_blankline = { enabled = true },
    },
  },
}
