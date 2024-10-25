return {
  {
    'hiphish/rainbow-delimiters.nvim',
    dependencies = {
      'lukas-reineke/indent-blankline.nvim',
    },
    init = function()
      vim.g.rainbow = false
    end,
    config = function()
      local rainbow = require 'rainbow-delimiters'
      require('rainbow-delimiters.setup').setup({
        strategy = {
          [''] = rainbow.strategy['global']
        },
      })
      vim.g.rainbow = false
      vim.api.nvim_create_autocmd('BufEnter', {
        callback = function() if vim.g.rainbow then rainbow.enable(0) else rainbow.disable(0) end end
      })
    end,
    keys = {
      {
        '<leader>ur',
        function()
          local scope = {}
          if vim.g.rainbow then
            vim.g.rainbow = false
            scope = {
              show_start = false,
              show_end = false,
              highlight = {
                'IndentBlanklineContextChar',
              }
            }
            require('rainbow-delimiters').disable(0)
          else
            vim.g.rainbow = true
            scope = {
              show_start = true,
              show_end = true,
              highlight = {
                'RainbowRed',
                'RainbowYellow',
                'RainbowBlue',
                'RainbowOrange',
                'RainbowGreen',
                'RainbowViolet',
                'RainbowCyan',
              }
            }
            require('rainbow-delimiters').enable(0)
          end
          require('ibl').update({ scope = scope })
        end,
        desc = 'Toggle rainbow delimiters'
      }
    },
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'LazyFile',
    opts = {
      indent = {
        char = '▏',
        highlight = {
          'IndentBlanklineChar',
        }
      },
      exclude = {
        filetypes = { 'dashboard' },
      },
      scope = {
        show_start = false,
        show_end = false,
        injected_languages = true,
        highlight = {
          'IndentBlanklineContextChar'
        },
      }
    },
    config = function(_, opts)
      local hooks = require 'ibl.hooks'
      require('ibl').setup(opts)
      vim.api.nvim_create_autocmd('ColorScheme', {
        pattern = "*",
        callback = function()
          local highlights = {
            IndentBlanklineChar = { fg = "#4b5263" },
            IndentBlanklineContextChar = { fg = "#4b5263" },
            RainbowRed = { fg = "#E06C75" },
            RainbowYellow = { fg = "#E5C07B" },
            RainbowBlue = { fg = "#61AFEF" },
            RainbowOrange = { fg = "#D19A66" },
            RainbowGreen = { fg = "#98C379" },
            RainbowViolet = { fg = "#C678DD" },
            RainbowCyan = { fg = "#56B6C2" },
          }
          for group, hl in pairs(highlights) do
            if vim.fn.hlexists(group) == 0 then
              vim.api.nvim_set_hl(0, group, hl)
            end
          end
        end
      })
      -- hooks.register(hooks.type.HIGHLIGHT_SETUP, )
      hooks.register(hooks.type.SCOPE_HIGHLIGHT, function(tick, bufnr, scope, scope_index)
        if vim.g.rainbow then
          return hooks.builtin.scope_highlight_from_extmark(tick, bufnr, scope, scope_index)
        else
          return 0
        end
      end)
    end
  },
  {
    'NMAC427/guess-indent.nvim',
    event = 'LazyFile',
    opts = {}
  }
}
