-- Only options that differ from Neovim's defaults
-- (compatible, backspace, showcmd, autoread, hidden, laststatus, wildmenu, incsearch,
-- hlsearch, autoindent, filetype/syntax on, ... are already the defaults)

-- General
vim.opt.updatetime = 400

-- Interface
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.signcolumn = "yes" -- always shown, so text doesn't shift when git/diagnostic signs appear
vim.opt.mouse = "a"
vim.opt.title = true
vim.opt.winborder = "rounded" -- border on all floating windows (hover, diagnostics...)

-- Indentation
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Text
vim.opt.linebreak = true
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 5

-- Miscellaneous
vim.opt.confirm = true
vim.opt.modeline = false

-- Diagnostics: message at the end of the cursor line only (most severe one, single
-- line, nothing inserted); other lines keep just the underline and the sign
vim.diagnostic.config({
  virtual_text = { current_line = true },
  severity_sort = true,
})

-- Clipboard
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true

vim.opt.tags = "tags;"
