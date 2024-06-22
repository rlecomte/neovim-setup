local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-t>', builtin.find_files, {})
vim.keymap.set('n', '<C-n>', builtin.oldfiles, {})
vim.keymap.set('n', '<C-d>', builtin.live_grep, {})
