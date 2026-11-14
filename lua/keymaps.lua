local map = vim.keymap.set

-- General
map("v", "<C-c>", '"+y', { noremap = true })
map("i", "jj", "<Esc>", { noremap = true })
map("n", "<C-e>", ":Oil<CR>", { noremap = true })
map("n", "<F12>f", ":silent !firefox %<CR>", { noremap = true })

-- BEPO layout: [HJKL] -> {CTSR}
-- {cr} = gauche / droite
map({"n", "x", "o"}, "c", "h", { noremap = true })
map({"n", "x", "o"}, "r", "l", { noremap = true })
-- {ts} = haut / bas
map({"n", "x", "o"}, "t", "j", { noremap = true })
map({"n", "x", "o"}, "s", "k", { noremap = true })
-- {CR} = haut / bas de l'ecran
map({"n", "x", "o"}, "C", "H", { noremap = true })
map({"n", "x", "o"}, "R", "L", { noremap = true })
-- {TS} = joindre / aide
map({"n", "x", "o"}, "T", "J", { noremap = true })
map({"n", "x", "o"}, "S", "K", { noremap = true })
-- Corollaire : repli suivant / precedent
map({"n", "x", "o"}, "zs", "zj", { noremap = true })
map({"n", "x", "o"}, "zt", "zk", { noremap = true })

-- {HJKL} <- [CTSR]
-- {J} = Jusqu'a
map({"n", "x", "o"}, "j", "t", { noremap = true })
map({"n", "x", "o"}, "J", "T", { noremap = true })
-- {L} = Change
map({"n", "x", "o"}, "l", "c", { noremap = true })
map({"n", "x", "o"}, "L", "C", { noremap = true })
-- {H} = Remplace
map({"n", "x", "o"}, "h", "r", { noremap = true })
map({"n", "x", "o"}, "H", "R", { noremap = true })
-- {K} = Substitue
map({"n", "x", "o"}, "k", "s", { noremap = true })
map({"n", "x", "o"}, "K", "S", { noremap = true })
-- Corollaire : correction orthographique
map({"n", "x", "o"}, "]k", "]s", { noremap = true })
map({"n", "x", "o"}, "[k", "[s", { noremap = true })

-- Desambiguation de {g}
map({"n", "x", "o"}, "gs", "gk", { noremap = true })
map({"n", "x", "o"}, "gt", "gj", { noremap = true })
-- onglet precedent / suivant
map("n", "gb", "gT", { noremap = true })
map("n", "gé", "gt", { noremap = true })
map("n", "gB", ":exe 'silent! tabfirst'<CR>", { noremap = true })
map("n", "gÉ", ":exe 'silent! tablast'<CR>", { noremap = true })
-- debut de la ligne ecran
map({"n", "x", "o"}, 'g"', "g0", { noremap = true })

-- <> en direct
map({"n", "x", "o"}, "«", "<", { noremap = true })
map({"n", "x", "o"}, "»", ">", { noremap = true })

-- Gestion des fenetres
map("n", "w", "<C-w>", { noremap = true })
map("n", "W", "<C-w><C-w>", { noremap = true })
map("n", "wt", "<C-w>j", { noremap = true })
map("n", "ws", "<C-w>k", { noremap = true })
map("n", "wc", "<C-w>h", { noremap = true })
map("n", "wr", "<C-w>l", { noremap = true })
map("n", "wd", "<C-w>c", { noremap = true })
map("n", "wo", "<C-w>s", { noremap = true })
map("n", "wp", "<C-w>o", { noremap = true })
map("n", "w<SPACE>", ":split<CR>", { noremap = true })
map("n", "w<CR>", ":vsplit<CR>", { noremap = true })

-- Autohighlight toggle (z/ to toggle)
map("n", "z/", function()
  if vim.b.auto_highlight then
    vim.fn.setreg("/", "")
    vim.b.auto_highlight = false
    if vim.b.auto_highlight_group then
      vim.api.nvim_del_augroup_by_id(vim.b.auto_highlight_group)
      vim.b.auto_highlight_group = nil
    end
    vim.opt_local.updatetime = 4000
    print("Highlight current word: off")
  else
    local group = vim.api.nvim_create_augroup("auto_highlight_" .. vim.api.nvim_get_current_buf(), { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", {
      group = group,
      buffer = 0,
      callback = function()
        local word = vim.fn.expand("<cword>")
        vim.fn.setreg("/", "\\V\\<" .. vim.fn.escape(word, "\\") .. "\\>")
      end,
    })
    vim.b.auto_highlight = true
    vim.b.auto_highlight_group = group
    vim.opt_local.updatetime = 500
    vim.opt.hlsearch = true
    print("Highlight current word: ON")
  end
end, { noremap = true })
