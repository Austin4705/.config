return {
  {
    -- This is for typst watch for pdf
    "kaarmu/typst.vim",
    ft = "typst",
    lazy = false,
    init = function()
      vim.g.typst_pdf_viewer = "null"
    end,
  },
  {
    -- This creates the web server for live results as well
    "chomosuke/typst-preview.nvim",
    lazy = false, -- or ft = 'typst'
    version = "1.*",
    opts = {}, -- lazy.nvim will implicitly calls `setup {}`
  },
}
