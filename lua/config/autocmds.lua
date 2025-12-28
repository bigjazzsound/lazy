local autocmd = vim.api.nvim_create_autocmd

-- Turn on cursorline only in the active window
local cursorline = vim.api.nvim_create_augroup("CursorLine", { clear = true })

autocmd("WinEnter", {
  group = cursorline,
  callback = function()
    vim.opt.cursorline = true
  end,
  desc = "Enable cursorline",
})

autocmd("WinLeave", {
  group = cursorline,
  callback = function()
    vim.opt.cursorline = false
  end,
  desc = "Disable cursorline",
})

-- autocmd("TextYankPost", {
--   callback = function()
--     vim.hl.on_yank({ timeout = 100 })
--   end,
-- })

-- autocmd({ "VimResized", "WinNew" }, {
--   callback = function()
--     vim.cmd.wincmd("=")
--   end,
--   desc = "Auto resize windows",
-- })

autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("Term", { clear = true }),
  callback = function()
    vim.opt_local.scrollback = 50000
    vim.opt_local.colorcolumn = "0"
    vim.opt_local.spell = false
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.statuscolumn = " "
  end,
})
