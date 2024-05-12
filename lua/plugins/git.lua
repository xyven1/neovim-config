return {
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'LazyFile',
    opts = {},
    keys = {
      { '[h', function() require('gitsigns').prev_hunk() end, desc = 'Previous hunk' },
      { ']h', function() require('gitsigns').next_hunk() end, desc = 'Next hunk' },
    }
  },
  {
    'tpope/vim-fugitive',
    event = 'VeryLazy',
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
      { '<leader>dd', '<cmd>DiffviewOpen<cr>',        desc = 'Open diff view' },
      { '<leader>dc', '<cmd>DiffviewClose<cr>',       desc = 'Close diff view' },
      { '<leader>dh', '<cmd>DiffviewFileHistory<cr>', desc = 'Git file history' },
    }
  },
  {
    'pwntester/octo.nvim',
    cmd = { 'Octo' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'ibhagwan/fzf-lua',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      picker = "fzf-lua",
      picker_config = {
        mappings = {
          open_in_browser = { lhs = "<C-s-b>", desc = "open issue in browser" },
        }
      },
      mappings = {
        issue = {
          open_in_browser = { lhs = "<C-s-b>", desc = "open issue in browser" },
        },
        pull_request = {
          open_in_browser = { lhs = "<C-s-b>", desc = "open PR in browser" },
        },
      }
    }
  }
}
