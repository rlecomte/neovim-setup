local map = vim.keymap.set

-- General
map("v", "<C-c>", '"+y', { noremap = true })
map("i", "jj", "<Esc>", { noremap = true })
map("n", "<C-e>", ":Oil<CR>", { noremap = true })
map("n", "<F12>f", ":silent !firefox %<CR>", { noremap = true })

-- BEPO layout: [HJKL] -> {CTSR}
-- {cr} = gauche / droite
map({"n", "v"}, "c", "h", { noremap = true })
map({"n", "v"}, "r", "l", { noremap = true })
-- {ts} = haut / bas
map({"n", "v"}, "t", "j", { noremap = true })
map({"n", "v"}, "s", "k", { noremap = true })
-- {CR} = haut / bas de l'ecran
map({"n", "v"}, "C", "H", { noremap = true })
map({"n", "v"}, "R", "L", { noremap = true })
-- {TS} = joindre / aide
map({"n", "v"}, "T", "J", { noremap = true })
map({"n", "v"}, "S", "K", { noremap = true })
-- Corollaire : repli suivant / precedent
map({"n", "v"}, "zs", "zj", { noremap = true })
map({"n", "v"}, "zt", "zk", { noremap = true })

-- {HJKL} <- [CTSR]
-- {J} = Jusqu'a
map({"n", "v"}, "j", "t", { noremap = true })
map({"n", "v"}, "J", "T", { noremap = true })
-- {L} = Change
map({"n", "v"}, "l", "c", { noremap = true })
map({"n", "v"}, "L", "C", { noremap = true })
-- {H} = Remplace
map({"n", "v"}, "h", "r", { noremap = true })
map({"n", "v"}, "H", "R", { noremap = true })
-- {K} = Substitue
map({"n", "v"}, "k", "s", { noremap = true })
map({"n", "v"}, "K", "S", { noremap = true })
-- Corollaire : correction orthographique
map({"n", "v"}, "]k", "]s", { noremap = true })
map({"n", "v"}, "[k", "[s", { noremap = true })

-- Desambiguation de {g}
map({"n", "v"}, "gs", "gk", { noremap = true })
map({"n", "v"}, "gt", "gj", { noremap = true })
-- onglet precedent / suivant
map("n", "gb", "gT", { noremap = true })
map("n", "gé", "gt", { noremap = true })
map("n", "gB", ":exe 'silent! tabfirst'<CR>", { noremap = true })
map("n", "gÉ", ":exe 'silent! tablast'<CR>", { noremap = true })
-- debut de la ligne ecran
map({"n", "v"}, 'g"', "g0", { noremap = true })

-- <> en direct
map({"n", "v"}, "«", "<", { noremap = true })
map({"n", "v"}, "»", ">", { noremap = true })

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
