local markdownMode = false;
return {
  {
    'direnv/direnv.vim',
    lazy = false,
    priority = 1,
  },
  {
    'lambdalisue/vim-suda',
    lazy = false,
    init = function()
      vim.g.suda_smart_edit = 1
    end,
    priority = 1,
  },
  {
    'mrjones2014/smart-splits.nvim',
    lazy = false,
    opts = {},
    keys = {
      { '<A-h>',             function() require('smart-splits').resize_left() end,       desc = 'Resize left' },
      { '<A-j>',             function() require('smart-splits').resize_down() end,       desc = 'Resize down' },
      { '<A-k>',             function() require('smart-splits').resize_up() end,         desc = 'Resize up' },
      { '<A-l>',             function() require('smart-splits').resize_right() end,      desc = 'Split right' },
      { '<C-h>',             function() require('smart-splits').move_cursor_left() end,  desc = 'Move cursor left' },
      { '<C-j>',             function() require('smart-splits').move_cursor_down() end,  desc = 'Move cursor down' },
      { '<C-k>',             function() require('smart-splits').move_cursor_up() end,    desc = 'Move cursor up' },
      { '<C-l>',             function() require('smart-splits').move_cursor_right() end, desc = 'Move cursor right' },
      { '<leader><leader>h', function() require('smart-splits').swap_buf_left() end,     desc = 'Swap buffer left' },
      { '<leader><leader>j', function() require('smart-splits').swap_buf_down() end,     desc = 'Swap buffer down' },
      { '<leader><leader>k', function() require('smart-splits').swap_buf_up() end,       desc = 'Swap buffer up' },
      { '<leader><leader>l', function() require('smart-splits').swap_buf_right() end,    desc = 'Swap buffer right' },
    }
  },
  {
    'monaqa/dial.nvim',
    keys = {
      { '<C-a>',  function() require('dial.map').manipulate('increment', 'normal') end,  desc = 'Increment' },
      { '<C-x>',  function() require('dial.map').manipulate('decrement', 'normal') end,  desc = 'Decrement' },
      { 'g<C-a>', function() require('dial.map').manipulate('increment', 'gnormal') end, desc = 'Increment (gnormal)' },
      { 'g<C-x>', function() require('dial.map').manipulate('decrement', 'gnormal') end, desc = 'Decrement (gnormal)' },
      { '<C-a>',  function() require('dial.map').manipulate('increment', 'visual') end,  desc = 'Increment (visual)',  mode = { 'v' } },
      { '<C-x>',  function() require('dial.map').manipulate('decrement', 'visual') end,  desc = 'Decrement (visual)',  mode = { 'v' } },
      { 'g<C-a>', function() require('dial.map').manipulate('increment', 'gvisual') end, desc = 'Increment (gvisual)', mode = { 'v' } },
      { 'g<C-x>', function() require('dial.map').manipulate('decrement', 'gvisual') end, desc = 'Decrement (gvisual)', mode = { 'v' } },
    }
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    cmd = { 'RenderMarkdown' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      heading = {
        backgrounds = {
          '', '', '', '', '', '',
        }
      }
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd('BufEnter', {
        callback = function()
          if vim.bo.filetype == 'markdown' then
            vim.opt_local.spell = markdownMode
            vim.opt_local.linebreak = markdownMode
          end
        end
      })
      require('render-markdown').setup(opts)
    end,
    keys = {
      {
        '<leader>um',
        function()
          local rm = require('render-markdown')
          markdownMode = not markdownMode
          if markdownMode then
            rm.enable()
          else
            rm.disable()
          end
          if vim.bo.filetype == 'markdown' then
            vim.opt_local.spell = markdownMode
            vim.opt_local.linebreak = markdownMode
          end
        end,
        desc = 'Toggle markdown mode'
      },
    }
  },
  {
    'kazhala/close-buffers.nvim',
    keys = {
      { '<leader>x',  group = 'Close' },
      {
        '<leader>xx',
        function()
          local cb = require('close_buffers')
          if vim.bo.modified then
            local choice = vim.fn.confirm('Save changes to %q?', '&Yes\n&No\n&Cancel')
            if choice == 1 then
              vim.cmd.write()
              cb.delete({ type = 'this' })
            elseif choice == 2 then
              cb.delete({ type = 'this', force = true })
            end
          else
            cb.delete({ type = 'this' })
          end
        end,
        desc = 'Close current buffer'
      },
      { '<leader>xf', function() require('close_buffers').delete({ type = 'this', force = true }) end, desc = 'Force close current buffer' },
      { '<leader>xn', function() require('close_buffers').delete({ type = 'nameless' }) end,           desc = 'Close nameless buffers' },
      { '<leader>xh', function() require('close_buffers').delete({ type = 'hidden' }) end,             desc = 'Close hidden buffers' },
      { '<leader>xa', function() require('close_buffers').delete({ type = 'all' }) end,                desc = 'Close all buffers' },
      { '<leader>xo', function() require('close_buffers').delete({ type = 'other' }) end,              desc = 'Close other buffers' },
      { '<leader>xt', '<cmd>tabclose<cr>',                                                             desc = 'Close tab' },

    },
    opts = {}
  },
  {
    'danymat/neogen',
    config = true,
    cmd = { 'Neogen' },
    keys = {
      { '<leader>ng', function() require('neogen').generate() end, desc = 'Generate function docs' },
    }
  },
  {
    'nvim-pack/nvim-spectre',
    cmd = { 'Spectre' },
    opts = { open_cmd = 'noswapfile vnew' },
    keys = {
      { '<leader>nr', function() require('spectre').open() end, desc = 'Replace in Files (Spectre)' },
    }
  },
  {
    'ptdewey/pendulum-nvim',
    event = 'VeryLazy',
    opts = {}
  }
}
