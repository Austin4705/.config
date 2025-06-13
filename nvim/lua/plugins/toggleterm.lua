-- lua/plugins/toggleterm.lua
return {
  "akinsho/toggleterm.nvim",
  version = "*", -- use the latest release tag
  event = "VeryLazy", -- loads after startup; swap for "InsertEnter" etc. if you prefer
  -- Key-mappings: work in both normal and terminal mode
  keys = {
    { "<C-\\>", "<cmd>ToggleTerm<CR>", mode = { "n", "t" }, desc = "Toggle terminal" },
  },

  opts = {
    open_mapping = [[<C-\>]],
    start_in_insert = true,
    direction = "float", -- default split type
    persist_size = true,
    shade_terminals = true,
    float_opts = {
      border = "curved",
      winblend = 0,
    },
    -- Dynamically set split sizes if you ever change direction
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return math.floor(vim.o.columns * 0.40)
      end
    end,
  },
}
