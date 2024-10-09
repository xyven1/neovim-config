return {
  {
    'hiphish/rainbow-delimiters.nvim',
    dependencies = {
      'lukas-reineke/indent-blankline.nvim',
    },
    config = function()
      local rainbow = require 'rainbow-delimiters'
      require('rainbow-delimiters.setup').setup({
        strategy = {
          [''] = rainbow.strategy['global']
        },
        highlight = {
          'BracketHighlighting0',
          'BracketHighlighting1',
          'BracketHighlighting2',
        }
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
                'BracketHighlighting0',
                'BracketHighlighting1',
                'BracketHighlighting2',
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
