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
    'tzachar/highlight-undo.nvim',
    event = "BufEnter",
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
    'numToStr/Comment.nvim',
    event = "BufEnter",
    opts = {}
  },
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = "BufEnter",
    opts = {}
  },
  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    opts = {}
  },
  { 'lambdalisue/suda.vim' },
  {
    'kazhala/close-buffers.nvim',
    opts = {},
    keys = {
      {
        '<leader>xx',
        function() require('close_buffers').delete({ type = 'this' }) end,
        desc =
        'Close current buffer'
      },
      {
        '<leader>xf',
        function() require('close_buffers').delete({ type = 'this', force = true }) end,
        desc =
        'Force close current buffer'
      },
      {
        '<leader>xn',
        function() require('close_buffers').delete({ type = 'nameless' }) end,
        desc =
        'Close nameless buffers'
      },
      {
        '<leader>xh',
        function() require('close_buffers').delete({ type = 'hidden' }) end,
        desc =
        'Close hidden buffers'
      },
      {
        '<leader>xa',
        function() require('close_buffers').delete({ type = 'all' }) end,
        desc =
        'Close all buffers'
      },
      {
        '<leader>xo',
        function() require('close_buffers').delete({ type = 'other' }) end,
        desc =
        'Close other buffers'
      },
    }
  },
  {
    'Shatur/neovim-session-manager',
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
}
