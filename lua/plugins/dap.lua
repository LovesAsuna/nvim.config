return {
  {
    "mfussenegger/nvim-dap",
    config = function(plugin, opts)
      local dap = require("dap")
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = "/home/lovesasuna/.local/share/nvim/mason/bin/codelldb",
          args = { "--port", "${port}" },

          -- On windows you may have to uncomment this:
          -- detached = false,
        },
      }
      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp
      local dap_breakpoint_color = {
        breakpoint = {
          ctermbg = 0,
          fg = "#993939",
          bg = "#31353f",
        },
        logpoing = {
          ctermbg = 0,
          fg = "#61afef",
          bg = "#31353f",
        },
        stopped = {
          ctermbg = 0,
          fg = "#98c379",
          bg = "#31353f",
        },
      }

      vim.api.nvim_set_hl(0, "DapBreakpoint", dap_breakpoint_color.breakpoint)
      vim.api.nvim_set_hl(0, "DapLogPoint", dap_breakpoint_color.logpoing)
      vim.api.nvim_set_hl(0, "DapStopped", dap_breakpoint_color.stopped)

      local dap_breakpoint = {
        error = {
          text = "",
          texthl = "DapBreakpoint",
          linehl = "DapBreakpoint",
          numhl = "DapBreakpoint",
        },
        condition = {
          text = "ﳁ",
          texthl = "DapBreakpoint",
          linehl = "DapBreakpoint",
          numhl = "DapBreakpoint",
        },
        rejected = {
          text = "",
          texthl = "DapBreakpint",
          linehl = "DapBreakpoint",
          numhl = "DapBreakpoint",
        },
        logpoint = {
          text = "",
          texthl = "DapLogPoint",
          linehl = "DapLogPoint",
          numhl = "DapLogPoint",
        },
        stopped = {
          text = "",
          texthl = "DapStopped",
          linehl = "DapStopped",
          numhl = "DapStopped",
        },
      }

      vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
      vim.fn.sign_define("DapBreakpointCondition", dap_breakpoint.condition)
      vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
      vim.fn.sign_define("DapLogPoint", dap_breakpoint.logpoint)
      vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
    end,
    keys = {
      {
        "<F9>",
        "<cmd>DapContinue<cr>",
      },
      {
        "<F8>",
        "<cmd>DapStepOver<cr>",
      },
      {
        "<F7>",
        "<cmd>DapStepIn<cr>",
      },
      {
        "<F20>",
        "<cmd>DapStepOut<cr>",
      },
      {
        "<F44>",
        "<cmd>DapToggleBreakpoint<cr>",
      },
      {
        "<F26>",
        "<cmd>DapTerminate<cr>",
      },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function(plugin, opts)
      local dapui = require("dapui")
      dapui.setup({})

      local dap = require("dap")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end

      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end

      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-treesitter/nvim-treesitter",
    },
    config = true,
  },
}
