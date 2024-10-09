return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'folke/lazydev.nvim',
      'glepnir/lspsaga.nvim',
    },
    cmd = { "LspInfo", "LspStart", "LspStop" },
    event = "VeryLazy",
    opts = {

      servers = {
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
          require('lazydev').setup()
          return {}
        end,
        clangd = {
          capabilities = { offsetEncoding = { "utf-16" } }
        }
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
      local setup_server = function(server_name)
        local config = opts.servers[server_name] or {}
        if type(config) == "function" then
          config = config() or {}
        end
        config.capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(),
          config.capabilities or {})
        config.capabilities.textDocument.foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true
        }
        lspconfig[server_name].setup(config)
      end
      local configs = {
        "nimls", "lua_ls", "digestif", "psalm", "arduino_language_server", "nil_ls", "astro", "kotlin_language_server",
        "purescriptls", "nickel_ls", "futhark_lsp", "nixd", "scry", "clojure_lsp", "cssls", "glsl_analyzer", "clangd",
        "ruby_lsp", "taplo", "fortls", "vala_ls", "crystalline", "flow", "terraformls", "pyright", "elixirls",
        "fennel_ls", "ansiblels", "jedi_language_server", "idris2_lsp", "fsautocomplete", "tilt_ls", "asm_lsp",
        "docker_compose_language_service", "coq_lsp", "ts_ls", "gleam", "ocamllsp", "texlab", "perlls", "omnisharp",
        "metals", "glslls", "gopls", "efm", "erlangls", "intelephense", "rust_analyzer", "dhall_lsp_server",
        "terraform_lsp", "jdtls", "slint_lsp", "jsonnet_ls", "ltex", "bashls", "diagnosticls", "basedpyright",
        "beancount", "matlab_ls", "marksman", "regal", "dartls", "denols", "blueprint_ls", "jsonls", "codeqlls", "fstar",
        "eslint", "vls", "nushell", "biome", "zls", "zk", "yamlls", "helm_ls", "cmake", "elmls", "vuels", "volar",
        "perlpls", "verible", "vimls", "vhdl_ls", "csharp_ls", "mint", "hyprls", "typst_lsp", "quick_lint_js", "tinymist",
        "tflint", "teal_ls", "ruff_lsp", "tailwindcss", "syntax_tree", "svls", "svelte", "stylelint_lsp", "sourcekit",
        "java_language_server", "solc", "regols", "jqls", "solargraph", "html", "r_language_server", "pylyzer",
        "mesonlsp", "pylsp", "ccls", "prismals", "postgres_lsp", "koka", "phpactor", "dotls", "bufls",
        "rune_languageserver", "nginx_language_server", "openscad_lsp", "millet", "hls", "nim_langserver",
        "perlnavigator", "dockerls", "dagger",
      }
      for _, config in ipairs(configs) do
        setup_server(config)
      end
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
    "mfussenegger/nvim-lint",
    event = "LazyFile",
    opts = {
      -- Event to trigger linters
      events = { "BufWritePost", "BufReadPost", "InsertLeave" },
      linters_by_ft = {
        fish = { "fish" },
        -- Use the "*" filetype to run linters on all filetypes.
        -- ['*'] = { 'global linter' },
        -- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
        -- ['_'] = { 'fallback linter' },
        -- ["*"] = { "typos" },
      },
      -- LazyVim extension to easily override linter options
      -- or add custom linters.
      ---@type table<string,table>
      linters = {
        -- -- Example of using selene only when a selene.toml file is present
        -- selene = {
        --   -- `condition` is another LazyVim extension that allows you to
        --   -- dynamically enable/disable linters based on the context.
        --   condition = function(ctx)
        --     return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
        --   end,
        -- },
      },
    },
    config = function(_, opts)
      local M = {}

      local lint = require("lint")
      for name, linter in pairs(opts.linters) do
        if type(linter) == "table" and type(lint.linters[name]) == "table" then
          lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter)
          if type(linter.prepend_args) == "table" then
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
            LazyVim.warn("Linter not found: " .. name, { title = "nvim-lint" })
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
    'saghen/blink.cmp',
    lazy = false,
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = 'v0.*',
    opts = {
      highlight = {
        use_nvim_cmp_as_default = true,
      },
      keymap = {
        select_prev = { '<Up>', '<C-p>' },
        select_next = { '<Down>', '<C-n>' },
      },
      nerd_font_variant = 'mono',
      accept = { auto_brackets = { enabled = true } },
      trigger = { signature_help = { enabled = true } },
    }
  },
  {
    'zbirenbaum/copilot.lua',
    cmd = { "Copilot" },
    event = "LazyFile",
    opts = {}
  },
  -- UI
  {
    'glepnir/lspsaga.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
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
      { 'K',          "<cmd>Lspsaga hover_doc<cr>",                       desc = "Show symbol information",    mode = { 'n', 'v' } },
      { '<leader>a',  "<cmd>Lspsaga code_action<cr>",                     desc = 'Show code actions',          mode = { 'n', 'v' } },
      { '<A-d>',      "<cmd>Lspsaga term_toggle<cr>",                     desc = 'Toggle floating terminal',   mode = { 'n', 't' } },
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
    },
  },
}
