return {
  {
    'Zeioth/compiler.nvim',
    cmd = { 'CompilerOpen', 'CompilerToggleResults', 'CompilerRedo' },
    dependencies = { 'stevearc/overseer.nvim', 'nvim-telescope/telescope.nvim' },
    opts = {},
    keys = {
      { '<leader>cc', '<cmd>CompilerOpen<cr>',                           desc = 'Open compiler' },
      { '<leader>cr', '<cmdCompilerStop<cr>' .. '<cmd>CompilerRedo<cr>', desc = 'Recompile' },
      { '<leader>ct', '<cmd>CompilerToggleResults<cr>',                  desc = 'Toggle results' },
      { '<leader>cx', '<cmd>CompilerStop<cr>',                           desc = 'Close compiler' },
    }
  },
  {
    'stevearc/overseer.nvim',
    event = 'VeryLazy',
    ---@module 'overseer'
    ---@type overseer.Config
    opts = {
      dap = false,
      task_list = {
        bindings = {
          [']'] = 'IncreaseDetail',
          ['['] = 'DecreaseDetail',
          ['<C-]>'] = 'IncreaseAllDetail',
          ['<C-[>'] = 'DecreaseAllDetail',
          ['K'] = 'ScrollOutputUp',
          ['J'] = 'ScrollOutputDown',
        }
      },
      bundles = {
        autostart_on_load = false
      }
    },
    keys = {
      { '<leader>`',   '<cmd>OverseerToggle<cr>',                  desc = 'Toggle tasks view' },
      { '<leader>r',   '',                                         desc = '+tasks' },
      { '<leader>ra',  '<cmd>OverseerTaskAction<cr>',              desc = 'Run task action' },
      { '<leader>rb',  '',                                         desc = '+task bundles' },
      { '<leader>rbl', '<cmd>OverseerLoadBundle<cr>',              desc = 'Load task bundle' },
      { '<leader>rbs', '<cmd>OverseerSaveBundle<cr>',              desc = 'Save tasks to bundle' },
      { '<leader>rc',  '<cmd>OverseerRunCmd<cr>',                  desc = 'Run command' },
      { '<leader>rd',  '<cmd>OverseerQuickAction dispose<cr>',     desc = 'Delete latest task' },
      { '<leader>re',  '<cmd>OverseerQuickAction edit<cr>',        desc = 'Edit latest task' },
      { '<leader>rf',  '<cmd>OverseerQuickAction open float<cr>',  desc = 'Open last task (float)' },
      { '<leader>ri',  '<cmd>OverseerInfo<cr>',                    desc = 'Overseer info' },
      { '<leader>rn',  '<cmd>OverseerBuild<cr>',                   desc = 'Create new task' },
      { '<leader>ro',  '',                                         desc = '+open last task' },
      { '<leader>roo', '<cmd>OverseerQuickAction open<cr>',        desc = 'Open last task (window)' },
      { '<leader>ros', '<cmd>OverseerQuickAction open split<cr>',  desc = 'Open last task (split)' },
      { '<leader>rot', '<cmd>OverseerQuickAction open tab<cr>',    desc = 'Open last task (tab)' },
      { '<leader>rov', '<cmd>OverseerQuickAction open vsplit<cr>', desc = 'Open last task (vsplit)' },
      { '<leader>rq',  '<cmd>OverseerQuickAction<cr>',             desc = 'Run task action on most recent task' },
      { '<leader>rr',  '<cmd>OverseerQuickAction restart<cr>',     desc = 'Restart latest task' },
      { '<leader>rs',  '<cmd>OverseerQuickAction start<cr>',       desc = 'Start latest task' },
      { '<leader>rt',  '<cmd>OverseerRun<cr>',                     desc = 'Run task' },
      { '<leader>rx',  '<cmd>OverseerQuickAction stop<cr>',        desc = 'Stop latest task' },
    }
  },
  {
    'andythigpen/nvim-coverage',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'LazyFile',
    opts = {},
  }
}
