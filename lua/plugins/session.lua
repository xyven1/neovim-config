--- Git state of the current working directory, or nil if it can't be
--- determined (not a repo, or the directory no longer exists).
--- `worktree` is true for a linked worktree: its git-dir differs from
--- the repo's common dir, unlike the main checkout.
local function git_info()
  local cwd = vim.fn.getcwd()
  -- getcwd() is empty if the directory was deleted (e.g. a removed worktree)
  if cwd == '' or not vim.uv.fs_stat(cwd) then
    return nil
  end
  local res = vim.system(
    { 'git', 'rev-parse', '--path-format=absolute', '--git-dir', '--git-common-dir' },
    { cwd = cwd, text = true }
  ):wait()
  if res.code ~= 0 then
    return nil
  end
  local dirs = vim.split(vim.trim(res.stdout), '\n')
  local branch = vim.trim(vim.system({ 'git', 'branch', '--show-current' }, { cwd = cwd, text = true }):wait().stdout or '')
  return {
    branch = branch ~= '' and branch or nil,
    worktree = dirs[1] ~= dirs[2],
  }
end

--- @param git? table pre-fetched `git_info()` result, to avoid re-shelling
--- out when the caller already has one
local function get_session_name(git)
  local files = require('resession.files')
  local name = vim.fn.getcwd()
  git = git or git_info()
  -- A linked worktree's directory already identifies it, so only key on the
  -- branch for the main checkout
  if git and git.branch and not git.worktree then
    name = name .. '~~' .. git.branch
  end
  return (name:gsub(files.sep, '_'):gsub(':', '_'))
end

local DIRSESSION = 'dirsession'
local GIT_EXT = 'gitinfo'

-- Inline resession extension that stores git state alongside each session, so
-- the picker can show the real branch name and whether it was a worktree
package.preload['resession.extensions.' .. GIT_EXT] = function()
  return {
    on_save = function()
      return git_info() or {}
    end,
  }
end

local function session_cwd_missing(session)
  local cwd = session.data and session.data.global and session.data.global.cwd
  return cwd ~= nil and vim.uv.fs_stat(cwd) == nil
end

local function get_all_sessions()
  local resession = require('resession')
  local files = require('resession.files')
  local util = require('resession.util')

  local all_sessions = {}
  local load_from_dir = function(dir)
    local sessions = resession.list({ dir = dir })
    for _, session_name in pairs(sessions) do
      local filename = util.get_session_file(session_name, dir)
      local data = files.load_json_file(filename)
      local stat = vim.uv.fs_stat(filename)
      table.insert(all_sessions, {
        name = session_name,
        dir = dir,
        data = data,
        modified = stat and (stat.mtime.sec + stat.mtime.nsec / 1000000000) or 0,
      })
    end
  end
  load_from_dir(nil)
  load_from_dir(DIRSESSION)

  table.sort(all_sessions, function(a, b)
    return a.modified > b.modified
  end)

  return all_sessions
end

local function action_on_any_session(kind, prompt, func)
  local util = require('resession.util')
  local all_sessions = get_all_sessions()
  if vim.tbl_isempty(all_sessions) then
    vim.notify('No saved sessions', vim.log.levels.WARN)
    return
  end

  local format_item = function(session)
    if not session.data then
      return session.name
    end
    local cwd = util.shorten_path(session.data.global.cwd)
    if session_cwd_missing(session) then
      cwd = cwd .. ' (missing)'
    end
    if session.dir == DIRSESSION then
      local git = session.data[GIT_EXT] or {}
      -- Older sessions have no git data; fall back to the (sanitized) name suffix
      local branch = git.branch or session.name:match('~~(.*)')
      local formatted = cwd
      if branch then
        formatted = string.format('%s  %s', formatted, branch)
      end
      if git.worktree then
        formatted = formatted .. ' (worktree)'
      end
      return formatted
    end
    local formatted = session.name .. (session.dir and string.format(' (%s)', session.dir) or '')
    if session.data.tab_scoped then
      local tab_cwd = session.data.tabs[1].cwd
      return formatted .. string.format(' (tab) [%s]', util.shorten_path(tab_cwd))
    end
    return formatted .. string.format(' [%s]', cwd)
  end

  vim.ui.select(all_sessions, {
    kind = kind,
    prompt = prompt,
    format_item = format_item,
  }, function(selected)
    if selected then
      func(selected)
    end
  end)
end

local function load_any_session()
  local resession = require('resession')
  action_on_any_session('resession_load', 'Load Session> ', function(selected)
    if session_cwd_missing(selected) then
      vim.notify(string.format('Session directory %s no longer exists', selected.data.global.cwd), vim.log.levels.WARN)
      return
    end
    resession.load(selected.name, {
      dir = selected.dir,
      reset = 'auto',
      attach = true,
    })
  end)
end

local function delete_any_session()
  local resession = require('resession')
  action_on_any_session('resession_delete', 'Delete Session> ', function(selected)
    resession.delete(selected.name, { dir = selected.dir })
  end)
end


local function load_latest_session()
  local resession = require('resession')
  local latest_session = vim.iter(get_all_sessions()):find(function(session)
    return not session_cwd_missing(session)
  end)
  if not latest_session then
    vim.notify('No saved sessions', vim.log.levels.WARN)
    return
  end

  resession.load(latest_session.name, {
    dir = latest_session.dir,
    reset = 'auto',
    attach = true,
  })
end

local function save_curr_sess()
  local resession = require('resession')
  local info = resession.get_current_session_info()
  local session_name = get_session_name()
  if info ~= nil then
    resession.save(info.name, { dir = info.dir, notify = false })
  elseif not vim.list_contains(resession.list({ dir = DIRSESSION }), session_name) then
    resession.save(session_name, { dir = DIRSESSION, notify = false })
  else
    resession.save('scratch', { notify = false })
  end
end

local function close_everything()
  local is_floating_win = vim.api.nvim_win_get_config(0).relative ~= ''
  if is_floating_win then
    -- Go to the first window, which will not be floating
    vim.cmd.wincmd({ args = { 'w' }, count = 1 })
  end

  local scratch = vim.api.nvim_create_buf(false, true)
  vim.bo[scratch].bufhidden = 'wipe'
  vim.api.nvim_win_set_buf(0, scratch)
  vim.bo[scratch].buftype = ''
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[bufnr].buflisted then
      vim.api.nvim_buf_delete(bufnr, { force = true })
    end
  end
  vim.cmd.tabonly({ mods = { emsg_silent = true } })
  vim.cmd.only({ mods = { emsg_silent = true } })
end

local function detach()
  require('resession').detach()
end

local function info()
  local sess_info = require('resession').get_current_session_info()
  if sess_info then
    vim.notify(string.format('Session: %s (dir: %s)', sess_info.name, sess_info.dir or 'default'), vim.log.levels.INFO)
  else
    vim.notify('No session loaded', vim.log.levels.INFO)
  end
end

--- @param already_saved? boolean the caller saved before changing branch/cwd,
--- so saving now would file the old layout under the new session name
local function load_current_dir_session(already_saved)
  local resession = require('resession')
  local session_name = get_session_name()
  if vim.list_contains(resession.list({ dir = DIRSESSION }), session_name) then
    resession.load(session_name, { dir = DIRSESSION, reset = 'auto', attach = true })
  else
    if not already_saved then
      save_curr_sess()
    end
    detach()
    close_everything()
  end
end


--- Reconciles the tracked session with the branch actually checked out.
--- Call after anything outside resession's control might have moved it:
--- a branch switch via fzf-lua, or a `lazygit` float closing.
---
--- A dirsession's name encodes its branch, so this is a plain comparison
--- against whichever dirsession is already loaded. No-op if they match.
---
--- Skips reconciling in three cases, since none give a branch to trust:
--- - Nothing is attached.
--- - A manually-named (non-dirsession) session is attached.
--- - HEAD is detached: mid-rebase, mid-cherry-pick, mid-bisect, or a
---   `--detach` checkout. `git branch --show-current` prints nothing here,
---   indistinguishable from "no branch", and would otherwise rebuild the
---   session mid-operation - often the worst possible time.
local function sync_session_to_git()
  local resession = require('resession')
  local info = resession.get_current_session_info()
  if not info or info.dir ~= DIRSESSION then
    return
  end
  local git = git_info()
  if git and not git.branch then
    return
  end
  local session_name = get_session_name(git)
  if info.name == session_name then
    return
  end
  local has_session = vim.list_contains(resession.list({ dir = DIRSESSION }), session_name)
  vim.notify(
    string.format(
      '[session] branch changed, %s session for %s',
      has_session and 'loading' or 'starting a fresh',
      git and git.branch or vim.fn.getcwd()
    ),
    vim.log.levels.INFO
  )
  resession.save(info.name, { dir = info.dir, notify = false })
  load_current_dir_session(true)
end

local functions = {
  load = {
    func = load_any_session,
    desc = 'Load session',
    key = 'w',
  },
  load_dir = {
    func = load_current_dir_session,
    desc = 'Load session in current directory',
    key = 'c',
  },
  load_latest = {
    func = load_latest_session,
    desc = 'Load latest session',
    key = 'l',
  },
  save = {
    func = save_curr_sess,
    desc = 'Save session',
    key = 's',
  },
  delete = {
    func = delete_any_session,
    desc = 'Delete session',
    key = 'd',
  },
  detach = {
    func = detach,
    desc = 'Detach from current session',
    key = 'u',
  },
  info = {
    func = info,
    desc = 'Session info',
    key = 'i',
  }
}

-- The array part is the lazy.nvim plugin spec list. lazy.nvim's
-- Spec:normalize only ipairs() over it, so the named fields below are
-- invisible to lazy.nvim and safe to read via `require('plugins.session')`.
local M = {
  {
    'stevearc/resession.nvim',
    event = { 'VeryLazy', 'VimLeavePre' },
    dependencies = {
      { "tiagovla/scope.nvim", lazy = false, config = true },
    },
    cmd = 'Resession',
    keys = function()
      local keys = {
        { '<leader>w', '', desc = '+session' },
      }
      for _, v in pairs(functions) do
        table.insert(keys, { '<leader>w' .. v.key, v.func, desc = v.desc })
      end
      return keys
    end,
    opts = {
      extensions = { overseer = {}, scope = {}, [GIT_EXT] = {} },
      buf_filter = function(bufnr)
        local buftype = vim.bo[bufnr].buftype
        if buftype == 'help' then
          return true
        end
        if buftype ~= "" and buftype ~= "acwrite" then
          return false
        end
        if vim.api.nvim_buf_get_name(bufnr) == "" then
          return false
        end
        return true
      end,
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd('VimLeavePre', {
        callback = save_curr_sess,
      })
      vim.api.nvim_create_user_command('Resession', function(subcommand)
        if subcommand.args == '' then
          vim.ui.select(vim.tbl_keys(functions), {
            kind = 'resession_command',
            prompt = 'Resession> ',
            format_item = function(item)
              return item .. ' - ' .. functions[item].desc
            end,
          }, function(selected)
            if selected then
              functions[selected].func()
            end
          end)
        elseif functions[subcommand.fargs[1]] then
          functions[subcommand.fargs[1]].func()
        else
          vim.notify('Resession: No such command "' .. subcommand.fargs[1] .. '"', vim.log.levels.ERROR)
        end
      end, {
        nargs = '*',
        bang = true,
        complete = function(args)
          local completions = {}
          for k, _ in pairs(functions) do
            if vim.startswith(k, args) then
              table.insert(completions, k)
            end
          end
          return completions
        end,
        desc = 'Resession command'
      })

      local resession = require('resession')
      resession.setup(opts)
      resession.add_hook('pre_load', save_curr_sess)
    end,
  },
  {
    'ibhagwan/fzf-lua',
    opts = {
      git = {
        branches = {
          actions = {
            ['default'] = function(selected, opts)
              -- git_switch can fail (e.g. uncommitted changes) or redirect
              -- into another worktree; sync_session_to_git() handles both.
              require('fzf-lua.actions').git_switch(selected, opts)
              sync_session_to_git()
            end,
          },
        },
      },
    }
  }
}

M.sync_session_to_git = sync_session_to_git

return M
