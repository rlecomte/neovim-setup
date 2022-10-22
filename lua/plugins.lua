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

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use {
    'L3MON4D3/LuaSnip',
    after = 'nvim-cmp',
    config = function() require('config.snippets') end,
  }

  use {
       "hrsh7th/nvim-cmp",
       config = function() require('config.cmp') end,
       requires = {
           "hrsh7th/cmp-buffer",
           "hrsh7th/cmp-nvim-lsp",
           'rafamadriz/friendly-snippets',
           'hrsh7th/cmp-path',
           'dcampos/cmp-snippy',
           'saadparwaiz1/cmp_luasnip'
       }
  }

  use {
    "scalameta/nvim-metals",
    requires = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
  }

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { 'nvim-lua/plenary.nvim' }
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
