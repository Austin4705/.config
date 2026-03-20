return {
  "lervag/vimtex",
  lazy = false, -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration goes here, e.g.
    vim.g.vimtex_view_method = "general"
    vim.g.vimtex_view_general_viewer = "sh"
    vim.g.vimtex_view_general_options = "-c 'pgrep -x tdf >/dev/null 2>&1 || tmux split-window -h -l 40% \"tdf @pdf\"'"
    vim.g.vimtex_view_automatic = 1
    vim.g.vimtex_local_vimrc_enabled = 1
    vim.g.vimtex_compiler_latexmk = {
      options = {
        "-shell-escape",
        "-interaction=nonstopmode",
      },
    }
  end,
  keys = {
    {
      "<leader>lv",
      function()
        local pdf = vim.fn.fnamemodify(vim.fn.expand("%"), ":r") .. ".pdf"
        vim.fn.system('pgrep -x tdf >/dev/null 2>&1 || tmux split-window -h -l 30% "tdf ' .. pdf .. '"')
      end,
      ft = "tex",
      desc = "Open PDF in tdf",
    },
  },
}
