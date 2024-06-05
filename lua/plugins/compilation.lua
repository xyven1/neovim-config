return {
  {
    "Zeioth/compiler.nvim",
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    dependencies = { "stevearc/overseer.nvim", "nvim-telescope/telescope.nvim" },
    opts = {},
    keys = {
      { '<leader>cc', '<cmd>CompilerOpen<cr>',                           desc = 'Open compiler' },
      { '<leader>cr', '<cmdCompilerStop<cr>' .. '<cmd>CompilerRedo<cr>', desc = 'Recompile' },
      { '<leader>ct', '<cmd>CompilerToggleResults<cr>',                  desc = 'Toggle results' },
      { '<leader>cx', '<cmd>CompilerStop<cr>',                           desc = 'Close compiler' },
    }
  },
  {
    "stevearc/overseer.nvim",
    event = 'VeryLazy',
    opts = function()
      local wk = require('which-key')
      wk.register({
        ['`'] = { '<cmd>OverseerToggle<cr>', 'Toggle tasks view' },
        r = {
          name = "Tasks",
          a = { '<cmd>OverseerTaskAction<cr>', 'Run task action' },
          b = {
            name = "Task bundles",
            l = { '<cmd>OverseerLoadBundle<cr>', 'Load task bundle' },
            s = { '<cmd>OverseerSaveBundle<cr>', 'Save tasks to bundle' },
          },
          c = { '<cmd>OverseerRunCmd<cr>', 'Run command' },
          d = { '<cmd>OverseerQuickAction dispose<cr>', 'Delete latest task' },
          e = { '<cmd>OverseerQuickAction edit<cr>', 'Edit latest task' },
          f = { '<cmd>OverseerQuickAction open float<cr>', 'Open last task (float)' },
          i = { '<cmd>OverseerInfo<cr>', 'Overseer info' },
          n = { '<cmd>OverseerBuild<cr>', 'Create new task' },
          o = {
            name = "Open last task",
            o = { '<cmd>OverseerQuickAction open<cr>', 'Open last task (window)' },
            s = { '<cmd>OverseerQuickAction open split<cr>', 'Open last task (split)' },
            t = { '<cmd>OverseerQuickAction open tab<cr>', 'Open last task (tab)' },
            v = { '<cmd>OverseerQuickAction open vsplit<cr>', 'Open last task (vsplit)' },
          },
          q = { '<cmd>OverseerQuickAction<cr>', 'Run task action on most recent task' },
          r = { '<cmd>OverseerQuickAction restart<cr>', 'Restart latest task' },
          s = { '<cmd>OverseerQuickAction ensure<cr>', 'Start latest task' },
          t = { '<cmd>OverseerRun<cr>', 'Run task' },
          x = { '<cmd>OverseerQuickAction stop<cr>', 'Stop latest task' },
        }
      }, {
        prefix = '<leader>',
      })
      return {
        task_list = {
          bindings = {
            ["]"] = "IncreaseDetail",
            ["["] = "DecreaseDetail",
            ["<C-]>"] = "IncreaseAllDetail",
            ["<C-[>"] = "DecreaseAllDetail",
            ["K"] = "ScrollOutputUp",
            ["J"] = "ScrollOutputDown",
          }
        },
        bundles = {
          autostart_on_load = false
        }
      }
    end,
    keys = { '<leader>`', '<leader>r' },
  },
  {
    "andythigpen/nvim-coverage",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = 'LazyFile',
    opts = {},
  }
}
