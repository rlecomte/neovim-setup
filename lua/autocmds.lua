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

-- Trim trailing whitespace on save, except in these git repos (matched on the
-- repo root directory name). conduktor-docs: Markdown/MDX where trailing spaces
-- can be meaningful (hard line breaks) and trimming would pollute PR diffs.
local trim_ws_excluded_repos = {
  ["conduktor-docs"] = true,
}

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("trim-trailing-whitespace", { clear = true }),
  callback = function(args)
    if vim.bo[args.buf].buftype ~= "" or not vim.bo[args.buf].modifiable then
      return
    end
    local root = vim.fs.root(args.buf, ".git")
    if root and trim_ws_excluded_repos[vim.fs.basename(root)] then
      return
    end
    local save = vim.fn.winsaveview()
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(save)
  end,
})

-- Netrw BEPO fix
vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    vim.keymap.set("n", "t", "j", { buffer = true, noremap = true })
    vim.keymap.set("n", "s", "k", { buffer = true, noremap = true })
    vim.keymap.set("n", "k", "s", { buffer = true, noremap = true })
  end,
})
