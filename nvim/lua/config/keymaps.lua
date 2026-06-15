-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
vim.keymap.set("i", "jk", "<ESC>", { silent = true })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("t", "jk", "<C-\\><C-n>")

vim.keymap.set("n", "<leader>ud", function()
  local bufnr = 0
  local disabled = vim.diagnostic.is_disabled(bufnr)
  if disabled then
    vim.diagnostic.enable(bufnr)
    print("Diagnostics enabled")
  else
    vim.diagnostic.disable(bufnr)
    print("Diagnostics disabled")
  end
end)
vim.keymap.set("n", "<leader>df", function()
  local pdf = vim.fn.expand("%:p:r") .. ".pdf"
  vim.fn.system('tmux list-panes -F "#{pane_current_command}" | grep -qx tdf || tmux split-window -h -d -l 30% "TERM=xterm-kitty tdf ' .. pdf .. '"')
end, { desc = "Open PDF in tdf (30% right split)" })

vim.keymap.set("n", "<leader>if", "<cmd>edit ~/.config/nvim/nvim-keybinds.md<CR>", {
  desc = "Open keybinds cheatsheet",
})
