return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<C-t>", function() require("telescope.builtin").git_files() end, desc = "Git files" },
      { "<C-n>", function() require("telescope.builtin").oldfiles() end, desc = "Recent files" },
      { "<C-d>", function() require("telescope.builtin").live_grep() end, desc = "Live grep" },
    },
    config = function()
      require("telescope").setup({
        defaults = { path_display = { "smart" } },
        -- Compact dropdown for file pickers (the name is enough); live_grep keeps the
        -- default layout so the preview shows the context around each match
        pickers = {
          git_files = { theme = "dropdown" },
          oldfiles = { theme = "dropdown" },
        },
      })
    end,
  },

  {
    "smoka7/hop.nvim",
    keys = {
      { "<C-c>", function() require("hop").hint_words() end, desc = "Hop to word" },
    },
    config = function()
      require("hop").setup({})
    end,
  },

  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup({
        keymaps = {
          ["<C-t>"] = false,
        },
        view_options = {
          show_hidden = true,
        },
      })
    end,
  },
}
