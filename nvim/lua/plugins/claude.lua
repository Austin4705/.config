return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = {
      terminal = {
        provider = "none",
      },
      diff_opts = {
        open_in_current_tab = true,
      },
    },
    config = function(_, opts)
      require("claudecode").setup(opts)
      require("claude-diff").setup()
    end,
  },
}
