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
    'kevinhwang91/nvim-bqf',
    ft = 'qf'
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      cmdline = {
        view = "cmdline"
      },
      popupmenu = {
        enabled = false,
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true,         -- use a classic bottom cmdline for search
        command_palette = false,      -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true,        -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      { "rcarriga/nvim-notify", opts = { top_down = false, } },
    },
    keys = {
      { '\\', '<cmd>NoiceDismiss<cr>', desc = 'Clear notifications' }
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
    'RRethy/vim-illuminate',
    event = 'LazyFile',
    keys = {
      { '<leader>i', function() require('illuminate').toggle() end, desc = 'Toggle hover illumination' }
    },
    opts = {
      large_file_cutoff = 4000,
      large_file_overrides = {
        providers = { "lsp" }
      }
    },
    config = function(_, opts)
      require('illuminate').configure(opts)
    end
  },
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    opts = {
      theme = 'doom',
      config = {
        week_header = {
          enable = true,
        },
        center = {
          {
            icon = '  ',
            desc = 'Open current directory\'s session       ',
            key = 's',
            action = 'SessionManager load_current_dir_session'
          },
          {
            icon = '  ',
            desc = 'Open lastest session                    ',
            key = 'l',
            action = 'SessionManager load_last_session'
          },
          {
            icon = '󰈢  ',
            desc = 'Recently opened sessions                ',
            key = 'r',
            action = 'SessionManager load_session'
          },
        },
      },
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  } }
