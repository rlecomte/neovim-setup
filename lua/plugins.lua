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

  use 'airblade/vim-gitgutter'

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

  use { 'junegunn/fzf', run = ":call fzf#install()" }
  use 'junegunn/fzf.vim'

  use {'kevinhwang91/nvim-bqf', ft = 'qf'}

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
    'L3MON4D3/LuaSnip',
    after = 'nvim-cmp',
    tag = "v<CurrentMajor>.*",
    config = function() require('config.snippets') end,
  }

  use {
    "scalameta/nvim-metals",
    requires = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
  }

  use {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require'hop'.setup {
        vim.keymap.set('n', '<C-c>', require('hop').hint_words, {})
      }
    end
  }

  --use { "nvim-telescope/telescope-file-browser.nvim" }

  --use {
  --  'nvim-telescope/telescope.nvim', tag = '0.1.0',
  --  requires = { 'nvim-lua/plenary.nvim' },
  --  config = function()
  --    require('telescope').setup{
  --       defaults = {
  --          path_display={"smart"}
  --       },
  --      },
  --  end
  --}

  --use {
  --  'nvim-telescope/telescope-fzf-native.nvim',
  --  run = 'make',
  --  config = function()
  --    require('telescope').load_extension('fzf')
  --  end
  --}

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
