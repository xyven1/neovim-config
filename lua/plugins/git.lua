local function gitsigns(cmd) return function() require('gitsigns')[cmd]() end end
local confirm = function(message, callback)
  return function()
    if vim.fn.confirm(message, '&Yes\n&Cancel', 1) == 1 then
      callback()
    end
  end
end
return {
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'LazyFile',
    opts = {},
    keys = {
      { '[h',         gitsigns 'prev_hunk',                                                                desc = 'Previous hunk' },
      { ']h',         gitsigns 'next_hunk',                                                                desc = 'Next hunk' },
      { '<leader>h',  group = 'Git Hunk' },
      { '<leader>hs', gitsigns 'stage_hunk',                                                               desc = 'Stage hunk' },
      { '<leader>hr', gitsigns 'reset_hunk',                                                               desc = 'Reset hunk' },
      { '<leader>hS', gitsigns 'stage_buffer',                                                             desc = 'Stage buffer' },
      { '<leader>hu', gitsigns 'undo_stage_hunk',                                                          desc = 'Undo stage hunk' },
      { '<leader>hR', confirm('Are you sure you want to reset the buffer?', gitsigns 'reset_buffer'),      desc = 'Reset buffer' },
      { '<leader>hp', gitsigns 'preview_hunk',                                                             desc = 'Preview hunk' },
      { '<leader>hb', function() require 'gitsigns'.blame_line({ full = true }) end,                       desc = 'Blame line' },
      { '<leader>hd', gitsigns 'diffthis',                                                                 desc = 'Diff this' },
      { '<leader>hD', function() require 'gitsigns'.diffthis('~') end,                                     desc = 'Diff this (cached)' },
      { '<leader>hs', function() require 'gitsigns'.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, desc = 'Stage hunk',        mode = 'v' },
      { '<leader>hr', function() require 'gitsigns'.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, desc = 'Reset hunk',        mode = 'v' },
    }
  },
  {
    'tpope/vim-fugitive',
    event = 'VeryLazy', },
  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    keys = {
      { '<leader>g',  group = 'Git' },
      { '<leader>gg', '<cmd>LazyGit<cr>',                  desc = 'Open LazyGit' },
      { '<leader>gf', '<cmd>LazyGitFilter<cr>',            desc = 'LazyGit: Browse commits' },
      { '<leader>gc', '<cmd>LazyGitCurrentFile<cr>',       desc = 'Open LazyGit for current file' },
      { '<leader>gC', '<cmd>LazyGitFilterCurrentFile<cr>', desc = 'LazyGit: Browse commits for current file' },
    }
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
      { '<leader>d',  group = 'Diff' },
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
      picker = 'fzf-lua',
      picker_config = {
        mappings = {
          open_in_browser = { lhs = '<C-s-b>', desc = 'open issue in browser' },
        }
      },
      mappings = {
        issue = {
          open_in_browser = { lhs = '<C-s-b>', desc = 'open issue in browser' },
        },
        pull_request = {
          open_in_browser = { lhs = '<C-s-b>', desc = 'open PR in browser' },
        },
      }
    }
  }
}
