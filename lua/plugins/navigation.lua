local function fzf(cmd) return function() require('fzf-lua')[cmd]() end end

---@param client vim.lsp.Client
local function lsp_restart(client)
  local attached_buffers = vim.tbl_keys(client.attached_buffers) ---@type integer[]
  local config = client.config
  client:stop(true)
  vim.defer_fn(function()
    local id = vim.lsp.start(config)
    if id then
      for _, b in ipairs(attached_buffers) do
        vim.lsp.buf_attach_client(b, id)
      end
      vim.notify(string.format("Lsp `%s` has been restarted.", config.name))
    else
      vim.notify(string.format("Error restarting `%s`.", config.name), vim.log.levels.ERROR)
    end
  end, 600)
end

---@param client vim.lsp.Client
local function lsp_stop(client)
  client:stop(true)
  vim.notify('Stopped LSP: ' .. client.name, vim.log.levels.INFO)
end

---@param map table<string, vim.lsp.Client>
---@return fzf-lua.previewer.Builtin
local function lsp_previewer(map)
  local LspPreviewer = require("fzf-lua.previewer.builtin").base:extend()

  function LspPreviewer:new(o, opts, fzf_win)
    LspPreviewer.super.new(self, o, opts, fzf_win)
    setmetatable(self, LspPreviewer)
    return self
  end

  function LspPreviewer:populate_preview_buf(entry_str)
    local lsp_info = vim.split(vim.inspect(map[entry_str]), '\n')
    local tmpbuf = self:get_tmp_buffer()
    vim.api.nvim_buf_set_lines(tmpbuf, 0, -1, false, lsp_info)
    self:set_preview_buf(tmpbuf)
    self.win:update_preview_scrollbar()
  end

  function LspPreviewer:gen_winopts()
    return vim.tbl_extend("force", self.winopts, {
      wrap   = false,
      number = false
    })
  end

  return LspPreviewer
end

---@generic T
---@param map table<string, T>
---@param fn fun(item: T)
---@return fun(selected: string[], opts: table)
local function on_selected(map, fn)
  return function(selected)
    fn(map[selected[1]])
  end
end

return {
  --[[ {
    'ggandor/leap.nvim',
    dependencies = { 'tpope/vim-repeat' },
    init = function()
      local leap = require('leap')
      leap.set_default_mappings()
      require('leap.user').set_repeat_keys('<enter>', '<backspace>')
    end,
  }, ]]
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      highlight = {
        backdrop = false
      },
      modes = {
        char = {
          enabled = false
        }
      }
    },
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "o" },      function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = { 'FzfLua' },
    opts = {
      'borderless_full',
      colorschemes = {
        ignore_patterns = { '^vim$' }
      },
    },
    keys = {
      { 'f',           fzf 'grep_visual',                desc = 'Search current selection',      mode = 'v' },
      { 'f',           fzf 'live_grep_resume',           desc = 'Search in all files' },
      { 'F',           fzf 'live_grep',                  desc = 'Search in all files' },
      { '<leader>"',   fzf 'registers',                  desc = 'Search registers' },
      { '<leader>o',   fzf 'files',                      desc = 'Open file' },
      { '<leader>O',   fzf 'git_files',                  desc = 'Search git files' },
      { '<leader>p',   fzf 'commands',                   desc = 'Browse commands' },
      { '<leader>e',   '',                               desc = '+fzf' },
      { '<leader>eb',  fzf 'buffers',                    desc = 'Browse buffers' },
      { '<leader>ec',  fzf 'colorschemes',               desc = 'Search colorschemes' },
      { '<leader>ed',  '',                               desc = '+dap' },
      { '<leader>edb', fzf 'dap_breakpoints',            desc = 'Search breakpoints' },
      { '<leader>edc', fzf 'dap_commands',               desc = 'Search debug commands' },
      { '<leader>edf', fzf 'dap_frames',                 desc = 'Search frames' },
      { '<leader>eds', fzf 'dap_configurations',         desc = 'Search configurations' },
      { '<leader>edv', fzf 'dap_variables',              desc = 'Search variables' },
      { '<leader>ee',  fzf 'builtin',                    desc = 'Select fzf search' },
      { '<leader>eg',  '',                               desc = '+git' },
      { '<leader>egb', fzf 'git_branches',               desc = 'Search git branches' },
      { '<leader>egc', fzf 'git_commits',                desc = 'Search git commits' },
      { '<leader>egC', fzf 'git_bcommits',               desc = 'Search git commits (buffer)' },
      { '<leader>egh', fzf 'git_stash',                  desc = 'Search git stash' },
      { '<leader>egs', fzf 'git_status',                 desc = 'Search git status' },
      { '<leader>egt', fzf 'git_tags',                   desc = 'Search git tags' },
      { '<leader>eh',  '',                               desc = '+history' },
      { '<leader>ehc', fzf 'command_history',            desc = 'Search command history' },
      { '<leader>ehs', fzf 'search_history',             desc = 'Search search history' },
      { '<leader>ej',  fzf 'jumps',                      desc = 'Search jumps' },
      { '<leader>ek',  fzf 'keymaps',                    desc = 'Browse keymaps' },
      { '<leader>el',  fzf 'loclist',                    desc = 'Search loclist' },
      { '<leader>eL',  fzf 'loclist_stack',              desc = 'Search loclist stack' },
      { '<leader>eo',  fzf 'oldfiles',                   desc = 'Search old files' },
      { '<leader>eq',  fzf 'quickfix',                   desc = 'Search quickfix' },
      { '<leader>eQ',  fzf 'quickfix_stack',             desc = 'Search quickfix stack' },
      { '<leader>er',  fzf 'resume',                     desc = 'Resume last search' },
      { '<leader>es',  fzf 'spell_suggest',              desc = 'Search spell suggestions' },
      { '<leader>et',  fzf 'tags',                       desc = 'Search tags' },
      { '<leader>eT',  fzf 'tagstack',                   desc = 'Search tagstack' },
      { '<leader>ew',  fzf 'grep_cword',                 desc = 'Search word under cursor' },
      { '<leader>eW',  fzf 'grep_cWORD',                 desc = 'Search WORD under cursor' },
      { '<leader>l',   '',                               desc = '+lsp' },
      { '<leader>la',  fzf 'lsp_code_actions',           desc = 'Search code actions' },
      { '<leader>ld',  fzf 'lsp_definitions',            desc = 'Search definitions' },
      { '<leader>lD',  fzf 'lsp_declarations',           desc = 'Search declaration' },
      { '<leader>le',  fzf 'lsp_document_diagnostics',   desc = 'Search diagnostics (document)' },
      { '<leader>lE',  fzf 'lsp_workspace_diagnostics',  desc = 'Search diagnostics (workspace)' },
      { '<leader>lf',  fzf 'lsp_finder',                 desc = 'Search sybmol with LSP' },
      { '<leader>li',  fzf 'lsp_implementations',        desc = 'Search implementations' },
      { '<leader>lI',  fzf 'lsp_incoming_calls',         desc = 'Search incoming calls' },
      { '<leader>lO',  fzf 'lsp_outgoing_calls',         desc = 'Search outgoing calls' },
      { '<leader>lr',  fzf 'lsp_references',             desc = 'Search references' },
      { '<leader>ls',  fzf 'lsp_document_symbols',       desc = 'Search symbols (document)' },
      { '<leader>lS',  fzf 'lsp_live_workspace_symbols', desc = 'Search symbols (workspace)' },
      { '<leader>lt',  fzf 'lsp_typedefs',               desc = 'Search type definitions' },
      {
        '<leader>ll',
        function()
          local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
          ---@type table<string, vim.lsp.Client>
          local map = {}
          for _, client in ipairs(clients) do
            map[string.format('%s(%s) %s', client.name, client.id, client.config.root_dir or '(no root)')] = client
          end

          local fzf_lua = require('fzf-lua')
          fzf_lua.fzf_exec(vim.tbl_keys(map), {
            winopts = { title = 'LSP Clients', },
            previewer = lsp_previewer(map),
            actions = {
              ['default'] = on_selected(map, function(client)
                ---@type table<string, fun(client: vim.lsp.Client)>
                local actions = {
                  ['Stop'] = lsp_stop,
                  ['Restart'] = lsp_restart
                }
                fzf_lua.fzf_exec(vim.tbl_keys(actions), {
                  winopts = {
                    title = 'LSP Actions for "' .. client.name .. '"',
                    width = 50,
                    height = 10,
                    col = .5,
                    row = .5,
                  },
                  actions = {
                    ['default'] = on_selected(actions, function(action) action(client) end)
                  }
                })
              end),
              ['ctrl-x'] = on_selected(map, lsp_stop),
              ['ctrl-r'] = on_selected(map, lsp_restart),
            }
          })
        end,
        desc = 'Manage language servers'
      },
    },
    init = function()
      vim.ui.select = function(...)
        require('fzf-lua')
        vim.ui.select(...)
      end
    end,
    config = function(_, opts)
      local config = require('fzf-lua.config')
      config.defaults.actions.files['ctrl-t'] = require('trouble.sources.fzf').actions.open
      local fzf_lua = require('fzf-lua')
      fzf_lua.setup(opts or {})
      fzf_lua.register_ui_select(function(_, items)
        local min_h, max_h = 0.15, 0.70
        local h = (#items + 4) / vim.o.lines
        if h < min_h then
          h = min_h
        elseif h > max_h then
          h = max_h
        end
        return { winopts = { height = h, width = 0.60, row = 0.40 } }
      end)
    end
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    lazy = false,
    opts = function()
      local function on_move(data)
        Snacks.rename.on_rename_file(data.source, data.destination)
      end
      local events = require('neo-tree.events')
      ---@type neotree.Config
      return {
        sources = { 'filesystem', 'buffers', 'git_status' },
        popup_border_style = 'solid',
        open_files_do_not_replace_types = { 'terminal', 'Trouble', 'trouble', 'qf', 'Outline' },
        filesystem = {
          bind_to_cwd = false,
          follow_current_file = { enabled = true },
          use_libuv_file_watcher = true,
        },
        event_handlers = {
          { event = events.FILE_MOVED,   handler = on_move },
          { event = events.FILE_RENAMED, handler = on_move },
        }
      }
    end,
    keys = {
      { '<leader>t',  '',                            desc = '+neo-tree' },
      { '<leader>tt', '<cmd>Neotree toggle<cr>',     desc = 'Toggle file tree' },
      { '<leader>tg', '<cmd>Neotree git_status<cr>', desc = 'Toggle git status tree' },
      { '<leader>tb', '<cmd>Neotree buffers<cr>',    desc = 'Toggle buffers tree' },
      { '<leader>tf', '<cmd>Neotree<cr>',            desc = 'Focus file tree' },
    },
  },
  {
    'stevearc/oil.nvim',
    keys = {
      { '-', '<cmd>Oil<cr>', desc = 'Open parent directory' }
    },
    opts = {},
    cmd = { 'Oil' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  {
    'folke/trouble.nvim',
    cmd = { 'Trouble', 'TroubleToggle' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },
  {
    'hedyhli/outline.nvim',
    cmd = { 'Outline', 'OutlineOpen' },
    keys = { { 'go', '<cmd>Outline<cr>', desc = 'Toggle outline' }, },
    opts = {
      keymaps = {
        up_and_jump = '<C-p>',
        down_and_jump = '<C-n>',
      }
    },
  },
}
