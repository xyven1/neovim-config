local function get_session_name()
  local files = require("resession.files")
  local name = vim.fn.getcwd()
  local branch = vim.trim(vim.fn.system("git branch --show-current"))
  if vim.v.shell_error == 0 then
    name = name .. "~~" .. branch
  end
  return name:gsub(files.sep, "_"):gsub(":", "_")
end

local DIRSESSION = "dirsession"

local function get_all_sessions()
  local resession = require("resession")
  local files = require("resession.files")
  local util = require("resession.util")

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

local function load_any_session()
  local resession = require("resession")
  local util = require("resession.util")

  local all_sessions = get_all_sessions()

  if vim.tbl_isempty(all_sessions) then
    vim.notify("No saved sessions", vim.log.levels.WARN)
    return
  end

  local format_item = function(session)
    if not session.data then
      return session.name
    end
    local cwd = util.shorten_path(session.data.global.cwd)
    if session.dir == DIRSESSION then
      local branch = session.name:match("~~(.*)")
      return branch and string.format("%s  %s", cwd, branch) or cwd
    end
    local formatted = session.name .. (session.dir and string.format(" (%s)", session.dir) or "")
    if session.data.tab_scoped then
      local tab_cwd = session.data.tabs[1].cwd
      return formatted .. string.format(" (tab) [%s]", util.shorten_path(tab_cwd))
    end
    return formatted .. string.format(" [%s]", cwd)
  end

  vim.ui.select(all_sessions, {
    kind = "resession_load",
    prompt = "Load session> ",
    format_item = format_item,
  }, function(selected)
    if selected then
      resession.load(selected.name, {
        dir = selected.dir,
        reset = "auto",
        attach = true,
      })
    end
  end)
end

local function load_current_dir_session()
  local resession = require("resession")
  local session_name = get_session_name()
  if vim.list_contains(resession.list({ dir = DIRSESSION }), session_name) then
    resession.load(session_name, { dir = DIRSESSION, reset = "auto", attach = true })
  end
end

local function load_latest_session()
  local resession = require("resession")
  local all_sessions = get_all_sessions()

  if vim.tbl_isempty(all_sessions) then
    vim.notify("No saved sessions", vim.log.levels.WARN)
    return
  end

  local latest_session = all_sessions[1]
  resession.load(latest_session.name, {
    dir = latest_session.dir,
    reset = "auto",
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
  end
end

local functions = {
  load = {
    func = load_any_session,
    desc = "Load session",
  },
  load_dir = {
    func = load_current_dir_session,
    desc = "Load session in current directory",
  },
  load_latest = {
    func = load_latest_session,
    desc = "Load latest session",
  },
  save = {
    func = save_curr_sess,
    desc = "Save session",
  },
}

return {
  {
    'stevearc/resession.nvim',
    event = 'VimLeavePre',
    cmd = 'Resession',
    keys = { '<leader>w' },
    opts = {
      extensions = { overseer = {} }
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("VimLeavePre", {
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
        end
        if functions[subcommand.fargs[1]] then
          functions[subcommand.fargs[1]].func()
        else
          vim.notify('Resession: No such command "' .. subcommand.fargs[1] .. '"', vim.log.levels.ERROR)
        end
      end, {
        nargs = '*',
        bang = true,
        complete = function(args, cmd_line)
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
      local wk = require('which-key')
      wk.register({
        w = {
          name = 'Session',
          w = { load_any_session, 'Load session' },
          l = { load_latest_session, 'Load latest session' },
          d = { resession.delete, 'Delete session' },
          s = { resession.save, 'Save session' },
        },
      }, { prefix = '<leader>' })
      resession.setup(opts)
      resession.add_hook("pre_load", save_curr_sess)
    end,
  }
}
