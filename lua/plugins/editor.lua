return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "python", "go", "scala", "java", "bash", "json", "yaml", "markdown" },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      })
    end,
  },

  { "echasnovski/mini.nvim", version = "*" },

  {
    "numToStr/Comment.nvim",
    event = "BufReadPost",
    opts = {},
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  { "https://github.com/Weyaaron/nvim-training", pin = true, opts = {} },
}
