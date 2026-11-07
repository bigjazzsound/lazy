return {
  "catppuccin/nvim",
  commit = "edefef779ab08ce1a4a404713e3012b0d202bd35",
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
