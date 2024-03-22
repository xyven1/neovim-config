return {
  {
    'theHamsta/nvim-dap-virtual-text',
    lazy = true,
    opts = { enabled = false }
  },
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'theHamsta/nvim-dap-virtual-text',
      'jay-babu/mason-nvim-dap.nvim',
    },
    init = function()
      vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#bf321d' })
      vim.fn.sign_define("DapBreakpoint", { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
      vim.fn.sign_define("DapBreakpointCondition", { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
      vim.fn.sign_define("DapBreakpointRejected", { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
      vim.fn.sign_define("DapStopped", { text = '', texthl = 'Dap', linehl = 'DapStoppedLine', numhl = 'DapStoppedLine' })
    end,
    lazy = true,
    keys = {
      {
        '<f5>',
        function() require('dap').continue() end,
        desc = 'Continue'
      },
      {
        '<f10>',
        function() require('dap').step_over() end,
        desc = 'Step over'
      },
      {
        '<f11>',
        function() require('dap').step_into() end,
        desc = 'Step into'
      },
      {
        '<f12>',
        function() require('dap').step_out() end,
        desc = 'Step out'
      },
      {
        '<leader>b',
        function() require('dap').toggle_breakpoint() end,
        desc = 'Toggle breakpoint'
      },
      {
        '<leader>B',
        function() require('dap').set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
        desc = 'Breakpoint with condition'
      },
    },
  },
  {
    'rcarriga/nvim-dap-ui',
    opts = {},
    keys = {
      { '<F4>', function() require('dapui').toggle() end },
    },
  },
}
