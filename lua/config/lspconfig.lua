-- Global diagnostic keymaps (work everywhere)
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Shared on_attach: LSP keymaps only active in buffers with a language server
local on_attach = function(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.format, bufopts)
  vim.keymap.set('n', '<space>sh', vim.lsp.buf.signature_help, bufopts)
end

-- Capabilities for completion
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Lua LSP
vim.lsp.config('lua_ls', {
  capabilities = capabilities,
  on_attach = on_attach,
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
        path ~= vim.fn.stdpath('config')
        and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
      then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        version = 'LuaJIT',
        path = { 'lua/?.lua', 'lua/?/init.lua' },
      },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME },
      },
    })
  end,
  settings = { Lua = {} },
})

-- Rust Analyzer
vim.lsp.config('rust_analyzer', {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end,
  settings = {
    ['rust-analyzer'] = {
      diagnostics = { enable = false },
      imports = {
        granularity = { group = "module" },
        prefix = "self",
      },
      cargo = { buildScripts = { enable = true } },
      procMacro = { enable = true },
    },
  },
})

-- Gopls
vim.lsp.config('gopls', {
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Pyright
vim.lsp.config('pyright', {
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Mason
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "rust_analyzer", "gopls", "pyright" },
})

-- Enable LSP servers
vim.lsp.enable('lua_ls')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('gopls')
vim.lsp.enable('pyright')