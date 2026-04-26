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
    lazy = false,
    ---@module 'overseer'
    ---@type overseer.SetupOpts
    opts = {
      dap = false,
      task_list = {
        keymaps = {
          ['<C-k>'] = false,
          ['<C-j>'] = false,
          ['K'] = 'keymap.scroll_output_up',
          ['J'] = 'keymap.scroll_output_down',
        }
      },
      experimental_wrap_builtins = {
        enabled = true
      }
    },
    keys = {
      { '<leader>`',  '<cmd>OverseerToggle<cr>',       desc = 'Toggle tasks view' },
      { '<leader>r',  '',                              desc = '+tasks' },
      { '<leader>ra', '<cmd>OverseerTaskAction<cr>',   desc = 'Run task action' },
      { '<leader>ri', '<cmd>checkhealth overseer<cr>', desc = 'Overseer info' },
      { '<leader>rt', '<cmd>OverseerRun<cr>',          desc = 'Run task' },
      { '<leader>rn', '<cmd>OverseerShell<cr>',        desc = 'New shell task' },
    }
  },
  {
    'andythigpen/nvim-coverage',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'LazyFile',
    opts = {},
  }
}
