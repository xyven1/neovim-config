return {
  {
    'direnv/direnv.vim',
    lazy = false,
    priority = 1,
  },
  {
    'lambdalisue/vim-suda',
    lazy = false,
    priority = 1,
  },
  {
    'NMAC427/guess-indent.nvim',
    lazy = false,
    opts = {}
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
      { '<C-h>',             function() require('smart-splits').move_cursor_left() end,  desc = 'Move cursor left',  mode = { 'n', 't' } },
      { '<C-j>',             function() require('smart-splits').move_cursor_down() end,  desc = 'Move cursor down',  mode = { 'n', 't' } },
      { '<C-k>',             function() require('smart-splits').move_cursor_up() end,    desc = 'Move cursor up',    mode = { 'n', 't' } },
      { '<C-l>',             function() require('smart-splits').move_cursor_right() end, desc = 'Move cursor right', mode = { 'n', 't' } },
      { '<leader><leader>h', function() require('smart-splits').swap_buf_left() end,     desc = 'Swap buffer left' },
      { '<leader><leader>j', function() require('smart-splits').swap_buf_down() end,     desc = 'Swap buffer down' },
      { '<leader><leader>k', function() require('smart-splits').swap_buf_up() end,       desc = 'Swap buffer up' },
      { '<leader><leader>l', function() require('smart-splits').swap_buf_right() end,    desc = 'Swap buffer right' },
    }
  },
  {
    'monaqa/dial.nvim',
    config = function()
      local augend = require('dial.augend')
      require('dial.config').augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias['%Y/%m/%d'],
          augend.constant.alias.bool
        },
      })
    end,
    keys = {
      { '<C-a>',  function() require('dial.map').manipulate('increment', 'normal') end,  desc = 'Increment' },
      { '<C-x>',  function() require('dial.map').manipulate('decrement', 'normal') end,  desc = 'Decrement' },
      { '<C-a>',  function() require('dial.map').manipulate('increment', 'visual') end,  desc = 'Increment (visual)', mode = { 'v' } },
      { '<C-x>',  function() require('dial.map').manipulate('decrement', 'visual') end,  desc = 'Decrement (visual)', mode = { 'v' } },
      { 'g<C-a>', function() require('dial.map').manipulate('increment', 'gnormal') end, desc = 'Increment' },
      { 'g<C-x>', function() require('dial.map').manipulate('decrement', 'gnormal') end, desc = 'Decrement' },
      { 'g<C-a>', function() require('dial.map').manipulate('increment', 'gvisual') end, desc = 'Increment (visual)', mode = { 'v' } },
      { 'g<C-x>', function() require('dial.map').manipulate('decrement', 'gvisual') end, desc = 'Decrement (visual)', mode = { 'v' } },
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
          local state = Snacks.toggle.toggles.markdown.get(Snacks.toggle.toggles.markdown)
          if vim.bo.filetype == 'markdown' then
            vim.opt_local.spell = state
            vim.opt_local.linebreak = state
          end
        end
      })
      require('render-markdown').setup(opts)
    end,
  },
  {
    'toppair/peek.nvim',
    cmd = { 'PeekOpen' },
    build = 'deno task build:fast',
    opts = {
      app = 'browser'
    },
    init = function()
      vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
      vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
    end,
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
    'MagicDuck/grug-far.nvim',
    opts = {},
    keys = {
      { '<leader>nr', function() require('grug-far').open() end, desc = 'Replace in Files' },
    }
  },
  {
    'ptdewey/pendulum-nvim',
    event = 'VeryLazy',
    opts = {}
  },
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@module 'snacks'
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = {
        enabled = true,
        preset = {
          keys = {
            { icon = ' ', key = 's', desc = 'Restore Session', action = ':Resession load_dir' },
            { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
            { icon = ' ', key = 'c', desc = 'Config', action = ':lua Snacks.dashboard.pick("files", {cwd = vim.fn.stdpath("config")})' },
            { icon = '󰅴 ', key = 'l', desc = 'Leetcode', action = ':Leet' },
            { icon = '󰒲 ', key = 'L', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
            { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
          }
        }
      },
      notifier = { enabled = true, top_down = false, },
      quickfile = { enabled = true },
      indent = {
        enabled = true,
        indent = {
          char = '▏',
        },
        scope = {
          char = '▏',
        },
      }
    },
    keys = {
      { '<leader>g',  '',                                                       desc = '+git' },
      { '<leader>gg', function() Snacks.lazygit() end,                          desc = 'Lazygit' },
      { '<leader>x',  '',                                                       desc = '+close' },
      { '<leader>x',  '',                                                       desc = '+close' },
      { '<leader>xx', function() Snacks.bufdelete.delete() end,                 desc = 'Close current buffer' },
      { '<leader>xf', function() Snacks.bufdelete.delete({ force = true }) end, desc = 'Force close current buffer' },
      {
        '<leader>xn',
        function()
          Snacks.bufdelete.delete({
            filter = function(b) return vim.api.nvim_buf_get_name(b) == '' end
          })
        end,
        desc = 'Force close current buffer'
      },
      { '<leader>xa', function() Snacks.bufdelete.all() end,   desc = 'Close all buffers' },
      { '<leader>xo', function() Snacks.bufdelete.other() end, desc = 'Close other buffers' },
      { '<leader>xt', '<cmd>tabclose<cr>',                     desc = 'Close tab' },
      { '<leader>nt', function() Snacks.terminal.open() end,   desc = '+git' },
    }
  },
  {
    'kawre/leetcode.nvim',
    dependencies = {
      'ibhagwan/fzf-lua',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      { '3rd/image.nvim', build = false, opts = { window_overlap_clear_enabled = true } }
    },
    cmd = { 'Leet' },
    opts = {
      lang = 'rust',
      image_support = true
    },
  }
}
