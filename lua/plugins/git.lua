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
    opts = {
      signs = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '╽' },
        topdelete    = { text = '╿' },
        changedelete = { text = '┣' },
        untracked    = { text = '┆' },
      },
      signs_staged = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '╽' },
        topdelete    = { text = '╿' },
        changedelete = { text = '┣' },
        untracked    = { text = '┆' },
      },
    },
    keys = {
      { '[h',         gitsigns 'prev_hunk',                                                                desc = 'Previous hunk' },
      { ']h',         gitsigns 'next_hunk',                                                                desc = 'Next hunk' },
      { '<leader>h',  '',                                                                                  desc = 'Git Hunk' },
      { '<leader>hs', gitsigns 'stage_hunk',                                                               desc = 'Stage hunk' },
      { '<leader>hb', gitsigns 'toggle_current_line_blame',                                                desc = 'Toggle current line blame' },
      { '<leader>hr', gitsigns 'reset_hunk',                                                               desc = 'Reset hunk' },
      { '<leader>hS', gitsigns 'stage_buffer',                                                             desc = 'Stage buffer' },
      { '<leader>hu', gitsigns 'undo_stage_hunk',                                                          desc = 'Undo stage hunk' },
      { '<leader>hR', confirm('Are you sure you want to reset the buffer?', gitsigns 'reset_buffer'),      desc = 'Reset buffer' },
      { '<leader>hp', gitsigns 'preview_hunk_inline',                                                      desc = 'Preview hunk inline' },
      { '<leader>hP', gitsigns 'preview_hunk',                                                             desc = 'Preview hunk' },
      { '<leader>hb', function() require 'gitsigns'.blame_line({ full = true }) end,                       desc = 'Blame line' },
      { '<leader>hd', gitsigns 'diffthis',                                                                 desc = 'Diff this' },
      { '<leader>hD', function() require 'gitsigns'.diffthis('~') end,                                     desc = 'Diff this (cached)' },
      { '<leader>hs', function() require 'gitsigns'.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, desc = 'Stage hunk',               mode = 'v' },
      { '<leader>hr', function() require 'gitsigns'.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, desc = 'Reset hunk',               mode = 'v' },
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
      { '<leader>gd', '<cmd>DiffviewOpen<cr>',          desc = 'Open diff view' },
      { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = 'Git file history' },
    }
  },
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'ibhagwan/fzf-lua',
      'nvim-tree/nvim-web-devicons',
    },
    cmd = { 'Octo' },
    keys = {
      { '<leader>go', '<cmd>Octo<cr>', desc = 'Open GitHub UI' }
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
