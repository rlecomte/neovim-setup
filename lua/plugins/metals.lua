return {
  {
    "scalameta/nvim-metals",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "mfussenegger/nvim-dap",
        config = function()
          local dap = require("dap")
          dap.configurations.scala = {
            {
              type = "scala",
              request = "launch",
              name = "RunOrTest",
              metals = { runType = "runOrTestFile" },
            },
            {
              type = "scala",
              request = "launch",
              name = "Test Target",
              metals = { runType = "testTarget" },
            },
          }
        end,
      },
    },
    ft = { "scala", "sc", "sbt", "java" },
    keys = {
      -- Metals
      { "<leader>ws", function() require("metals").hover_worksheet() end, desc = "Metals hover worksheet" },

      -- DAP mappings
      { "<leader>dc", function() require("dap").continue() end, desc = "DAP continue" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "DAP toggle REPL" },
      { "<leader>dK", function() require("dap.ui.widgets").hover() end, desc = "DAP hover widgets" },
      { "<leader>dt", function() require("dap").toggle_breakpoint() end, desc = "DAP toggle breakpoint" },
      { "<leader>dso", function() require("dap").step_over() end, desc = "DAP step over" },
      { "<leader>dsi", function() require("dap").step_into() end, desc = "DAP step into" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "DAP run last" },
    },
    opts = function()
      local metals_config = require("metals").bare_config()

      metals_config.settings = {
        showImplicitArguments = true,
        automaticImportBuild = "initial",
        verboseCompilation = true,
        --startMcpServer = true,
        --mcpClient = "claude"
      }

      metals_config.init_options.statusBarProvider = "off"
      metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

      metals_config.on_attach = function(client, bufnr)
        require("metals").setup_dap()
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
    end,
  },
}
