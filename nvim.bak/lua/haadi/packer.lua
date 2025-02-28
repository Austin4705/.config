-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use('wbthomason/packer.nvim')

    -- UI
    use('navarasu/onedark.nvim')
    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    use('romgrk/barbar.nvim')
    use('feline-nvim/feline.nvim')

    -- Git
    use('tpope/vim-fugitive')

    -- Navigation + Undo
    use('mbbill/undotree')
    use {
      'nvim-telescope/telescope.nvim', tag = '0.1.5',
      -- or                            , branch = '0.1.x',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    use('nvim-tree/nvim-tree.lua')
    use('nvim-tree/nvim-web-devicons')

    -- DAP Support
    use('mfussenegger/nvim-dap')

    -- LSP
    use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    requires = {
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},

        -- LSP Support
        {'neovim/nvim-lspconfig'},


        -- Autocompletion
        {'hrsh7th/nvim-cmp'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'L3MON4D3/LuaSnip'},
    }}

    -- LaTeX setup
    use('sirver/ultisnips')
    use('lervag/vimtex')

    use {
      "folke/which-key.nvim",
      config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        require("which-key").setup {
        }
      end
    }

    use('sirver/ultisnips')
    use('lervag/vimtex')
    use('KeitaNakamura/tex-conceal.vim')

    #Ausitin Code:
    use { 'dccsillag/magma-nvim', run = ':UpdateRemotePlugins' }

    use({
    'MeanderingProgrammer/render-markdown.nvim',
    after = { 'nvim-treesitter' },
    requires = { 'echasnovski/mini.nvim', opt = true }, -- if you use the mini.nvim suite
    -- requires = { 'echasnovski/mini.icons', opt = true }, -- if you use standalone mini plugins
    -- requires = { 'nvim-tree/nvim-web-devicons', opt = true }, -- if you prefer nvim-web-devicons
    config = function()
        require('render-markdown').setup({})
    end,
    })


end)
