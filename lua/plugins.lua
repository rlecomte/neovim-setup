-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- This file can be loaded by calling `lua require('plugins')` from your init.vim
return require('packer').startup(function(use)

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'ellisonleao/gruvbox.nvim'

  use 'neovim/nvim-lspconfig'

  --use 'honza/vim-snippets'

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use { 'junegunn/fzf', run = ":call fzf#install()" }
  use 'junegunn/fzf.vim'

  use {
       "hrsh7th/nvim-cmp",
       requires = {
           "hrsh7th/cmp-buffer",
           "hrsh7th/cmp-nvim-lsp",
           'L3MON4D3/LuaSnip',
           'rafamadriz/friendly-snippets',
           'saadparwaiz1/cmp_luasnip',
           'hrsh7th/cmp-path',
           'dcampos/cmp-snippy',
       }
  }

  use {
    "scalameta/nvim-metals",
    requires = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
  }

  --use {
  --  "folke/trouble.nvim",
  --  requires = "kyazdani42/nvim-web-devicons",
  --  config = function()
  --    require("trouble").setup {
  --      -- your configuration comes here
  --      -- or leave it empty to use the default settings
  --      -- refer to the configuration section below
  --    }
  --  end
  --}
end)
