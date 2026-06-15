-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
--

-- Open PDF files in tdf in a tmux split instead of displaying binary.
-- -d keeps focus on nvim so the buffer-delete that follows doesn't fight tmux focus.
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*.pdf",
  callback = function()
    local pdf = vim.fn.expand("%:p")
    vim.fn.system('tmux list-panes -F "#{pane_current_command}" | grep -qx tdf || tmux split-window -h -d -l 30% "TERM=xterm-kitty tdf ' .. pdf .. '"')
    vim.cmd("bdelete")
  end,
})

-- Repaint nvim after a neighboring pane (typically tdf) closes and leaves
-- the surrounding pane in a half-redrawn state.
vim.api.nvim_create_autocmd("FocusGained", {
  callback = function()
    vim.cmd("redraw!")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "tex" },
  callback = function()
    vim.opt_local.wrap = true
  end,
})

-- TODO: Not working
vim.api.nvim_create_autocmd("FileType", {
  pattern = "typ",
  callback = function()
    vim.cmd("TypstWatch")
    -- -- end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "ipynb" },
  callback = function()
    vim.opt_local.wrap = false
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "cpp", "h", "hpp", "c" },
  callback = function()
    vim.g.autoformat = false
  end,
})

-- -- Add near your NotebookNavigator config or in an ftplugin
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "markdown",
--   group = vim.api.nvim_create_augroup("NN_Init", { clear = true }),
--   callback = function()
--     -- Try to gently initialize NN state if possible
--     -- Replace with a real init function if NN provides one
--     pcall(require("notebook-navigator").is_notebook)
--     -- You might need a small delay if it's still a timing issue
--     -- vim.defer_fn(function() pcall(require("notebook-navigator").is_notebook) end, 100)
--   end,
-- })
