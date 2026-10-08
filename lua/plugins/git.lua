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
    cmd = { 'Gitsigns' },
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
      { '[h',         function() require 'gitsigns'.prev_hunk() end,                                                           desc = 'Previous hunk' },
      { ']h',         function() require 'gitsigns'.next_hunk() end,                                                           desc = 'Next hunk' },
      { '<leader>h',  '',                                                                                                      desc = 'Git Hunk' },
      { '<leader>hs', function() require 'gitsigns'.stage_hunk() end,                                                          desc = 'Stage hunk' },
      { '<leader>hi', function() require 'gitsigns'.toggle_current_line_blame() end,                                           desc = 'Toggle current line blame' },
      { '<leader>hr', function() require 'gitsigns'.reset_hunk() end,                                                          desc = 'Reset hunk' },
      { '<leader>hS', function() require 'gitsigns'.stage_buffer() end,                                                        desc = 'Stage buffer' },
      { '<leader>hu', function() require 'gitsigns'.undo_stage_hunk() end,                                                     desc = 'Undo stage hunk' },
      { '<leader>hR', confirm('Are you sure you want to reset the buffer?', function() require 'gitsigns'.reset_buffer() end), desc = 'Reset buffer' },
      { '<leader>hp', function() require 'gitsigns'.preview_hunk_inline() end,                                                 desc = 'Preview hunk inline' },
      { '<leader>hP', function() require 'gitsigns'.preview_hunk() end,                                                        desc = 'Preview hunk' },
      { '<leader>hb', function() require 'gitsigns'.blame_line({ full = true }) end,                                           desc = 'Blame line' },
      { '<leader>hB', function() require 'gitsigns'.blame() end,                                                               desc = 'Blame buffer' },
      { '<leader>hd', function() require 'gitsigns'.diffthis() end,                                                            desc = 'Diff this' },
      { '<leader>hD', function() require 'gitsigns'.diffthis('~') end,                                                         desc = 'Diff this (cached)' },
      { '<leader>hs', function() require 'gitsigns'.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,                     desc = 'Stage hunk',               mode = 'v' },
      { '<leader>hr', function() require 'gitsigns'.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,                     desc = 'Reset hunk',               mode = 'v' },
      { '<leader>hw', function() require 'gitsigns'.toggle_word_diff() end,                                                    desc = 'Reset hunk',               mode = 'v' },
      { 'ah',         function() require 'gitsigns'.select_hunk() end,                                                         desc = 'Select hunk',              mode = { 'o', 'x' } },
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
          -- open_in_browser = { lhs = '<C-s-b>', desc = 'open issue in browser' },
        }
      },
      mappings = {
        issue = {
          -- open_in_browser = { lhs = '<C-S-b>', desc = 'open issue in browser' },
        },
        pull_request = {
          -- open_in_browser = { lhs = '<C-S-b>', desc = 'open PR in browser' },
        },
      }
    }
  }
}
