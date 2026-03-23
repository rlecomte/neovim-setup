vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('plugins')
require('config.cmp')
require('config.lspconfig')
require('config.lualine')
require('config.lspkind')

-- General
vim.opt.compatible = false
vim.opt.backspace = { 'indent', 'eol', 'start' }
vim.opt.history = 1000
vim.opt.showcmd = true
vim.opt.showmode = true
vim.opt.autoread = true
vim.opt.hidden = true
vim.opt.updatetime = 400
vim.opt.modifiable = true

-- Interface
vim.opt.laststatus = 2
vim.opt.ruler = true
vim.opt.wildmenu = true
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.title = true

-- Indentation
vim.cmd('filetype plugin indent on')
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- Search
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Text
vim.opt.fileencoding = 'utf-8'
vim.opt.linebreak = true
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 5
vim.cmd('syntax enable')

-- Miscellaneous
vim.opt.confirm = true
vim.opt.modeline = false
vim.opt.nrformats:remove('octal')

-- Clipboard
vim.opt.clipboard = 'unnamedplus'
vim.keymap.set('v', '<C-c>', '"+y', { noremap = true })
vim.opt.termguicolors = true

vim.opt.tags = 'tags;'

-- Remap escape in insert mode
vim.keymap.set('i', 'jj', '<Esc>', { noremap = true })

-- Jump to last position when reopening a file
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)
    if mark[1] > 1 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

-- Theme
vim.opt.background = 'dark'
vim.cmd('colorscheme gruvbox')
vim.api.nvim_set_hl(0, 'LineNr', { fg = 'DarkGrey', bold = false })

-- Netrw
vim.g.netrw_banner = 0
vim.keymap.set('n', '<C-e>', ':Oil<CR>', { noremap = true })

-- Highlight extra whitespace
vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    vim.api.nvim_set_hl(0, 'ExtraWhitespace', { bg = 'red' })
  end,
})

-- Filetype-specific indentation
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'javascript', 'json', 'yaml', 'sql' },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

-- Trim trailing whitespace on save
vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function()
    local save = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.winrestview(save)
  end,
})

-- Open in Firefox
vim.keymap.set('n', '<F12>f', ':silent !firefox %<CR>', { noremap = true })
