return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      -- Diagnostics (global: work in any buffer)
      { "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, desc = "Previous diagnostic" },
      { "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, desc = "Next diagnostic" },
      { "<leader>e", vim.diagnostic.open_float, desc = "Open diagnostic float" },
      { "<leader>ql", vim.diagnostic.setloclist, desc = "Diagnostics" },
      { "<leader>qa", vim.diagnostic.setqflist, desc = "All diagnostics" },
      { "<leader>qw", function() vim.diagnostic.setqflist({ severity = "W" }) end, desc = "Warning diagnostics" },
      { "<leader>qe", function() vim.diagnostic.setqflist({ severity = "E" }) end, desc = "Error diagnostics" },
    },
    config = function()
      -- LSP mappings: buffer-local, only where a language server is attached
      -- (also applies to metals, which is started by nvim-metals)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
        callback = function(args)
          local function bmap(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = args.buf, desc = desc })
          end
          bmap("gD", vim.lsp.buf.declaration, "Go to declaration")
          bmap("gd", vim.lsp.buf.definition, "Go to definition")
          bmap("gh", vim.lsp.buf.hover, "Hover documentation")
          bmap("gi", vim.lsp.buf.implementation, "Go to implementation")
          bmap("gr", "<cmd>Telescope lsp_references<cr>", "Find references")
          bmap("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
          bmap("<leader>rf", vim.lsp.buf.format, "Format buffer")
          bmap("<leader>ca", vim.lsp.buf.code_action, "Code action")
          bmap("<leader>sh", vim.lsp.buf.signature_help, "Signature help")
        end,
      })

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
      -- metals is started by nvim-metals (see plugins/metals.lua), not here
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
