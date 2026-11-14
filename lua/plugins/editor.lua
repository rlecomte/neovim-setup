return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- "main" = rewrite: needs Neovim >= 0.12 and tree-sitter-cli; does not support lazy-loading
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      -- Async, no-op for parsers that are already installed
      require("nvim-treesitter").install({
        "lua", "python", "go", "scala", "java", "bash", "json", "yaml", "markdown", "markdown_inline",
      })

      -- Highlighting is provided by Neovim itself: start it for every buffer whose
      -- filetype has an installed parser (silently skipped otherwise)
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("user-treesitter", { clear = true }),
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
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
