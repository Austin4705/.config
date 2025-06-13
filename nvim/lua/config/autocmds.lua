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
    -- Only compile if the current file is detected as a main LaTeX document
    -- if vim.g.vimtex_is_main_file then
    vim.cmd("VimtexCompile")
    -- end
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
