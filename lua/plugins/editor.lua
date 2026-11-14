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
        "lua", "python", "go", "rust", "scala", "java", "bash", "json", "yaml", "markdown", "markdown_inline",
      })

      -- Highlighting is provided by Neovim itself. Only start it when the language has
      -- both a parser and a highlights query: vim.treesitter.start() turns off regex
      -- syntax, so starting it without a query would leave the buffer with no colors.
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("user-treesitter", { clear = true }),
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
          if lang and vim.treesitter.language.add(lang) and vim.treesitter.query.get(lang, "highlights") then
            vim.treesitter.start(args.buf, lang)
          end
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
