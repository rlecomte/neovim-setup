return {
  {
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
    config = function()
      -- Settings are globals read when the colorscheme loads
      vim.g.everforest_background = "hard" -- contrast: "hard" | "medium" | "soft"
      vim.g.everforest_better_performance = 1
      vim.g.everforest_enable_italic = 1 -- italic keywords (comments are italic by default)
      -- One notch darker than "hard": every background shifted down by one level of
      -- the theme's own palette, so relative contrasts (cursorline, popups...) are kept
      vim.g.everforest_colors_override = {
        bg_dim = { "#1a1e21", "233" },
        bg0 = { "#1e2326", "233" }, -- main background (hard: #272e33)
        bg1 = { "#272e33", "235" },
        bg2 = { "#2e383c", "236" },
        bg3 = { "#374145", "237" },
        bg4 = { "#414b50", "238" },
        bg5 = { "#495156", "239" },
      }
      vim.opt.background = "dark" -- "light" for the light variant
      vim.cmd("colorscheme everforest")
    end,
  },

  "nvim-tree/nvim-web-devicons",

  -- snacks.nvim is also a dependency of claudecode.nvim; this spec only enables
  -- the indent guides module (with the current scope highlighted)
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 900,
    opts = {
      indent = { enabled = true },
    },
  },

  -- Keep the enclosing function/class signature pinned at the top while scrolling
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      max_lines = 3, -- never take more than 3 lines of the screen
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        -- Follow the active colorscheme
        options = { theme = "auto" },
        sections = {
          lualine_c = {
            { "filename", path = 1 },
          },
        },
      })
    end,
  },

  -- LSP progress (indexing...) in the bottom right, for every language server
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {},
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      --icons = {
      --  mappings = false,
      --},
      spec = {
        { "w", group = "Window" },
        { "<leader>h", group = "Git Hunk" },
        { "<leader>a", group = "AI/Claude" },
        { "<space>r", group = "Refactor" },
        { "<space>c", group = "Code" },
        { "<space>d", group = "Debug" },
        { "<space>q", group = "Diagnostics" },
        { "<space>w", group = "Workspace" },
        { "<space>s", group = "Signature" },
      },
    },
  },
}
