-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- LazyVim default is 300ms, which is too short for multi-digit counts (e.g. 15j)
-- since which-key can consume the first digit before you finish typing
vim.opt.timeoutlen = 500
