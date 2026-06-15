return {
  "lervag/vimtex",
  lazy = false, -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    vim.g.vimtex_view_method = "general"
    vim.g.vimtex_view_general_viewer = "sh"
    -- -d: keep focus on nvim. Skip splitting if a tdf pane already exists in this window.
    -- TERM=xterm-kitty makes tdf send kitty graphics escapes; tmux's allow-passthrough
    -- lets Ghostty render them sharp instead of the half-block fallback.
    vim.g.vimtex_view_general_options = "-c 'tmux list-panes -F \"#{pane_current_command}\" | grep -qx tdf || tmux split-window -h -d -l 30% \"TERM=xterm-kitty tdf @pdf\"'"
    vim.g.vimtex_view_automatic = 0
    vim.g.vimtex_local_vimrc_enabled = 1
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_compiler_latexmk = {
      continuous = 1,
      options = {
        "-pdf",
        "-shell-escape",
        "-verbose",
        "-file-line-error",
        "-synctex=1",
        "-interaction=nonstopmode",
      },
    }

    -- Start continuous compile after vimtex has fully initialized the buffer.
    -- Using FileType is unreliable: VimtexCompile is a toggle, so re-entering
    -- the buffer would stop the compile.
    vim.api.nvim_create_autocmd("User", {
      pattern = "VimtexEventInitPost",
      callback = function()
        if vim.b.vimtex and vim.b.vimtex.compiler and not vim.b.vimtex.compiler.is_running then
          vim.cmd("VimtexCompile")
        end
      end,
    })
  end,
  keys = {
    {
      "<leader>lv",
      "<cmd>VimtexView<cr>",
      ft = "tex",
      desc = "Open PDF in tdf",
    },
  },
}
