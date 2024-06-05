return {
  {
    "direnv/direnv.vim",
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
      { '<C-a>',  function() require("dial.map").manipulate("increment", "normal") end,  desc = 'Increment' },
      { '<C-x>',  function() require("dial.map").manipulate("decrement", "normal") end,  desc = 'Decrement' },
      { 'g<C-a>', function() require("dial.map").manipulate("increment", "gnormal") end, desc = 'Increment (gnormal)' },
      { 'g<C-x>', function() require("dial.map").manipulate("decrement", "gnormal") end, desc = 'Decrement (gnormal)' },
      { '<C-a>',  function() require("dial.map").manipulate("increment", "visual") end,  desc = 'Increment (visual)',  mode = { 'v' } },
      { '<C-x>',  function() require("dial.map").manipulate("decrement", "visual") end,  desc = 'Decrement (visual)',  mode = { 'v' } },
      { 'g<C-a>', function() require("dial.map").manipulate("increment", "gvisual") end, desc = 'Increment (gvisual)', mode = { 'v' } },
      { 'g<C-x>', function() require("dial.map").manipulate("decrement", "gvisual") end, desc = 'Decrement (gvisual)', mode = { 'v' } },
    }
  },
  {
    "toppair/peek.nvim",
    cmd = "PeekOpen",
    build = "deno -- task --quiet build:fast",
    opts = {
      app = "browser",
    },
    config = function(_, opts)
      require("peek").setup(opts)
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },
  {
    'kazhala/close-buffers.nvim',
    keys = { '<leader>x' },
    config = function()
      local cb = require('close_buffers')
      local wk = require('which-key')
      wk.register({
        x = {
          name = 'Close',
          x = { function()
            if vim.bo.modified then
              local choice = vim.fn.confirm("Save changes to %q?", "&Yes\n&No\n&Cancel")
              if choice == 1 then
                vim.cmd.write()
                cb.delete({ type = 'this' })
              elseif choice == 2 then
                cb.delete({ type = 'this', force = true })
              end
            else
              cb.delete({ type = 'this' })
            end
          end, 'Close current buffer' },
          f = { function() cb.delete({ type = 'this', force = true }) end, 'Force close current buffer' },
          n = { function() cb.delete({ type = 'nameless' }) end, 'Close nameless buffers' },
          h = { function() cb.delete({ type = 'hidden' }) end, 'Close hidden buffers' },
          a = { function() cb.delete({ type = 'all' }) end, 'Close all buffers' },
          o = { function() cb.delete({ type = 'other' }) end, 'Close other buffers' },
          t = { "<cmd>tabclose<cr>", 'Close tab' },
        }
      }, {
        prefix = '<leader>',
      })
    end
  },
  {
    'danymat/neogen',
    config = true,
    cmd = { "Neogen" },
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
  }
}
