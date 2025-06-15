local map = vim.keymap.set
local fn = vim.fn

require("lazy").setup({
  "nvim-lua/plenary.nvim",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",

  "neovim/nvim-lspconfig",
  "onsails/lspkind.nvim",
  "nvimtools/none-ls.nvim",

  "ellisonleao/gruvbox.nvim",
  "kyazdani42/nvim-web-devicons",
  "nvim-lualine/lualine.nvim",
  { "nvim-telescope/telescope.nvim", tag = "0.1.8" },
  { "phaazon/hop.nvim",
    branch = "v2",
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require'hop'.setup {}
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require"nvim-treesitter.configs".setup {
        highlight = {
          enable = true,
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
      }
    end
  },
  { 'echasnovski/mini.nvim', version = '*' },
  {
    "stevearc/oil.nvim",
    config = function()
      require('oil').setup({
        keymaps = {
          ["<C-t>"] = false,
        },
        view_options = {
          -- Show files and directories that start with "."
          show_hidden = true
        }
      })
    end
  },
  {
       "hrsh7th/nvim-cmp",
       config = function() require("config.cmp") end,
       dependencies = {
           "hrsh7th/cmp-buffer",
           "hrsh7th/cmp-nvim-lsp",
           "hrsh7th/cmp-path",
           "hrsh7th/cmp-cmdline",
           "hrsh7th/cmp-vsnip"
       }
  },

  "sindrets/diffview.nvim",
  "airblade/vim-gitgutter",
  {
    "NeogitOrg/neogit",
    config = function()
      require("neogit").setup({})
    end
  },
  "f-person/git-blame.nvim",

  {
      "scalameta/nvim-metals",
      dependencies = {
        "nvim-lua/plenary.nvim",
        {
          "j-hui/fidget.nvim",
          opts = {},
        },
        {
          "mfussenegger/nvim-dap",
          config = function(self, opts)
            -- Debug settings if you're using nvim-dap
            local dap = require("dap")

            dap.configurations.scala = {
              {
                type = "scala",
                request = "launch",
                name = "RunOrTest",
                metals = {
                  runType = "runOrTestFile",
                  --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
                },
              },
              {
                type = "scala",
                request = "launch",
                name = "Test Target",
                metals = {
                  runType = "testTarget",
                },
              },
            }
          end
        },
      },
      ft = { "scala", "sc", "sbt", "java" },
      opts = function()
        local metals_config = require("metals").bare_config()

        -- Example of settings
        metals_config.settings = {
          showImplicitArguments = true,
          excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
          serverVersion = "1.5.1",
          defaultBspToBuildTool = "false",
          autoImportBuild = "all",
          verboseCompilation = "true",
          fallbackScalaVersion = "3.6.4",
        }

        -- *READ THIS*
        -- I *highly* recommend setting statusBarProvider to either "off" or "on"
        --
        -- "off" will enable LSP progress notifications by Metals and you'll need
        -- to ensure you have a plugin like fidget.nvim installed to handle them.
        --
        -- "on" will enable the custom Metals status extension and you *have* to have
        -- a have settings to capture this in your statusline or else you'll not see
        -- any messages from metals. There is more info in the help docs about this
        metals_config.init_options.statusBarProvider = "off"

        -- Example if you are using cmp how to make sure the correct capabilities for snippets are set
        metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

        metals_config.on_attach = function(client, bufnr)
          require("metals").setup_dap()

          -- LSP mappings
          map("n", "gD", vim.lsp.buf.definition)
          map("n", "K", vim.lsp.buf.hover)
          map("n", "gi", vim.lsp.buf.implementation)
          map("n", "gr", vim.lsp.buf.references)
          map("n", "gds", vim.lsp.buf.document_symbol)
          map("n", "gws", vim.lsp.buf.workspace_symbol)
          map("n", "<space>cl", vim.lsp.codelens.run)
          map("n", "<space>sh", vim.lsp.buf.signature_help)
          map("n", "<space>rn", vim.lsp.buf.rename)
          map("n", "<space>f", vim.lsp.buf.format)
          map("n", "<space>ca", vim.lsp.buf.code_action)

          map("n", "<space>ws", function()
            require("metals").hover_worksheet()
          end)

          -- all workspace diagnostics
          map("n", "<space>aa", vim.diagnostic.setqflist)

          -- all workspace errors
          map("n", "<space>ae", function()
            vim.diagnostic.setqflist({ severity = "E" })
          end)

          -- all workspace warnings
          map("n", "<space>aw", function()
            vim.diagnostic.setqflist({ severity = "W" })
          end)

          -- buffer diagnostics only
          map("n", "<space>d", vim.diagnostic.setloclist)

          map("n", "[c", function()
            vim.diagnostic.goto_prev({ wrap = false })
          end)

          map("n", "]c", function()
            vim.diagnostic.goto_next({ wrap = false })
          end)

          -- Example mappings for usage with nvim-dap. If you don't use that, you can
          -- skip these
          map("n", "<space>dc", function()
            require("dap").continue()
          end)

          map("n", "<space>dr", function()
            require("dap").repl.toggle()
          end)

          map("n", "<space>dK", function()
            require("dap.ui.widgets").hover()
          end)

          map("n", "<space>dt", function()
            require("dap").toggle_breakpoint()
          end)

          map("n", "<space>dso", function()
            require("dap").step_over()
          end)

          map("n", "<space>dsi", function()
            require("dap").step_into()
          end)

          map("n", "<space>dl", function()
            require("dap").run_last()
          end)
        end

        return metals_config
      end,
      config = function(self, metals_config)
        local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
        vim.api.nvim_create_autocmd("FileType", {
          pattern = self.ft,
          callback = function()
            require("metals").initialize_or_attach(metals_config)
          end,
          group = nvim_metals_group,
        })
      end

    },


    {"https://github.com/Weyaaron/nvim-training", pin= true, opts = {}},

    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        }
    },

    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      event = "InsertEnter",
      config = function()
        require("copilot").setup({
          suggestion = { auto_trigger = true }
        })
      end,
    }
})
