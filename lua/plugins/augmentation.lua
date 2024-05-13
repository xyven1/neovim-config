return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {}
  },
  {
    "direnv/direnv.vim",
    lazy = false,
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
    'tzachar/highlight-undo.nvim',
    event = "LazyFile",
    opts = {},
  },
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require 'colorizer'.setup({
        '*',
        css = { css = true, },
        javascript = { css_fn = true },
        html = { css_fn = true },
      }, { names = false, RRGGBBAA = true })
    end,
    keys = {
      { '<leader>c', '<cmd>ColorizerToggle<cr>', desc = 'Toggle colorizer' }
    }
  },
  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf'
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
    'numToStr/Comment.nvim',
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      opts = {
        enable_autocmd = false,
      }
    },
    keys = { "gb", "gc" },
    config = function()
      require('Comment').setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      })
    end,
  },
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = "LazyFile",
    opts = {}
  },
  {
    'kylechui/nvim-surround',
    event = 'LazyFile',
    opts = {}
  },
  {
    'lambdalisue/suda.vim',
    init = function()
      vim.g.suda_smart_edit = 1
    end
  },
  {
    'kazhala/close-buffers.nvim',
    keys = { '<leader>x' },
    config = function()
      local delete = function(o) return function() require('close_buffers').delete(o) end end
      local wk = require('which-key')
      wk.register({
        x = {
          name = 'Close',
          x = { delete({ type = 'this' }), 'Close current buffer' },
          f = { delete({ type = 'this', force = true }), 'Force close current buffer' },
          n = { delete({ type = 'nameless' }), 'Close nameless buffers' },
          h = { delete({ type = 'hidden' }), 'Close hidden buffers' },
          a = { delete({ type = 'all' }), 'Close all buffers' },
          o = { delete({ type = 'other' }), 'Close other buffers' },
          t = { "<cmd>tabclose<cr>", 'Close tab' },
        }
      }, {
        prefix = '<leader>',
      })
    end
  },
  {
    'Shatur/neovim-session-manager',
    cmd = { 'SessionManager' },
    keys = {
      { '<leader>w', '<cmd>SessionManager load_session<cr>', desc = 'Load session' },
    },
    config = function()
      require 'session_manager'.setup {
        autoload_mode = require('session_manager.config').AutoloadMode.Disabled,
      }
    end
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {
      check_ts = true,
      map_bs = false,
      map_cr = false,
    },
    keys = {
      {
        '<cr>',
        function()
          local npairs = require('nvim-autopairs')
          local function auto_cr()
            return vim.api.nvim_feedkeys(npairs.autopairs_cr(), "n", false) or ""
          end
          if vim.fn.pumvisible() ~= 0 then
            if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
              return npairs.esc('<c-y>')
            else
              return npairs.esc('<c-e>') .. auto_cr()
            end
          else
            return auto_cr()
          end
        end,
        desc = 'Map autopairs CR',
        mode = { 'i' },
        expr = true
      },
      {
        '<bs>',
        function()
          local npairs = require('nvim-autopairs')
          if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
            return npairs.esc('<c-e>') .. '<bs>'
          else
            return '<bs>'
          end
        end,
        desc = 'Map autopairs BS',
        mode = { 'i' },
        expr = true
      },
      {
        '<C-l>',
        function()
          local closers = { ")", "]", "}", ">", "'", "\"", "`", "," }
          local line = vim.api.nvim_get_current_line()
          local row, col = unpack(vim.api.nvim_win_get_cursor(0))
          local after = line:sub(col + 1, -1)
          local closer_col = #after + 1
          local closer_i = nil
          for i, closer in ipairs(closers) do
            local cur_index, _ = after:find(closer)
            if cur_index and (cur_index < closer_col) then
              closer_col = cur_index
              closer_i = i
            end
          end
          if closer_i then
            vim.api.nvim_win_set_cursor(0, { row, col + closer_col })
          else
            vim.api.nvim_win_set_cursor(0, { row, col + 1 })
          end
        end,
        desc = 'Escape pair',
        mode = { 'i' }
      },
    }
  },
  {
    'RRethy/vim-illuminate',
    event = 'LazyFile',
    keys = {
      { '<leader>I', function() require('illuminate').toggle() end, desc = 'Toggle hover illumination' }
    },
    opts = {},
    config = function(_, opts)
      require('illuminate').configure(opts)
    end
  }
}
