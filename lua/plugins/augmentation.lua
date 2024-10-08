local markdownMode = false;
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
      require('render-markdown').setup(opts)
      vim.api.nvim_set_hl(0, '@markup.heading.1.markdown', { fg = '#fb4934', bg = '', bold = true })
      vim.api.nvim_set_hl(0, '@markup.heading.2.markdown', { fg = '#fabd2f', bg = '', bold = true })
      vim.api.nvim_set_hl(0, '@markup.heading.3.markdown', { fg = '#b8bb26', bg = '', bold = true })
      vim.api.nvim_set_hl(0, '@markup.heading.4.markdown', { fg = '#8ec07c', bg = '', bold = true })
      vim.api.nvim_set_hl(0, '@markup.heading.5.markdown', { fg = '#83a598', bg = '', bold = true })
      vim.api.nvim_set_hl(0, '@markup.heading.6.markdown', { fg = '#d3869b', bg = '', bold = true })
    end,
    keys = {
      {
        '<leader>um',
        function()
          local markdown = vim.api.nvim_create_augroup('MarkdownMode', { clear = true })
          markdownMode = not markdownMode
          local func = markdownMode
              and function()
                require('render-markdown').enable()
                vim.opt_local.spell = true
                vim.opt_local.linebreak = true

                local outline = require('outline')
                if outline then
                  outline.open({ focus_outline = false })
                end
              end
              or function()
                require('render-markdown').disable()
                vim.opt_local.spell = false
                vim.opt_local.linebreak = false

                local outline = require('outline')
                if outline then
                  outline.close()
                end
              end
          vim.api.nvim_create_autocmd("FileType", {
            group = markdown,
            pattern = "markdown",
            callback = func
          })
          func()
        end,
        desc = 'Toggle markdown mode'
      },
    }
  },
  {
    'kazhala/close-buffers.nvim',
    keys = {
      { '<leader>x',  group = "Close" },
      {
        '<leader>xx',
        function()
          local cb = require('close_buffers')
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
        end,
        desc = 'Close current buffer'
      },
      { '<leader>xf', function() require('close_buffers').delete({ type = 'this', force = true }) end, desc = 'Force close current buffer' },
      { '<leader>xn', function() require('close_buffers').delete({ type = 'nameless' }) end,           desc = 'Close nameless buffers' },
      { '<leader>xh', function() require('close_buffers').delete({ type = 'hidden' }) end,             desc = 'Close hidden buffers' },
      { '<leader>xa', function() require('close_buffers').delete({ type = 'all' }) end,                desc = 'Close all buffers' },
      { '<leader>xo', function() require('close_buffers').delete({ type = 'other' }) end,              desc = 'Close other buffers' },
      { '<leader>xt', "<cmd>tabclose<cr>",                                                             desc = 'Close tab' },

    },
    opts = {}
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
  },
  {
    "ptdewey/pendulum-nvim",
    opts = {}
  }
}
