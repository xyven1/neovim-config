return {
  {
    'ggandor/leap.nvim',
    dependencies = { 'tpope/vim-repeat' },
    init = function()
      local leap = require('leap')
      leap.create_default_mappings()
      leap.opts.special_keys.prev_target = '<bs>'
      leap.opts.special_keys.prev_group = '<bs>'
      require('leap.user').set_repeat_keys('<cr>', '<bs>')
    end,
  },
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VeryLazy',
    cmd = { 'FzfLua' },
    opts = {
      colorschemes = {
        ignore_patterns = { "^vim$" }
      },
    },
    keys = {
      { 'f', mode = { 'n', 'v' } },
      'F',
      '<leader>o',
      '<leader>O',
      '<leader>p',
      '<leader>"',
      '<leader>e',
      '<leader>l',
    },
    config = function(_, opts)
      local fzf = require('fzf-lua')
      fzf.setup(opts or {})
      fzf.register_ui_select(function(_, items)
        local min_h, max_h = 0.15, 0.70
        local h = (#items + 4) / vim.o.lines
        if h < min_h then
          h = min_h
        elseif h > max_h then
          h = max_h
        end
        return { winopts = { height = h, width = 0.60, row = 0.40 } }
      end)
      local wk = require('which-key')
      wk.register({
        f = { fzf.grep_visual, 'Search current selection' },
      }, {
        mode = 'v',
      })
      wk.register({
        f = { fzf.live_grep_resume, 'Search in all files' },
        F = { fzf.live_grep, 'Search in all files' },
      })
      wk.register({
        o = { fzf.files, 'Open file' },
        O = { fzf.git_files, 'Search git files' },
        p = { fzf.commands, 'Browse commands' },
        ['"'] = { fzf.registers, 'Search registers' },
        e = {
          name = 'FZF',
          b = { fzf.buffers, 'Browse buffers' },
          c = { fzf.colorschemes, 'Search colorschemes' },
          d = {
            name = 'DAP',
            b = { fzf.dap_breakpoints, 'Search breakpoints' },
            c = { fzf.dap_commands, 'Search debug commands' },
            f = { fzf.dap_frames, 'Search frames' },
            s = { fzf.dap_configurations, 'Search configurations' },
            v = { fzf.dap_variables, 'Search variables' },
          },
          e = { fzf.builtin, 'Select fzf search' },
          g = {
            name = 'Git',
            b = { fzf.git_branches, 'Search git branches' },
            c = { fzf.git_commits, 'Search git commits' },
            C = { fzf.git_bcommits, 'Search git commits (buffer)' },
            h = { fzf.git_stash, 'Search git stash' },
            s = { fzf.git_status, 'Search git status' },
            t = { fzf.git_tags, 'Search git tags' },
          },
          h = {
            name = 'History',
            c = { fzf.command_history, 'Search command history' },
            s = { fzf.search_history, 'Search search history' },
          },
          j = { fzf.jumps, 'Search jumps' },
          k = { fzf.keymaps, 'Browse keymaps' },
          l = { fzf.loclist, 'Search loclist' },
          L = { fzf.loclist_stack, 'Search loclist stack' },
          o = { fzf.oldfiles, 'Search old files' },
          q = { fzf.quickfix, 'Search quickfix' },
          Q = { fzf.quickfix_stack, 'Search quickfix stack' },
          r = { fzf.resume, 'Resume last search' },
          s = { fzf.spell_suggest, 'Search spell suggestions' },
          t = { fzf.tags, 'Search tags' },
          T = { fzf.tagstack, 'Search tagstack' },
          w = { fzf.grep_cword, 'Search word under cursor' },
          W = { fzf.grep_cWORD, 'Search WORD under cursor' },
        },
        l = {
          name = 'LSP',
          a = { fzf.lsp_code_actions, 'Search code actions' },
          D = { fzf.lsp_declarations, 'Search declaration' },
          d = { fzf.lsp_definitions, 'Search definitions' },
          e = { fzf.lsp_document_diagnostics, 'Search diagnostics (document)' },
          s = { fzf.lsp_document_symbols, 'Search symbols (document)' },
          f = { fzf.lsp_finder, 'Search sybmol with LSP' },
          i = { fzf.lsp_implementations, 'Search implementations' },
          I = { fzf.lsp_incoming_calls, 'Search incoming calls' },
          O = { fzf.lsp_outgoing_calls, 'Search outgoing calls' },
          r = { fzf.lsp_references, 'Search references' },
          t = { fzf.lsp_typedefs, 'Search type definitions' },
          E = { fzf.lsp_workspace_diagnostics, 'Search diagnostics (workspace)' },
          S = { fzf.lsp_live_workspace_symbols, 'Search symbols (workspace)' },
        },
      }, {
        prefix = '<leader>',
      })
    end
  },
  {
    'nvim-tree/nvim-tree.lua',
    cmd = { 'NvimTreeOpen', 'NvimTreeToggle' },
    keys = {
      { '<leader>t', '<cmd>NvimTreeToggle<cr>', desc = "Toggle file explorer" }
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    opts = {
      disable_netrw = true,
      hijack_cursor = true,
      sync_root_with_cwd = true,
      renderer = {
        indent_markers = {
          enable = true,
        },
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
      },
    }
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
    config = function(_, opts)
      require('trouble').setup(opts or {})
      local config = require("fzf-lua.config")
      local actions = require("trouble.sources.fzf").actions
      config.defaults.actions.files["ctrl-t"] = actions.open
    end,
  },
  { 'simrat39/symbols-outline.nvim', cmd = { 'SymbolsOutline' }, opts = {} },
}
