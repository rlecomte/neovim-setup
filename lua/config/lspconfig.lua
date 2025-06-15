require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls", "rust_analyzer", "gopls" }
}

local api = vim.api

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  vim.opt_global.completeopt = { "menuone", "noinsert", "noselect" }
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }

  vim.keymap.set("n", "gd", vim.lsp.buf.definition)
  vim.keymap.set("n", "K", vim.lsp.buf.hover)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
  vim.keymap.set("n", "gr", vim.lsp.buf.references)
  vim.keymap.set("n", "gds", vim.lsp.buf.document_symbol)
  vim.keymap.set("n", "gws", vim.lsp.buf.workspace_symbol)
  vim.keymap.set("n", "<space>cl", vim.lsp.codelens.run)
  vim.keymap.set("n", "<space>sh", vim.lsp.buf.signature_help)
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename)
  vim.keymap.set("n", "<space>f", vim.lsp.buf.format)
  vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action)

  --vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  --vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  --vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  --vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  --vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  --vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  --vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  --vim.keymap.set('n', '<space>wl', function()
  --  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  --end, bufopts)
  --vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  --vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  --vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  --vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  --vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  --vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  --vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  --vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  --vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
end

local lspconfig = require('lspconfig')
local util = require('lspconfig/util')
local c = vim.lsp.protocol.make_client_capabilities()
c.textDocument.completion.completionItem.snippetSupport = true
c.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
    },
}
local capabilities = require("cmp_nvim_lsp").default_capabilities(c)

-- Lua LSP Setup
require'lspconfig'.lua_ls.setup{}

-- Go LSP Setup
require'lspconfig'.gopls.setup{}

----------------------------------
-- Scala LSP Setup ---------------
----------------------------------
--local metals_config = require("metals").bare_config()
--metals_config.init_options.statusBarProvider = "on"
--
---- Example of settings
--metals_config.settings = {
--  excludedPackages = {
--    "akka.actor.typed.javadsl",
--    "com.github.swagger.akka.javadsl",
--    "sttp.tapir.EndpointIO.annotations",
--    "*.java"
--  },
--  bloopVersion = "2.0.2",
--  serverVersion = "1.3.5+104-362fce59-SNAPSHOT",
--  autoImportBuild = "all",
--  verboseCompilation = true,
--  serverProperties = {
--    "-Xmx16G",
--    "-Dmetals.enable-best-effort=false"
--  }
--}
----"-Dmetals.enable-best-effort=true"
--
--metals_config.on_attach = on_attach
--
---- Autocmd that will actually be in charging of starting the whole thing
--local nvim_metals_group = api.nvim_create_augroup("nvim-metals", { clear = true })
--api.nvim_create_autocmd("FileType", {
--  -- NOTE: You may or may not want java included here. You will need it if you
--  -- want basic Java support but it may also conflict if you are using
--  -- something like nvim-jdtls which also works on a java filetype autocmd.
--  pattern = { "scala", "sbt", "java", "sc" },
--  callback = function()
--    require("metals").initialize_or_attach(metals_config)
--  end,
--  group = nvim_metals_group,
--})
--
--metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
