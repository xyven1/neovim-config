return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'theHamsta/nvim-dap-virtual-text',
      'xyven1/mason-nvim-dap.nvim',
    },
    opts = {
      adapters = {
        codelldb = {
          configurations = {
            {
              name = 'Replay',
              type = 'codelldb',
              request = 'custom',
              targetCreateCommands = { 'target create ${workspaceFolder}/build/debuggee' },
              processCreateCommands = { 'gdb-remote 127.0.0.1:50505' },
              reverseDebugging = true
            }
          }
        },
      },
    },
    keys = {
      { '<f5>',      function() require('dap').continue() end,          desc = 'Continue' },
      { '<f10>',     function() require('dap').step_over() end,         desc = 'Step over' },
      { '<f11>',     function() require('dap').step_into() end,         desc = 'Step into' },
      { '<f12>',     function() require('dap').step_out() end,          desc = 'Step out' },
      { '<leader>b', function() require('dap').toggle_breakpoint() end, desc = 'Toggle breakpoint' },
      {
        '<leader>B',
        function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
        desc = 'Breakpoint with condition'
      },
    },
    config = function(_, opts)
      vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
      vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
      vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped', { text = '', texthl = '', linehl = 'DapStoppedLine', numhl = 'DapBreakpoint' })
      local adapter_names = {
        'chrome', 'codelldb', 'coreclr', 'cppdbg', 'dart', 'delve', 'erlang', 'firefox', 'haskell', 'init', 'kotlin',
        'mix_task', 'node2', 'php', 'python',
      }
      local dap = require('dap')
      local adapters = require('mason-nvim-dap.mappings.adapters')

      dap.adapters["pwa-chrome"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "js-debug",
          args = { "${port}" },
        },
      }
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "js-debug",
          args = { "${port}" },
        },
      }
      for _, adapter_name in ipairs(adapter_names) do
        local config = {
          name = adapter_name,
          adapter = adapters[adapter_name],
        }
        if type(config.adapter) == 'table' then
          dap.adapters[config.name] = config.adapter
        end
      end
    end
  },
  {
    'theHamsta/nvim-dap-virtual-text',
    opts = { enabled = false },
    keys = {
      {
        '<leader>uv',
        function()
          require('nvim-dap-virtual-text').toggle()
        end,
        desc = 'Toggle dap virtual text'
      },
    },
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    opts = {},
    keys = {
      { '<F4>',      function() require('dapui').toggle() end, desc = 'Toggle debug ui' },
      { '<leader>k', function() require('dapui').eval() end,   desc = 'Evaluate expression', mode = { 'n', 'v' } },
    },
  },
}
