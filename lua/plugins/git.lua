return {
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'LazyFile',
    opts = function()
      local gitsigns = require('gitsigns')
      local wk = require('which-key')
      wk.register({
        h = {
          name = 'Hunk',
          s = { gitsigns.stage_hunk, 'Stage hunk' },
          r = { gitsigns.reset_hunk, 'Reset hunk' },
          S = { gitsigns.stage_buffer, 'Stage buffer' },
          u = { gitsigns.undo_stage_hunk, 'Undo stage hunk' },
          R = { gitsigns.reset_buffer, 'Reset buffer' },
          p = { gitsigns.preview_hunk, 'Preview hunk' },
          b = { function() gitsigns.blame_line { full = true } end, 'Blame line' },
          d = { gitsigns.diffthis, 'Diff this' },
          D = { function() gitsigns.diffthis('~') end, 'Diff this (cached)' },
        }
      }, { prefix = '<leader>' })
      wk.register({
        h = {
          name = 'Hunk',
          s = { function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, 'Stage hunk' },
          r = { function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, 'Reset hunk' },
        }
      }, { prefix = '<leader>', mode = 'v' })
    end,
    keys = {
      { '[h',        function() require('gitsigns').prev_hunk() end, 'Previous hunk' },
      { ']h',        function() require('gitsigns').next_hunk() end, 'Next hunk' },
      { '<leader>h', modes = { 'n', 'v' } }
    }
  },
  {
    'tpope/vim-fugitive',
    event = 'VeryLazy',
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local wk = require("which-key")
      wk.register({
        g = {
          name = "Git",
          g = { "<cmd>LazyGit<cr>", "Open LazyGit" },
          f = { "<cmd>LazyGitFilter<cr>", "LazyGit: Browse commits" },
          c = { "<cmd>LazyGitCurrentFile<cr>", "Open LazyGit for current file" },
          C = { "<cmd>LazyGitFilterCurrentFile<cr>", "LazyGit: Browse commits for current file" },
        },
      }, { prefix = "<leader>" })
    end,
    keys = { '<leader>g' }
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
      { '<leader>dd', '<cmd>DiffviewOpen<cr>',          desc = 'Open diff view' },
      { '<leader>dc', '<cmd>DiffviewClose<cr>',         desc = 'Close diff view' },
      { '<leader>dh', '<cmd>DiffviewFileHistory %<cr>', desc = 'Git file history' },
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
