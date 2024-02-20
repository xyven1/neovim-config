return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'ms-jpq/coq_nvim',
      {
        'folke/neodev.nvim',
        lazy = true
      },
      'williamboman/mason-lspconfig.nvim',
    },
    event = "VeryLazy",
    opts = {
      servers = {
        ["rust-analyzer"] = {
          checkOnSave = {
            command = "clippy",
          },
        },
        ["nil"] = {
          formatting = {
            command = { "alejandra" },
          },
        },
        ["lua_ls"] = function()
          require('neodev').setup {}
          return {
            Lua = {
              diagnostics = {
                globals = { "vim" }
              }
            }
          }
        end,
      }
    },
    init = function()
      vim.diagnostic.config({
        virtual_text = {
          source = 'ifmany',
        },
        severity_sort = true,
      })

      local signs = { Error = "󰅚 ", Warn = " ", Hint = "󰌶 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
    end,
    config = function(_, opts)
      local lspconfig = require('lspconfig')
      local coq = require('coq')
      local mason_lspconfig = require('mason-lspconfig')

      mason_lspconfig.setup_handlers {
        function(server_name)
          local config = opts.servers[server_name] or {}
          if type(config) == "function" then
            config = config()
          end
          config.capabilities = vim.lsp.protocol.make_client_capabilities()
          config.capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
          }
          config = coq.lsp_ensure_capabilities(config)
          lspconfig[server_name].setup(config)
        end,
      }
    end,
    keys = {
      {
        '<leader>i',
        function()
          vim.lsp.inlay_hint.enable(nil, not vim.lsp.inlay_hint.is_enabled(nil))
        end,
        desc = "Toggle inlay hints"
      },
    },
  },
  {
    'xyven1/formatter.nvim',
    branch = 'patch-1',
    cmd = { "Format", "FormatWrite", "FormatLock", "FormatWriteLock" },
    opts = {},
    init = function()
      vim.F.format_buf = function()
      end
    end,
    config = function(_, opts)
      vim.api.nvim_create_augroup("__formatter__", { clear = true })
      vim.api.nvim_create_autocmd("BufWritePost", {
        group = "__formatter__",
        pattern = "*.go",
        callback = function()
          local format = require('formatter.format').format
          if not format('', '', 1, vim.fn.line("$"), { write = true }) then
            vim.lsp.buf.format({ async = false })
            vim.api.nvim_command "update"
          end
        end
      })
      require("formatter").setup(vim.tbl_deep_extend("force", opts, {
        filetype = {
          python = {
            require("formatter.filetypes.python").isort,
            require("formatter.filetypes.python").black,
          },
        }
      }))
    end,
    keys = {
      {
        '<leader>f',
        function()
          local line1
          local line2
          if vim.fn.visualmode() == "V" then
            line1 = vim.fn.line("'<")
            line2 = vim.fn.line("'>")
          else
            line1 = 1
            line2 = vim.fn.line("$")
          end
          local write = vim.bo.modified == false
          if not require('formatter.format').format('', '', line1, line2, { write }) then
            -- vim.notify("Formatter.nvim not setup for this language, trying lsp...", vim.log.levels.WARN)
            local view = vim.fn.winsaveview()
            vim.lsp.buf.format({ async = false })
            if view then
              vim.fn.winrestview(view)
            end
            if write then
              vim.api.nvim_command "update"
            end
          end
        end,
        desc = "Format buffer"
      },
    }
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    event = "BufEnter",
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
    event = "VeryLazy",
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
    event = 'BufRead',
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
      { '<leader>sw', "<cmd>TroubleToggle<cr>",                           desc = 'Show workspace diagnostics' },
      { '[e',         "<cmd>Lspsaga diagnostic_jump_prev<cr>",            desc = 'Jump to previous diagnostic' },
      { ']e',         "<cmd>Lspsaga diagnostic_jump_next<cr>",            desc = 'Jump to next diagnostic' },
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
        '[E',
        function()
          require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
        end,
        desc = 'Jump to previous error'
      },
      {
        ']E',
        function()
          require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
        end,
        desc = 'Jump to next error'
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
}
