return {
  {
    "famiu/bufdelete.nvim",
    lazy = false,
    cmd = { "Bdelete", "Bwipeout" },
    keys = {
      { "<leader>bd", "<cmd>Bdelete<cr>", desc = "Delete buffer keeping window" },
      { "<leader>bD", "<cmd>Bdelete!<cr>", desc = "Delete buffer (force) keeping window" },
    },
  },
}
