return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.background = "dark"
      vim.cmd("colorscheme gruvbox")
      vim.api.nvim_set_hl(0, "LineNr", { fg = "DarkGrey", bold = false })
    end,
  },

  "nvim-tree/nvim-web-devicons",

  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = { theme = "gruvbox" },
        sections = {
          lualine_c = {
            { "filename", path = 1 },
          },
        },
      })
    end,
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
