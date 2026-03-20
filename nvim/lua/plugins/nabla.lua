return {
  -- Ensure latex treesitter parser is installed for nabla
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "latex" } },
  },

  {
    "jbyuki/nabla.nvim",
    ft = { "tex", "latex", "markdown" },
    config = function()
      -- Use a more visible highlight instead of the default grey Comment group
      vim.api.nvim_set_hl(0, "nabla", { link = "Normal" })
    end,
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "tex", "latex", "markdown" },
        callback = function()
          -- Small delay to let treesitter parse first
          -- vim.defer_fn(function()
          --   require("nabla").enable_virt({ autogen = true, silent = true })
          -- end, 200)
        end,
      })
    end,
    keys = {
      {
        "<leader>p",
        function()
          require("nabla").popup()
        end,
        desc = "Nabla popup",
      },
      {
        "<leader>P",
        function()
          require("nabla").toggle_virt()
        end,
        desc = "Nabla toggle virtual text",
      },
    },
  },
}
