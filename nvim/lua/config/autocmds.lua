-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
--

--Automatically clean auxiliary files (except the PDF) after a successful compile
vim.api.nvim_create_autocmd("BufWinLeave", {
  pattern = "tex",
  callback = function()
    vim.cmd("silent! VimtexClean")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "tex" },
  callback = function()
    vim.opt_local.wrap = true
    -- If you also want linebreak at word boundaries:
    -- vim.opt_local.linebreak = true
    vim.cmd("VimtexCompile")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "cpp", "h", "hpp", "c" },
  callback = function()
    vim.g.autoformat = false
  end,
})
