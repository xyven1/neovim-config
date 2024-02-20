return {
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'VeryLazy',
    opts = {}
  },
  {
    'tpope/vim-fugitive',
    event = 'VeryLazy',
    opts = {},
    config = function()
    end
  },
  {
    'sindrets/diffview.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    opts = {
      enhanced_diff_hl = true,
    },
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory' },
    keys = {
      { '<leader>dd', '<cmd>DiffviewOpen<cr>',    desc = 'Open diff view' },
      { '<leader>dc', '<cmd>DiffviewClose<cr>',   desc = 'Close diff view' },
      { '<leader>dh', '<cmd>DiffviewFileHistory', desc = 'Git file history' },
    }
  },
}
