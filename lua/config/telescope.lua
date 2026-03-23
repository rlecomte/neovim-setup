local telescope = require("telescope")
telescope.setup {
  defaults = {
		path_display={"smart"},
  },
  pickers = {
    find_files = {
      theme = "dropdown",
    },
    oldfiles = {
      theme = "dropdown",
    },
    live_grep = {
      theme = "dropdown",
    }
  },
  path_display= { "truncate" }
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-t>', builtin.git_files, {})
vim.keymap.set('n', '<C-n>', builtin.oldfiles, {})
vim.keymap.set('n', '<C-d>', builtin.live_grep, {})
