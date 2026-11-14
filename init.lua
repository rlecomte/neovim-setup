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

if vim.g.vscode then
    -- VSCode extension
  local vscode = require('vscode')
else
    -- ordinary Neovim
require("lazy").setup({ import = "plugins" })
require("options")
require("autocmds")
end

require("keymaps")
