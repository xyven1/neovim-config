local lsp_string = "The language server is either not installed, missing from PATH, or not executable"
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
    'stevearc/quicker.nvim',
    event = 'FileType qf',
    ---@module 'quicker'
    ---@type quicker.SetupOptions
    opts = {},
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    init = function()
      vim.notify = function(msg, level, opts)
        if type(msg) == 'string' and msg.find("The language server is either not installed, missing from PATH, or not executable") then
          return
        end
        vim.notify(msg, level, opts)
      end
    end,
    opts = {
      routes = {
        {
          filter = {
            event = "notify",
            find = "The language server is either not installed, missing from PATH, or not executable",
          },
          opts = { skip = true }
        }
      },
      lsp = {
        hover = { enabled = false },
        signature = { enabled = false },
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
      cmdline = {
        view = "cmdline"
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
      { '<leader>uc', '<cmd>ColorizerToggle<cr>', desc = 'Toggle colorizer' }
    }
  },
  {
    'RRethy/vim-illuminate',
    event = 'LazyFile',
    keys = {
      { '<leader>ui', function() require('illuminate').toggle() end, desc = 'Toggle hover illumination' }
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
            action = 'Resession load_dir'
          },
          {
            icon = '  ',
            desc = 'Open lastest session                    ',
            key = 'l',
            action = 'Resession load_latest'
          },
          {
            icon = '󰈢  ',
            desc = 'Recently opened sessions                ',
            key = 'r',
            action = 'Resession load'
          },
        },
      },
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  }
}
