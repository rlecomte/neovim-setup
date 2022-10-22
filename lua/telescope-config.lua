local builtin = require('telescope.builtin')
local ts = require("telescope")

vim.keymap.set('n', '<C-t>', builtin.git_files, {})
vim.keymap.set('n', '<C-d>', builtin.live_grep, {})
vim.keymap.set('n', '<C-n>', builtin.oldfiles, {})
vim.keymap.set('n', '<C-r>', builtin.grep_string, {})
vim.keymap.set('n', '<C-l>', builtin.spell_suggest, {})
vim.keymap.set('n', '<C-y>', ts.extensions.metals.commands, {})


