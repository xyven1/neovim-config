return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'ms-jpq/coq_nvim',
      { 'folke/neodev.nvim', lazy = true },
    },
    event = "VeryLazy",
    opts = {
      servers = {
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
          require('neodev').setup {}
          return {}
        end,
      }
    },
    config = function(_, opts)
      vim.diagnostic.config({
        virtual_text = {
          source = "if_many",
        },
        severity_sort = true,
      })

      local signs = { Error = "󰅚 ", Warn = " ", Hint = "󰌶 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
      local lspconfig = require('lspconfig')
      local coq = require('coq')
      local mason_lspconfig = require('mason-lspconfig')

      local setup_server = function(server_name)
        local config = opts.servers[server_name] or {}
        if type(config) == "function" then
          config = config() or {}
        end
        config.capabilities = vim.lsp.protocol.make_client_capabilities()
        config.capabilities.textDocument.foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true
        }
        config = coq.lsp_ensure_capabilities(config)
        lspconfig[server_name].setup(config)
      end
      mason_lspconfig.setup_handlers({ setup_server })
      setup_server "nil_ls"
    end,
    keys = {
      {
        '<leader>uh',
        function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
        end,
        desc = "Toggle inlay hints"
      },
    },
  },
  {
    'stevearc/conform.nvim',
    cmd = { 'ConformInfo' },
    opts = {
      formatters_by_ft = {
        nix = { 'alejandra' },
        python = { 'isort', 'black' },
        cpp = { 'astyle' },
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
        desc = "Format buffer",
        mode = { 'n', 'v' }
      },
    }
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    event = "BufRead",
    init = function()
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    opts = {},
    keys = {
      { 'zR', function() require('ufo').openAllFolds() end,  desc = 'Open all folds' },
      { 'zM', function() require('ufo').closeAllFolds() end, desc = 'Close all folds' },
    },
  },
  -- Completion
  {
    'ms-jpq/coq_nvim',
    dependencies = {
      'ms-jpq/coq.artifacts',
      'ms-jpq/coq.thirdparty',
    },
    init = function()
      vim.g.coq_settings = {
        auto_start = 'shut-up',
        clients = {
          -- tree_sitter = { enabled = false },
          buffers = { enabled = false },
          paths = { preview_lines = 3 }
        },
        display = {
          icons = { mode = 'short' },
          ghost_text = {
            context = { " ⟨ ", " ⟩" },
          },
        },
        keymap = {
          recommended = false,
          jump_to_mark = "<c-m>",
        },
      }
    end,
    keys = {
      {
        '<esc>',
        function() return vim.fn.pumvisible() == 1 and "<c-e><esc>" or "<esc>" end,
        desc = "Map popup escape",
        mode = { 'i' },
        expr = true
      },
      {
        '<c-c>',
        function() return vim.fn.pumvisible() == 1 and "<c-e><c-c>" or "<c-c>" end,
        desc = "Map popup Ctrl C",
        mode = { 'i' },
        expr = true
      },
      {
        '<tab>',
        function() return vim.fn.pumvisible() == 1 and "<c-n>" or "<tab>" end,
        desc = "Map popup tab",
        mode = { 'i' },
        expr = true
      },
      {
        '<s-tab>',
        function() return vim.fn.pumvisible() == 1 and "<c-p>" or "<bs>" end,
        desc = "Map popup shift tab",
        mode = { 'i' },
        expr = true
      },
    }
  },
  {
    'ms-jpq/coq.thirdparty',
    dependencies = {
      'github/copilot.vim',
    },
    config = function()
      require('coq_3p') {
        { src = 'copilot', short_name = 'COP', accept_key = '<c-f>' },
        { src = "dap" }
      }
    end
  },
  -- UI
  {
    'glepnir/lspsaga.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'LazyFile',
    opts = {
      implement = {
        enable = true,
        lang = { 'rust' }
      },
      lightbulb = {
        sign = false,
      },
      code_action = {
        extend_gitsigns = true,
      },
    },
    keys = {
      { 'ga',         "<cmd>Lspsaga finder<cr>",                          desc = 'Open symbol finder' },
      { 'ghi',        "<cmd>Lspsaga finder imp<cr>",                      desc = 'Find all implementations' },
      { 'ghr',        "<cmd>Lspsaga finder ref<cr>",                      desc = 'Find all references' },
      { 'ghd',        "<cmd>Lspsaga finder def<cr>",                      desc = 'Find all definitions' },
      { 'gr',         "<cmd>Lspsaga rename<cr>",                          desc = 'Rename symbol' },
      { 'gR',         "<cmd>Lspsaga rename ++project<cr>",                desc = 'Rename symbol (project)' },
      { 'gd',         "<cmd>Lspsaga peek_definition<cr>",                 desc = 'Peek definition' },
      { 'gD',         "<cmd>Lspsaga goto_definition<cr>",                 desc = 'Goto definition' },
      { 'gt',         "<cmd>Lspsaga peek_type_definition<cr>",            desc = 'Peek type definition' },
      { 'gT',         "<cmd>Lspsaga goto_type_definition<cr>",            desc = 'Goto type definition' },
      { '<leader>sl', "<cmd>Lspsaga show_line_diagnostics ++unfocus<cr>", desc = 'Show line diagnostics' },
      { '<leader>sc', "<cmd>Lspsaga show_cursor_diagnostics<cr>",         desc = 'Show cursor diagnostics' },
      { '<leader>sb', "<cmd>Lspsaga show_buf_diagnostics<cr>",            desc = 'Show buffer diagnostics' },
      { '<leader>sw', "<cmd>Trouble diagnostics toggle<cr>",              desc = 'Show workspace diagnostics' },
      { '[d',         "<cmd>Lspsaga diagnostic_jump_prev<cr>",            desc = 'Jump to previous diagnostic' },
      { ']d',         "<cmd>Lspsaga diagnostic_jump_next<cr>",            desc = 'Jump to next diagnostic' },
      { 'go',         "<cmd>Lspsaga outline<cr>",                         desc = 'Show outline' },
      {
        'K',
        function()
          if require('dap').session() then
            require("dapui").eval()
          else
            require("lspsaga.hover"):render_hover_doc()
          end
        end,
        desc = "Show symbol information",
        mode = { 'n', 'v' }
      },
      {
        '[e',
        function()
          require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
        end,
        desc = 'Jump to previous error'
      },
      {
        ']e',
        function()
          require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
        end,
        desc = 'Jump to next error'
      },
      {
        '[w',
        function()
          require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.WARN })
        end,
        desc = 'Jump to previous warning'
      },
      {
        ']w',
        function()
          require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.WARN })
        end,
        desc = 'Jump to next warning'
      },
      {
        '<A-d>',
        "<cmd>Lspsaga term_toggle<cr>",
        desc = 'Toggle floating terminal',
        mode = { 'n', 't' }
      },
      {
        '<leader>a',
        "<cmd>Lspsaga code_action<cr>",
        desc = 'Show code actions',
        mode = { 'n', 'v' }
      },
    },
  },
  {
    'mfussenegger/nvim-lint',
    event = "LazyFile",
    opts = {
      events = { "BufWritePost", "BufReadPost", "InsertLeave" },
      linters_by_ft = {
        make = { 'checkmake' }
      },
      linters = {},
    },
    config = function(_, opts)
      local M = {}

      local lint = require("lint")
      for name, linter in pairs(opts.linters) do
        if type(linter) == "table" and type(lint.linters[name]) == "table" then
          lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter)
          if type(linter.prepend_args) == "table" then
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
        -- * otherwise will split filetype by "." and add all those linters
        -- * this differs from conform.nvim which only uses the first filetype that has a formatter
        local names = lint._resolve_linter_by_ft(vim.bo.filetype)

        -- Create a copy of the names table to avoid modifying the original.
        names = vim.list_extend({}, names)

        -- Add fallback linters.
        if #names == 0 then
          vim.list_extend(names, lint.linters_by_ft["_"] or {})
        end

        -- Add global linters.
        vim.list_extend(names, lint.linters_by_ft["*"] or {})

        -- Filter out linters that don't exist or don't match the condition.
        local ctx = { filename = vim.api.nvim_buf_get_name(0) }
        ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
        names = vim.tbl_filter(function(name)
          local linter = lint.linters[name]
          if not linter then
            vim.notify("Linter not found: " .. name, vim.log.levels.WARN, { title = "nvim-lint" })
          end
          return linter and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
        end, names)

        -- Run linters.
        if #names > 0 then
          lint.try_lint(names)
        end
      end

      vim.api.nvim_create_autocmd(opts.events, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = M.debounce(100, M.lint),
      })
    end,
  }
}
