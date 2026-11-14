return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  },

  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    config = function()
      require("neogit").setup({
        kind = "split",
        mappings = {
          status = {
            ["t"] = "MoveDown",   -- BEPO: t = j (down)
            ["s"] = "MoveUp",     -- BEPO: s = k (up)
            ["j"] = "Stage",
            ["k"] = false,
          },
        },
      })
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPost",
    keys = {
      { "]h", function() require("gitsigns").nav_hunk("next") end, desc = "Next hunk" },
      { "[h", function() require("gitsigns").nav_hunk("prev") end, desc = "Prev hunk" },
      { "<leader>hs", function() require("gitsigns").stage_hunk() end, desc = "Stage hunk" },
      { "<leader>hr", function() require("gitsigns").reset_hunk() end, desc = "Reset hunk" },
      { "<leader>hp", function() require("gitsigns").preview_hunk() end, desc = "Preview hunk" },
      { "<leader>hb", function() require("gitsigns").blame_line({ full = true }) end, desc = "Blame line" },
    },
    opts = {
      current_line_blame = true,
    },
  },
}
