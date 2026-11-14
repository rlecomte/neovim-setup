return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    keys = {
      -- LSP mappings
      { "gD", vim.lsp.buf.declaration, desc = "Go to declaration" },
      { "gd", vim.lsp.buf.definition, desc = "Go to definition" },
      { "gh", vim.lsp.buf.hover, desc = "Hover documentation" },
      { "gi", vim.lsp.buf.implementation, desc = "Go to implementation" },
      { "gr", "<cmd>Telescope lsp_references<cr>", desc = "Find references" },
      { "<leader>rn", vim.lsp.buf.rename, desc = "Rename symbol" },
      { "<leader>rf", vim.lsp.buf.format, desc = "Format buffer" },
      { "<leader>ca", vim.lsp.buf.code_action, desc = "Code action" },
      { "<leader>sh", vim.lsp.buf.signature_help, desc = "Signature help" },

      -- Diagnostics
      { "[d", vim.diagnostic.goto_prev, desc = "Previous diagnostic" },
      { "]d", vim.diagnostic.goto_next, desc = "Next diagnostic" },
      { "<leader>e", vim.diagnostic.open_float, desc = "Open diagnostic float" },
      { "<leader>ql", vim.diagnostic.setloclist, desc = "Diagnostics" },
      { "<leader>qa", vim.diagnostic.setqflist, desc = "All diagnostics" },
      { "<leader>qw", function() vim.diagnostic.setqflist({ severity = "W" }) end, desc = "Warning diagnostics" },
      { "<leader>qe", function() vim.diagnostic.setqflist({ severity = "E" }) end, desc = "Warning diagnostics" },
    },
    config = function()

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Lua LSP
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
              path ~= vim.fn.stdpath("config")
              and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
            then
              return
            end
          end
          client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
            runtime = {
              version = "LuaJIT",
              path = { "lua/?.lua", "lua/?/init.lua" },
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
      vim.lsp.config("rust_analyzer", {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end,
        settings = {
          ["rust-analyzer"] = {
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
      vim.lsp.config("gopls", {
        capabilities = capabilities,
      })

      -- Pyright
      vim.lsp.config("pyright", {
        capabilities = capabilities,
      })

      -- Mason
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "rust_analyzer", "gopls", "pyright" },
      })

      -- Enable LSP servers
      vim.lsp.enable("lua_ls")
      vim.lsp.enable("rust_analyzer")
      vim.lsp.enable("gopls")
      vim.lsp.enable("pyright")
      vim.lsp.enable("pyright")
      vim.lsp.enable("metals")
    end,
  },

  {
    "onsails/lspkind.nvim",
    config = function()
      require("lspkind").init({
        mode = "symbol_text",
        preset = "codicons",
        -- override preset symbols
        --
        -- default: {}
        symbol_map = {
          Text = "󰉿",
          Method = "󰆧",
          Function = "󰊕",
          Constructor = "",
          Field = "󰜢",
          Variable = "󰀫",
          Class = "󰠱",
          Interface = "",
          Module = "",
          Property = "󰜢",
          Unit = "󰑭",
          Value = "󰎠",
          Enum = "",
          Keyword = "󰌋",
          Snippet = "",
          Color = "󰏘",
          File = "󰈙",
          Reference = "󰈇",
          Folder = "󰉋",
          EnumMember = "",
          Constant = "󰏿",
          Struct = "󰙅",
          Event = "",
          Operator = "󰆕",
          TypeParameter = "",
        },
      })
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-vsnip",
    },
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")

      vim.opt_global.completeopt = { "menuone", "noinsert", "noselect" }

      cmp.setup({
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol",
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end,
          ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end,
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })

      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "cmp_git" },
        }, {
          { name = "buffer" },
        }),
      })

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "cmdline" },
        }),
      })
    end,
  },
}
