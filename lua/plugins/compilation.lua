return {
  { -- This plugin
    "Zeioth/compiler.nvim",
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    dependencies = { "stevearc/overseer.nvim" },
    opts = {},
  },
  { -- The task runner we use
    "stevearc/overseer.nvim",
    event = 'VeryLazy',
    opts = {},
    keys = {
      { '<leader>`', '<cmd>OverseerToggle<cr>', desc = 'Toggle tasks view' },
      { '<leader>r', '<cmd>OverseerRun<cr>',    desc = 'Run task' },
    },
  },
}
