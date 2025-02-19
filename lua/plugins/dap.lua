local function get_args(config)
  local args = type(config.args) == 'function' and (config.args() or {}) or config.args or {}
  local args_str = type(args) == 'table' and table.concat(args, ' ') or args

  config = vim.deepcopy(config)
  config.args = function()
    local new_args = vim.fn.expand(vim.fn.input('Run with args: ', args_str))
    return vim.split(new_args, ' ')
  end
  return config
end

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
      { '<leader>d',  '',                                                            desc = '+debug',                 mode = { 'n', 'v' } },
      {
        '<leader>dB',
        function()
          require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
        end,
        desc = 'Breakpoint Condition'
      },
      { '<leader>db', function() require('dap').toggle_breakpoint() end,             desc = 'Toggle Breakpoint' },
      { '<leader>dd', function() require('dap').continue() end,                      desc = 'Continue' },
      { '<leader>da', function() require('dap').continue({ before = get_args }) end, desc = 'Run with Args' },
      { '<leader>dc', function() require('dap').run_to_cursor() end,                 desc = 'Run to Cursor' },
      { '<leader>df', function() require('dap').focus_frame() end,                   desc = 'Focus Line' },
      { '<leader>dg', function() require('dap').goto_() end,                         desc = 'Go to Line (No Execute)' },
      { '<leader>di', function() require('dap').step_into() end,                     desc = 'Step Into' },
      { '<leader>dj', function() require('dap').down() end,                          desc = 'Down' },
      { '<leader>dk', function() require('dap').up() end,                            desc = 'Up' },
      { '<leader>dl', function() require('dap').run_last() end,                      desc = 'Run Last' },
      { '<leader>dn', function() require('dap').step_over() end,                     desc = 'Step Over' },
      { '<leader>do', function() require('dap').step_out() end,                      desc = 'Step Out' },
      { '<leader>dp', function() require('dap').pause() end,                         desc = 'Pause' },
      { '<leader>dr', function() require('dap').restart() end,                       desc = 'Restart' },
      { '<leader>dR', function() require('dap').repl.toggle() end,                   desc = 'Toggle REPL' },
      { '<leader>ds', function() require('dap').session() end,                       desc = 'Session' },
      { '<leader>dt', function() require('dap').terminate() end,                     desc = 'Terminate' },
      { '<leader>dw', function() require('dap.ui.widgets').hover() end,              desc = 'Widgets' },
    },
    config = function(_, opts)
      vim.diagnostic.config({
        signs = {
          { name = 'DapBreakpoint', text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' },
          { name = 'DapBreakpointCondition', text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' },
          { name = 'DapBreakpointRejected', text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' },
          { name = 'DapStopped', text = '', texthl = '', linehl = 'DapStoppedLine', numhl = 'DapBreakpoint' },
        }
      })
      local adapter_names = {
        'chrome', 'coreclr', 'cppdbg', 'dart', 'delve', 'erlang', 'firefox', 'haskell', 'init', 'kotlin',
        'mix_task', 'node2', 'php', 'python',
      }
      local dap = require('dap')
      local adapters = require('mason-nvim-dap.mappings.adapters')
      local configurations = require('mason-nvim-dap.mappings.configurations')
      local filetypes = require('mason-nvim-dap.mappings.filetypes')

      dap.adapters['pwa-chrome'] = {
        type = 'server',
        host = 'localhost',
        port = '${port}',
        executable = {
          command = 'js-debug',
          args = { '${port}' },
        },
      }
      dap.adapters['pwa-node'] = {
        type = 'server',
        host = 'localhost',
        port = '${port}',
        executable = {
          command = 'js-debug',
          args = { '${port}' },
        },
      }

      for _, adapter_name in ipairs(adapter_names) do
        local config = {
          name = adapter_name,
          adapters = adapters[adapter_name],
          configurations = configurations[adapter_name],
          filetypes = filetypes[adapter_name],
        }
        if type(config.adapters) == 'table' then
          dap.adapters[config.name] = config.adapters
          local configuration = config.configurations or {}
          if type(opts.adapters) == 'table' and opts.adapters[adapter_name] and type(opts.adapters[adapter_name].configurations) == 'table' then
            configuration = vim.tbl_extend('force', configuration, opts.adapters[adapter_name].configurations)
          end
          if not vim.tbl_isempty(configuration) then
            for _, filetype in ipairs(config.filetypes) do
              dap.configurations[filetype] = vim.list_extend(dap.configurations[filetype] or {}, configuration)
            end
          end
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
