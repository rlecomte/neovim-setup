require("lazy").setup({
  "nvim-lua/plenary.nvim",

  "neovim/nvim-lspconfig",
  "onsails/lspkind.nvim",
  "nvimtools/none-ls.nvim",

  "ellisonleao/gruvbox.nvim",
  "kyazdani42/nvim-web-devicons",
  "nvim-lualine/lualine.nvim",
  { "nvim-telescope/telescope.nvim", tag = "0.1.8" },
  { "phaazon/hop.nvim",
    branch = "v2",
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require'hop'.setup {}
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require"nvim-treesitter.configs".setup {
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
  },
  {
    "stevearc/oil.nvim",
    config = function()
      require('oil').setup({
        keymaps = {
          ["<C-t>"] = false,
        },
        view_options = {
          -- Show files and directories that start with "."
          show_hidden = true
        }
      })
    end
  },
  {
       "hrsh7th/nvim-cmp",
       config = function() require("config.cmp") end,
       dependencies = {
           "hrsh7th/cmp-buffer",
           "hrsh7th/cmp-nvim-lsp",
           "hrsh7th/cmp-path",
           "hrsh7th/cmp-cmdline",
           "hrsh7th/cmp-vsnip"
       }
  },
  { "L3MON4D3/LuaSnip", tag = "v2.*" },

  "sindrets/diffview.nvim",
  "airblade/vim-gitgutter",
  {
    "NeogitOrg/neogit",
    config = function()
      require("neogit").setup({})
    end
  },
  "f-person/git-blame.nvim",

  "scalameta/nvim-metals"
})
