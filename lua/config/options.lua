vim.g.lazyvim_cmp = "blink.cmp"

vim.opt.mouse = "i"
vim.opt.wrap = true

vim.opt.sessionoptions = {
  "blank",
  "buffers",
  "curdir",
  "tabpages",
}

vim.filetype.add({
  extension = {
    ["yml.tmpl"] = "helm",
  },
})
