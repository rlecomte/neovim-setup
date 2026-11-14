return {
  {
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
    config = function()
      -- Settings are globals read when the colorscheme loads
      vim.g.everforest_background = "hard" -- contrast: "hard" | "medium" | "soft"
      vim.g.everforest_better_performance = 1
      vim.opt.background = "dark" -- "light" for the light variant
      vim.cmd("colorscheme everforest")
    end,
  },

  "nvim-tree/nvim-web-devicons",

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
