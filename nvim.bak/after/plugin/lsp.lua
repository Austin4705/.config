local lsp = require('lsp-zero')

lsp.preset('recommended')

require('mason').setup()
require('mason-lspconfig').setup()
require('lsp-zero').extend_lspconfig()
require("mason-lspconfig").setup {ensure_installed = { "lua_ls","clangd", "rust_analyzer", "pyright"},}
require("lspconfig").lua_ls.setup {}
require("lspconfig").clangd.setup {}
require("lspconfig").pyright.setup {}


require'lspconfig'.rust_analyzer.setup{
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = false;
      }
    }
  }
}



local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults. cmp_mappings ({
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

lsp.setup()
