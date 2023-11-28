local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--single-branch',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

local function get_config(name)
  return function()
    require('config/' .. name)
  end
end

-- map leader
vim.keymap.set("n", "<Space>", "<NOP>", { noremap = true, silent = true, desc = "Disable space" })
vim.g.mapleader = " "
-- paste over currently selected text without yanking it
vim.keymap.set("v", "p", "\"_dP", { noremap = true, silent = true, desc = "Paste over selected text" })

require('lazy').setup({
  defaults = {
    lazy = true
  },
  -- Coding productivity
  -- Completion
  {
    'ms-jpq/coq_nvim',
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
  { 'ms-jpq/coq.artifacts' },
  {
    'ms-jpq/coq.thirdparty',
    event = "VeryLazy",
    config = function()
      require('coq_3p') {
        { src = 'copilot', short_name = 'COP', accept_key = '<c-f>' },
        { src = "dap" }
      }
    end
  },
  -- Mason
  { 'williamboman/mason.nvim', cmd = { "Mason" }, opts = {
    PATH = 'append',
  } },
  {
    'williamboman/mason-lspconfig.nvim',
    opts = {
      ensure_installed = {},
      inlay_hints = { enabled = true }
    },
    keys = {
      { '<leader>f', function() vim.lsp.buf.format({ async = true }) end, desc = "Format buffer" },
      { '<leader>i', function() vim.lsp.inlay_hint(0, nil) end,           desc = "Toggle inlay hints" },
    },
    dependencies = { 'williamboman/mason.nvim' }
  },
  {
    'jay-babu/mason-nvim-dap.nvim',
    event = "BufEnter",
    opts = {
      automatic_setup = true,
    },
    dependencies = { 'williamboman/mason.nvim' }
  },
  -- LSP
  {
    'neovim/nvim-lspconfig',
    event = "VeryLazy",
    config = get_config('lsp'),
    dependencies = { 'ms-jpq/coq_nvim',
      'folke/neodev.nvim'
    }
  },
  {
    'kevinhwang91/nvim-ufo',
    opts = {},
    event = "BufEnter",
    keys = {
      { 'zR', function() require('ufo').openAllFolds() end,  desc = 'Open all folds' },
      { 'zM', function() require('ufo').closeAllFolds() end, desc = 'Close all folds' },
    },
    dependencies = { 'kevinhwang91/promise-async' },
  },
  -- DAP
  {
    'mfussenegger/nvim-dap',
    lazy = true,
    config = get_config('dap'),
    keys = {
      {
        '<f5>',
        function() require('dap').continue() end,
        desc = 'Continue'
      },
      {
        '<f10>',
        function() require('dap').step_over() end,
        desc = 'Step over'
      },
      {
        '<f11>',
        function() require('dap').step_into() end,
        desc = 'Step into'
      },
      {
        '<f12>',
        function() require('dap').step_out() end,
        desc = 'Step out'
      },
      {
        '<leader>b',
        function() require('dap').toggle_breakpoint() end,
        desc = 'Toggle breakpoint'
      },
      {
        '<leader>B',
        function() require('dap').set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
        desc = 'Breakpoint with condition'
      },
    },
    dependencies = {
      'theHamsta/nvim-dap-virtual-text',
    }
  },
  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    config = get_config('treesitter'),
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/nvim-treesitter-textobjects'
    },
  },
  -- Indent
  { 'nvim-treesitter/playground', cmd = 'TSPlaygroundToggle' },
  {
    'hiphish/rainbow-delimiters.nvim',
    config = function()
      local rainbow = require 'rainbow-delimiters'
      require('rainbow-delimiters.setup').setup({
        strategy = {
          [''] = rainbow.strategy['global']
        },
        highlight = {
          "BracketHighlighting0",
          "BracketHighlighting1",
          "BracketHighlighting2",
        }
      })
      vim.g.rainbow = false
      vim.api.nvim_create_autocmd('BufEnter', {
        callback = function() if vim.g.rainbow then rainbow.enable(0) else rainbow.disable(0) end end
      })
    end,
    keys = {
      {
        '<leader>[',
        function()
          local scope = {}
          if vim.g.rainbow then
            vim.g.rainbow = false
            scope = {
              show_start = false,
              show_end = false,
              highlight = {
                "IndentBlanklineContextChar",
              }
            }
            require('rainbow-delimiters').disable(0)
          else
            vim.g.rainbow = true
            scope = {
              show_start = true,
              show_end = true,
              highlight = {
                "BracketHighlighting0",
                "BracketHighlighting1",
                "BracketHighlighting2",
              }
            }
            require('rainbow-delimiters').enable(0)
          end
          require('ibl').update({ scope = scope })
        end,
        desc = "Toggle rainbow delimiters"
      }
    },
    dependencies = {
      'lukas-reineke/indent-blankline.nvim',
    }
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    event = "BufEnter",
    opts = {
      indent = {
        char = "▏",
        highlight = {
          "IndentBlanklineChar",
        }
      },
      exclude = {
        filetypes = { "dashboard" },
      },
      scope = {
        show_start = false,
        show_end = false,
        injected_languages = true,
        highlight = {
          "IndentBlanklineContextChar"
        },
      }
    },
    config = function(_, opts)
      local hooks = require "ibl.hooks"
      require("ibl").setup(opts)
      hooks.register(hooks.type.SCOPE_HIGHLIGHT, function(tick, bufnr, scope, scope_index)
        if vim.g.rainbow then
          return hooks.builtin.scope_highlight_from_extmark(tick, bufnr, scope, scope_index)
        else
          return 0
        end
      end)
    end
  },
  -- AI
  { 'github/copilot.vim',         event = "VeryLazy" },

  -- UI plugins
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
    }
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
  { 'tzachar/highlight-undo.nvim', opts = {},          event = "BufEnter" },
  --[[ {
    'echasnovski/mini.indentscope',
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      draw = { delay = 0, animation = function() return 0 end },
      options = { border = "top", try_as_border = true },
      symbol = "▏",
    },
    config = function(_, opts)
      vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { link = "NonText" });
      require("mini.indentscope").setup(opts)
    end
  }, ]]
  {
    "folke/noice.nvim",
    lazy = false,
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
        enabled = true,
      },
      -- you can enable a preset for easier configuration
      presets = {
        -- bottom_search = true,         -- use a classic bottom cmdline for search
        -- command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true,        -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { '<leader>l', '<cmd>NoiceDismiss<cr>', desc = 'Clear notifications' }
    }
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      top_down = false,
    }
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
  -- Themes
  {
    'Mofiqul/vscode.nvim',
    config = function()
      local c = require('vscode.colors').get_colors()
      require('vscode').setup({
        transparent = true,
        italic_comments = true,
        disable_nvimtree_bg = true,
        group_overrides = {
          DapBreakpoint = { ctermbg = 0, fg = '#bf321d' },
          DapStopped = { ctermbg = 0, fg = '#ffcc00' },
          DapStoppedLine = { ctermbg = 0, bg = '#4b4b26' },
          DiagnosticUnnecessary = { link = 'NonText' },
          DiffviewDiffDeleteDim = { link = 'NonText' },
          NotifyBackground = { ctermbg = 0, bg = '#000000' },
          BracketHighlighting0 = { fg = '#ffd700' },
          BracketHighlighting1 = { fg = '#da70d6' },
          BracketHighlighting2 = { fg = '#179fff' },
        },
      })
      require('vscode').load()
    end,
    priority = 1000
  },
  {
    'folke/tokyonight.nvim',
    priority = 1000
  },
  {
    'olimorris/onedarkpro.nvim',
    opts = {
      options = {
        -- transparency = true,
        -- highlight_inactive_windows = true
      },
    },
    priority = 1000
  },
  -- Lines
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = true,
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename', 'lsp_progress' },
        lualine_x = { 'overseer', },
        lualine_y = { 'encoding', 'fileformat', 'filetype' },
        lualine_z = { 'progress', 'location' }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      extensions = {}
    },
    event = 'VimEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'arkav/lualine-lsp-progress' },
  },
  {
    'akinsho/bufferline.nvim',
    event = 'BufRead',
    opts = {
      options = {
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local s = ''
          local level_str = {
            error = ' ', -- warning = ' ', info = ' ', hint = ' ',
          }
          for e, n in pairs(diagnostics_dict) do
            if n > 0 and level_str[e] ~= nil then
              s = s .. n .. level_str[e]
            end
          end
          return s
        end,
        offsets = { { filetype = 'NvimTree', text = 'File Explorer', text_align = 'left' } },
        show_buffer_close_icons = false,
        show_close_icon = false,
        separator_style = 'none',
      }
    },
    keys = {
      { '<tab>',   '<cmd>BufferLineCycleNext<cr>', desc = "Next buffer" },
      { '<s-tab>', '<cmd>BufferLineCyclePrev<cr>', desc = "Previous buffer" },
      { '[b',      '<cmd>BufferLineMovePrev<cr>',  desc = "Move buffer left" },
      { ']b',      '<cmd>BufferLineMoveNext<cr>',  desc = "Move buffer right" },
    }
  },
  -- Dashboard
  {
    'glepnir/dashboard-nvim',
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
          {
            icon = '  ',
            desc = 'Open Personal dotfiles                  ',
            key = 'd',
            action = 'cd ' .. os.getenv('HOME') .. '/.config/nvim/ | SessionManager load_current_dir_session'
          },
        },
      },
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  -- LSP UI
  {
    'glepnir/lspsaga.nvim',
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
      { 'K',          "<cmd>Lspsaga hover_doc<cr>",                       desc = 'Show symbol information' },
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
    event = 'BufRead',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  --[[ {
    'ray-x/lsp_signature.nvim',
    opts = {
      hint_enable = false,
      toggle_key = '<M-x>' -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
    }
  }, ]]
  -- DAP UI
  {
    'rcarriga/nvim-dap-ui',
    keys = {
      { '<F4>', function() require('dapui').toggle() end },
    },
    opts = {}
  },
  -- Navigation plugins
  { 'ggandor/lightspeed.nvim',     keys = { 's', 'S' } },
  {
    'ibhagwan/fzf-lua',
    cmd = { 'FzfLua' },
    keys = {
      { '<leader>o',   function() require('fzf-lua').files() end,                 desc = 'Open file' },
      { '<leader>h',   function() require('fzf-lua').live_grep() end,             desc = 'Search in all files (project)' },
      { '<leader>p',   function() require('fzf-lua').keymaps() end,               desc = 'Browse keymaps' },
      { '<leader>ed',  function() require('fzf-lua').dap_commands() end,          desc = 'Search debug commands' },
      { '<leader>eb',  function() require('fzf-lua').builtin() end,               desc = 'Select fzf search' },
      { '<leader>ec',  function() require('fzf-lua').commands() end,              desc = 'Search commands' },
      { '<leader>es',  function() require('fzf-lua').lsp_workspace_symbols() end, desc = 'Search workspace symbols' },
      { '<leader>et',  function() require('fzf-lua').buffers() end,               desc = 'Search buffers' },
      { '<leader>er',  function() require('fzf-lua').resume() end,                desc = 'Resume last search' },
      { '<leader>ehc', function() require('fzf-lua').command_history() end,       desc = 'Search command history' },
      { '<leader>ehs', function() require('fzf-lua').search_history() end,        desc = 'Search search history' },
      { '<leader>egh', function() require('fzf-lua').git_stash() end,             desc = 'Search git status' },
      { '<leader>egs', function() require('fzf-lua').git_status() end,            desc = 'Search git status' },
      { '<leader>egc', function() require('fzf-lua').git_commits() end,           desc = 'Search git commits' },
      { '<leader>egb', function() require('fzf-lua').git_branches() end,          desc = 'Search git branches' },
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  {
    'nvim-tree/nvim-tree.lua',
    cmd = { 'NvimTreeOpen', 'NvimTreeToggle' },
    keys = {
      { '<leader>t', '<cmd>NvimTreeToggle<cr>', desc = "Toggle file explorer" }
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = get_config('tree'),
  },
  {
    'stevearc/oil.nvim',
    keys = {
      { '-', '<cmd>Oil<cr>', desc = "Open parent directory" }
    },
    opts = {},
    cmd = { 'Oil' },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    'folke/trouble.nvim',
    cmd = { 'Trouble', 'TroubleToggle' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },
  { 'simrat39/symbols-outline.nvim', cmd = { 'SymbolsOutline' }, opts = {} },

  -- Augmentations
  { 'kevinhwang91/nvim-bqf',         ft = 'qf' },
  { 'numToStr/Comment.nvim',         event = "BufEnter",         opts = {} },
  { 'folke/todo-comments.nvim',      event = "BufEnter",         dependencies = { 'nvim-lua/plenary.nvim' }, opts = {} },
  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = true
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
  -- { 'smjonas/inc-rename.nvim', cmd = 'IncRename', config = true },
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
  -- Git
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'VeryLazy',
    opts = {}
  },
  {
    'tpope/vim-fugitive',
    event = 'VeryLazy',
    opts = {},
    config = function()
    end
  },
  {
    'sindrets/diffview.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    opts = {
      enhanced_diff_hl = true,
    },
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory' },
    keys = {
      { '<leader>dd', '<cmd>DiffviewOpen<cr>',    desc = 'Open diff view' },
      { '<leader>dc', '<cmd>DiffviewClose<cr>',   desc = 'Close diff view' },
      { '<leader>dh', '<cmd>DiffviewFileHistory', desc = 'Git file history' },
    }
  },
  -- Compilation
  { -- This plugin
    "Zeioth/compiler.nvim",
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    dependencies = { "stevearc/overseer.nvim" },
    opts = {},
  },
  { -- The task runner we use
    "stevearc/overseer.nvim",
    event = 'VeryLazy',
    keys = {
      { '<leader>`', '<cmd>OverseerToggle<cr>', desc = 'Toggle tasks view' },
      { '<leader>r', '<cmd>OverseerRun<cr>',    desc = 'Run task' },
    },
    opts = {},
  },
})
