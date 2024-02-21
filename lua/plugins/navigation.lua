local function tree_on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set('n', '<S-v>', api.node.open.vertical, opts('Open: Vertical Split'))
  vim.keymap.set('n', '<S-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
end

return {
  {
    'ggandor/leap.nvim',
    dependencies = { 'tpope/vim-repeat' },
    init = function()
      require 'leap'.create_default_mappings()
      require('leap').opts.special_keys.prev_target = '<bs>'
      require('leap').opts.special_keys.prev_group = '<bs>'
      require('leap.user').set_repeat_keys('<cr>', '<bs>')
      -- Hide the (real) cursor when leaping, and restore it afterwards.
      vim.api.nvim_create_autocmd('User', {
        pattern = 'LeapEnter',
        callback = function()
          vim.cmd.hi('Cursor', 'blend=100')
          vim.opt.guicursor:append { 'a:Cursor/lCursor' }
        end,
      })
      vim.api.nvim_create_autocmd('User', {
        pattern = 'LeapLeave',
        callback = function()
          vim.cmd.hi('Cursor', 'blend=0')
          vim.opt.guicursor:remove { 'a:Cursor/lCursor' }
        end,
      })
    end,
  },
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
    opts = {
      disable_netrw = true,
      hijack_cursor = true,
      hijack_unnamed_buffer_when_opening = true,
      on_attach = tree_on_attach,
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
  },
  { 'simrat39/symbols-outline.nvim', cmd = { 'SymbolsOutline' }, opts = {} },
}
