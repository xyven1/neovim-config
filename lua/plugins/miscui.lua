return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {}
  },
  {
    'stevearc/quicker.nvim',
    event = 'FileType qf',
    ---@module 'quicker'
    ---@type quicker.SetupOptions
    opts = {},
  },
  {
    'folke/noice.nvim',
    dependencies = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' },
    event = 'VeryLazy',
    opts = {
      lsp = {
        hover = { enabled = false },
        signature = { enabled = false },
      },
      cmdline = {
        view = 'cmdline'
      },
      presets = {
        bottom_search = true,         -- use a classic bottom cmdline for search
        command_palette = false,      -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
      },
    },
    keys = {
      { '\\', '<cmd>NoiceDismiss<cr>', desc = 'Clear notifications' }
    }
  },
  {
    'tzachar/highlight-undo.nvim',
    event = 'LazyFile',
    opts = {},
  },
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup({
        '*',
        css = { css = true, },
        javascript = { css_fn = true },
        html = { css_fn = true },
      }, { names = false, RRGGBBAA = true })
    end,
  },
  {
    'RRethy/vim-illuminate',
    event = 'LazyFile',
    opts = {
      large_file_cutoff = 4000,
      large_file_overrides = {
        providers = { 'lsp' }
      },
      modes_denylist = { 'i' },
    },
    config = function(_, opts)
      require('illuminate').configure(opts)
    end
  },
}
