return {
  "catppuccin/nvim",
  version = "v2.0.0",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  opts = {
    compile_path = string.format("%s/catppuccin", vim.fn.stdpath("cache")),
    flavour = "macchiato",
    integrations = {
      indent_blankline = { enabled = true },
      colored_indent_levels = true,
    },
  },
}
