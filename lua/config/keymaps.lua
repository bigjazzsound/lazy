local sh = os.getenv("SHELL")

vim.keymap.set("i", "jk", "<esc>", { desc = "Return to normal mode" })
vim.keymap.set("n", "<leader>w", vim.cmd.write, { desc = "Write buffer" })
vim.keymap.set("n", "<leader>q", vim.cmd.quit, { desc = "Quit buffer" })

vim.keymap.set("n", "<Tab>", vim.cmd.tabnext, { desc = "Go to next tab" })
vim.keymap.set("n", "<S-Tab>", vim.cmd.tabprevious, { desc = "Go to previous tab" })

vim.keymap.set("t", "jk", [[<c-\><c-n>]], { desc = "Return to normal mode" })

vim.keymap.set("n", "<m-v>", function()
  return vim.cmd.vsplit("term://" .. sh)
end, { desc = "Open a terminal in a vertical split" })

vim.keymap.set("n", "<m-x>", function()
  return vim.cmd.split("term://" .. sh)
end, { desc = "Open a terminal in a split" })

vim.keymap.set("n", "<m-t>", function()
  return vim.cmd.tabedit("term://" .. sh)
end, { desc = "Open a terminal in a new tab" })

vim.keymap.set({ "n", "i" }, "<m-f>", function()
  return Snacks.zen()
end, { desc = "Focus current file" })
