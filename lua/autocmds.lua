-- Jump to last position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)
    if mark[1] > 1 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

-- Highlight extra whitespace
-- The colorscheme is already applied when this file runs, so set the group now
-- and re-apply it on every later colorscheme change.
local function set_extra_ws_hl()
  vim.api.nvim_set_hl(0, "ExtraWhitespace", { bg = "red" })
end
set_extra_ws_hl()
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_extra_ws_hl })

-- Show trailing whitespace in normal file buffers only (not terminals, plugin UIs...),
-- and don't flag the spot being typed at in insert mode.
local extra_ws_group = vim.api.nvim_create_augroup("extra-whitespace", { clear = true })
local function set_extra_ws_match(pattern)
  if vim.w.extra_ws_match then
    pcall(vim.fn.matchdelete, vim.w.extra_ws_match)
    vim.w.extra_ws_match = nil
  end
  if vim.bo.buftype == "" and vim.bo.modifiable then
    vim.w.extra_ws_match = vim.fn.matchadd("ExtraWhitespace", pattern)
  end
end
vim.api.nvim_create_autocmd({ "BufWinEnter", "InsertLeave" }, {
  group = extra_ws_group,
  callback = function() set_extra_ws_match([[\s\+$]]) end,
})
vim.api.nvim_create_autocmd("InsertEnter", {
  group = extra_ws_group,
  callback = function() set_extra_ws_match([[\s\+\%#\@<!$]]) end,
})

-- Trim trailing whitespace on save
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   callback = function()
--     local save = vim.fn.winsaveview()
--     vim.cmd([[%s/\s\+$//e]])
--     vim.fn.winrestview(save)
--   end,
-- })

-- Netrw BEPO fix
vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    vim.keymap.set("n", "t", "j", { buffer = true, noremap = true })
    vim.keymap.set("n", "s", "k", { buffer = true, noremap = true })
    vim.keymap.set("n", "k", "s", { buffer = true, noremap = true })
  end,
})
