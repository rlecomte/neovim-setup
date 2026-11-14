-- General
vim.opt.compatible = false
vim.opt.backspace = { "indent", "eol", "start" }
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
vim.opt.mouse = "a"
vim.opt.title = true

-- Indentation
vim.cmd("filetype plugin indent on")
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
vim.opt.fileencoding = "utf-8"
vim.opt.linebreak = true
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 5
vim.cmd("syntax enable")

-- Miscellaneous
vim.opt.confirm = true
vim.opt.modeline = false
vim.opt.nrformats:remove("octal")

-- Clipboard
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true

vim.opt.tags = "tags;"

-- Netrw
vim.g.netrw_banner = 0
