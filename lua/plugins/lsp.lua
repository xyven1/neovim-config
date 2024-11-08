return {
  {
    'WieeRd/auto-lsp.nvim',
    dependencies = { 'neovim/nvim-lspconfig', },
    event = 'VeryLazy',
    opts = {
      ['*'] = function()
        local capabilities = require('blink.cmp').get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())
        capabilities.textDocument.foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true
        }
        return {
          capabilities = capabilities
        }
      end,
      tailwindcss = {
        filetypes = {
          'html', 'css', 'scss', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'svelte', 'vue',
          'jsx', 'tsx'
        }
      },
      rust_analyzer = {
        settings = {
          ['rust-analyzer'] = {
            checkOnSave = {
              command = 'clippy',
            },
          }
        }
      },
      lua_ls = function()
        require('lazydev')
        return {}
      end,
      clangd = {
        capabilities = { offsetEncoding = { 'utf-16' } }
      }
    },
  },
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspStart', 'LspStop' },
    keys = {
      {
        '<leader>uh',
        function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
        end,
        desc = 'Toggle inlay hints'
      },
    },
  },
  {
    'folke/lazydev.nvim',
    dependencies = { 'Bilal2453/luvit-meta' },
    opts = {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    }
  },
  {
    'stevearc/conform.nvim',
    cmd = { 'ConformInfo' },
    opts = {
      formatters_by_ft = {
        nix = { 'alejandra' },
        python = function(bufnr)
          if require('conform').get_formatter_info('ruff_format', bufnr).available then
            return { 'ruff_format', 'ruff_organize_imports' }
          else
            return { 'isort', 'black' }
          end
        end,
        cpp = { 'astyle' },
        rust = { 'rustfmt' }
      }
    },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format({
            async = true,
            lsp_fallback = true,
          })
        end,
        desc = 'Format buffer',
        mode = { 'n', 'v' }
      },
    }
  },
  {
    'mfussenegger/nvim-lint',
    event = 'LazyFile',
    opts = {
      events = { 'BufWritePost', 'BufReadPost', 'InsertLeave' },
      linters_by_ft = {
        make = { 'checkmake' }
      },
      linters = {},
    },
    config = function(_, opts)
      local M = {}

      local lint = require('lint')
      for name, linter in pairs(opts.linters) do
        if type(linter) == 'table' and type(lint.linters[name]) == 'table' then
          lint.linters[name] = vim.tbl_deep_extend('force', lint.linters[name], linter)
          if type(linter.prepend_args) == 'table' then
            lint.linters[name].args = lint.linters[name].args or {}
            vim.list_extend(lint.linters[name].args, linter.prepend_args)
          end
        else
          lint.linters[name] = linter
        end
      end
      lint.linters_by_ft = opts.linters_by_ft

      function M.debounce(ms, fn)
        local timer = vim.uv.new_timer()
        return function(...)
          local argv = { ... }
          timer:start(ms, 0, function()
            timer:stop()
            vim.schedule_wrap(fn)(unpack(argv))
          end)
        end
      end

      function M.lint()
        -- Use nvim-lint's logic first:
        -- * checks if linters exist for the full filetype first
        -- * otherwise will split filetype by '.' and add all those linters
        -- * this differs from conform.nvim which only uses the first filetype that has a formatter
        local names = lint._resolve_linter_by_ft(vim.bo.filetype)

        -- Create a copy of the names table to avoid modifying the original.
        names = vim.list_extend({}, names)

        -- Add fallback linters.
        if #names == 0 then
          vim.list_extend(names, lint.linters_by_ft['_'] or {})
        end

        -- Add global linters.
        vim.list_extend(names, lint.linters_by_ft['*'] or {})

        -- Filter out linters that don't exist or don't match the condition.
        local ctx = { filename = vim.api.nvim_buf_get_name(0) }
        ctx.dirname = vim.fn.fnamemodify(ctx.filename, ':h')
        names = vim.tbl_filter(function(name)
          local linter = lint.linters[name]
          if not linter then
            vim.notify('Linter not found: ' .. name, vim.log.levels.WARN, { title = 'nvim-lint' })
          end
          return linter and not (type(linter) == 'table' and linter.condition and not linter.condition(ctx))
        end, names)

        -- Run linters.
        if #names > 0 then
          lint.try_lint(names)
        end
      end

      vim.api.nvim_create_autocmd(opts.events, {
        group = vim.api.nvim_create_augroup('nvim-lint', { clear = true }),
        callback = M.debounce(100, M.lint),
      })
    end,
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    event = 'BufRead',
    init = function()
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    opts = {
      fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (' 󰁂 %d '):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        vim.api.nvim_set_hl(0, 'FoldSuffix', {
          bg = vim.api.nvim_get_hl(0, { name = 'UfoFoldedBg' }).bg,
          fg = vim.api.nvim_get_hl(0, { name = 'LineNr' }).fg,
        })
        table.insert(newVirtText, { suffix, 'FoldSuffix' })
        return newVirtText
      end,
      preview = {
        win_config = {
          border = 'solid',
          winblend = 0
        },
        mappings = {
          scrollU = '<C-b>',
          scrollD = '<C-f>'
        }
      }
    },
    keys = {
      { 'zr', function() require('ufo').openFoldsExceptKinds() end,   desc = 'Open folds' },
      { 'zR', function() require('ufo').openAllFolds() end,           desc = 'Open all folds' },
      { 'zm', function(opts) require('ufo').closeFoldsWith(opts) end, desc = 'Close folds' },
      {
        'K',
        function()
          if not require('ufo').peekFoldedLinesUnderCursor() then
            vim.cmd [[Lspsaga hover_doc]]
          end
        end,
        desc = 'Hover'
      }
    },
  },
  -- Completion
  {
    'saghen/blink.cmp',
    lazy = false,
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = 'v0.*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide' },
        ['<Tab>'] = { 'select_and_accept', 'fallback' },

        ['<C-p>'] = { 'select_prev', 'fallback' },
        ['<C-n>'] = { 'select_next', 'fallback' },

        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

        ['<C-y>'] = { 'snippet_forward', 'fallback' },
        ['<C-S-y>'] = { 'snippet_backward', 'fallback' },
      },
      highlight = {
        use_nvim_cmp_as_default = true,
      },
      windows = {
        autocomplete = {
          winblend = vim.o.pumblend,
        },
      },
      nerd_font_variant = 'mono',
      accept = { auto_brackets = { enabled = true } },
      trigger = { signature_help = { enabled = true } },
    }
  },
  {
    'zbirenbaum/copilot.lua',
    cmd = { 'Copilot' },
    event = 'LazyFile',
    opts = function()
      return vim.fn.executable('nvim-node') == 1 and {
        copilot_node_command = 'nvim-node'
      } or {}
    end
  },
  -- UI
  {
    'glepnir/lspsaga.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = { 'Lspsaga' },
    event = 'LspAttach',
    opts = {
      ui = {
        border = 'solid',
      },
      implement = {
        enable = true,
        lang = { 'rust' },
      },
      lightbulb = {
        enable = false,
      },
      code_action = {
        extend_gitsigns = true,
      },
    },
    keys = {
      { 'ga',         '<cmd>Lspsaga finder<cr>',                          desc = 'Open symbol finder' },
      { 'ghi',        '<cmd>Lspsaga finder imp<cr>',                      desc = 'Find all implementations' },
      { 'ghr',        '<cmd>Lspsaga finder ref<cr>',                      desc = 'Find all references' },
      { 'ghd',        '<cmd>Lspsaga finder def<cr>',                      desc = 'Find all definitions' },
      { 'gr',         '<cmd>Lspsaga rename<cr>',                          desc = 'Rename symbol' },
      { 'gR',         '<cmd>Lspsaga rename ++project<cr>',                desc = 'Rename symbol (project)' },
      { 'gd',         '<cmd>Lspsaga peek_definition<cr>',                 desc = 'Peek definition' },
      { 'gD',         '<cmd>Lspsaga goto_definition<cr>',                 desc = 'Goto definition' },
      { 'gt',         '<cmd>Lspsaga peek_type_definition<cr>',            desc = 'Peek type definition' },
      { 'gT',         '<cmd>Lspsaga goto_type_definition<cr>',            desc = 'Goto type definition' },
      { '<leader>sl', '<cmd>Lspsaga show_line_diagnostics ++unfocus<cr>', desc = 'Show line diagnostics' },
      { '<leader>sc', '<cmd>Lspsaga show_cursor_diagnostics<cr>',         desc = 'Show cursor diagnostics' },
      { '<leader>sb', '<cmd>Lspsaga show_buf_diagnostics<cr>',            desc = 'Show buffer diagnostics' },
      { '<leader>sw', '<cmd>Trouble diagnostics toggle<cr>',              desc = 'Show workspace diagnostics' },
      { '[d',         '<cmd>Lspsaga diagnostic_jump_prev<cr>',            desc = 'Jump to previous diagnostic' },
      { ']d',         '<cmd>Lspsaga diagnostic_jump_next<cr>',            desc = 'Jump to next diagnostic' },
      { 'K',          '<cmd>Lspsaga hover_doc<cr>',                       desc = 'Show symbol information',    mode = { 'n', 'v' } },
      { '<leader>a',  '<cmd>Lspsaga code_action<cr>',                     desc = 'Show code actions',          mode = { 'n', 'v' } },
      { '<A-d>',      '<cmd>Lspsaga term_toggle<cr>',                     desc = 'Toggle floating terminal',   mode = { 'n', 't' } },
      {
        '[e',
        function()
          require('lspsaga.diagnostic'):goto_prev({ severity = vim.diagnostic.severity.ERROR })
        end,
        desc = 'Jump to previous error'
      },
      {
        ']e',
        function()
          require('lspsaga.diagnostic'):goto_next({ severity = vim.diagnostic.severity.ERROR })
        end,
        desc = 'Jump to next error'
      },
      {
        '[w',
        function()
          require('lspsaga.diagnostic'):goto_prev({ severity = vim.diagnostic.severity.WARN })
        end,
        desc = 'Jump to previous warning'
      },
      {
        ']w',
        function()
          require('lspsaga.diagnostic'):goto_next({ severity = vim.diagnostic.severity.WARN })
        end,
        desc = 'Jump to next warning'
      },
    },
  },
}
