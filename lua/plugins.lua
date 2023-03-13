local vim = vim
local execute = vim.api.nvim_command

local fn = vim.fn

-- ensure that packer is installed
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    execute 'packadd packer.nvim'
end

local packer = require('packer')
local util = require('packer.util')
packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})

-- This file can be loaded by calling `lua require('plugins')` from your init.vim
return packer.startup(function(use)
  use {'wbthomason/packer.nvim'}

  use 'neovim/nvim-lspconfig'

  use 'jose-elias-alvarez/typescript.nvim'

  use({
    "jose-elias-alvarez/null-ls.nvim",
     requires = { "nvim-lua/plenary.nvim" },
  })

  use 'onsails/lspkind.nvim'

  use 'ellisonleao/gruvbox.nvim'

  use 'airblade/vim-gitgutter'

  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'

  use {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require'hop'.setup {}
    end
  }

  use { 'junegunn/fzf', run = ":call fzf#install()" }
  use 'junegunn/fzf.vim'

  use {'kevinhwang91/nvim-bqf', ft = 'qf'}

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require'nvim-treesitter.configs'.setup {
        highlight = {
          enable = true,
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
      }
    end
  }

  use {
    "scalameta/nvim-metals",
    requires = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
  }

  use {
       "hrsh7th/nvim-cmp",
       config = function() require('config.cmp') end,
       requires = {
           "hrsh7th/cmp-buffer",
           "hrsh7th/cmp-nvim-lsp",
           'hrsh7th/cmp-path',
           'hrsh7th/cmp-cmdline',
           'hrsh7th/cmp-vsnip'
       }
  }

  use 'L3MON4D3/LuaSnip'
end)
