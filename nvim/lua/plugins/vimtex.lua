return {
  "lervag/vimtex",
  lazy = false, -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration goes here, e.g.
    vim.g.vimtex_view_method = "open"
    vim.g.vimtex_local_vimrc_enabled = 1
    vim.g.vimtex_compiler_latexmk = {
      optionns = {
        "-c",
      },
    }
  end,
}
