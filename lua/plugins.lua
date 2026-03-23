local map = vim.keymap.set

require("lazy").setup({
  "nvim-lua/plenary.nvim",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",

  "neovim/nvim-lspconfig",
  "onsails/lspkind.nvim",

  "ellisonleao/gruvbox.nvim",
  "kyazdani42/nvim-web-devicons",
  "nvim-lualine/lualine.nvim",
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<C-t>", function() require("telescope.builtin").git_files() end, desc = "Git files" },
      { "<C-n>", function() require("telescope.builtin").oldfiles() end, desc = "Recent files" },
      { "<C-d>", function() require("telescope.builtin").live_grep() end, desc = "Live grep" },
    },
    config = function()
      require("telescope").setup({
        defaults = { path_display = { "smart" } },
        pickers = {
          find_files = { theme = "dropdown" },
          oldfiles = { theme = "dropdown" },
          live_grep = { theme = "dropdown" },
        },
      })
    end,
  },
  {
    "phaazon/hop.nvim",
    branch = "v2",
    keys = {
      { "<C-c>", function() require("hop").hint_words() end, desc = "Hop to word" },
    },
    config = function()
      require("hop").setup({})
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "python", "go", "scala", "java", "bash", "json", "yaml", "markdown" },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      })
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

  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  },
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    config = function()
      require("neogit").setup({
        kind = "split",
        mappings = {
          status = {
            ["t"] = "MoveDown",   -- BÉPO: t = j (down)
            ["s"] = "MoveUp",     -- BÉPO: s = k (up)
            ["j"] = "Stage",
            ["k"] = false,
          },
        },
      })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPost",
    config = function()
      require("gitsigns").setup({
        current_line_blame = true,
        on_attach = function(bufnr)
          local gs = require("gitsigns")
          local function bmap(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end
          bmap('n', ']h', gs.next_hunk)
          bmap('n', '[h', gs.prev_hunk)
          bmap('n', '<leader>hs', gs.stage_hunk)
          bmap('n', '<leader>hr', gs.reset_hunk)
          bmap('n', '<leader>hp', gs.preview_hunk)
          bmap('n', '<leader>hb', function() gs.blame_line({ full = true }) end)
        end,
      })
    end,
  },

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
          --sbtScript = "sbt",
          showImplicitArguments = true,
          --excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
          serverVersion = "1.6.6",
          --defaultBspToBuildTool = "true",
          autoImportBuild = "all",
          verboseCompilation = "true",
          --fallbackScalaVersion = "3.6.4",
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
        event = "BufReadPost",
        opts = {},
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
    },


    {
      "coder/claudecode.nvim",
      lazy = false,
      dependencies = { "folke/snacks.nvim" },
      config = true,
      keys = {
        -- Your keymaps here
        { "<leader>a", nil, desc = "AI/Claude Code" },
        { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
        { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
        { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
        { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
        { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
        { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
        { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
        {
          "<leader>as",
          "<cmd>ClaudeCodeTreeAdd<cr>",
          desc = "Add file",
          ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
        },

        -- Diff management
        { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
        { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
      },
  },

  -- Keymap discoverability
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- Auto-close brackets/quotes
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local autopairs = require("nvim-autopairs")
      autopairs.setup({})
      -- Integrate with cmp
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
})
