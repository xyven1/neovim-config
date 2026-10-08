local confirm = function(message, callback)
  return function()
    if vim.fn.confirm(message, '&Yes\n&Cancel', 1) == 1 then
      callback()
    end
  end
end

---@param cmd string[]
---@return string? stdout trimmed, nil on failure or empty output
local function system(cmd)
  local res = vim.system(cmd, { text = true }):wait()
  local out = vim.trim(res.stdout or '')
  return res.code == 0 and out ~= '' and out or nil
end

--- Base branch of the current PR (falling back to the repo default branch), per the gh cli.
--- Prefers the remote-tracking ref since the local branch is often stale.
---@return string?
local function gh_base_branch()
  local branch = system({ 'gh', 'pr', 'view', '--json', 'baseRefName', '-q', '.baseRefName' })
      or system({ 'gh', 'repo', 'view', '--json', 'defaultBranchRef', '-q', '.defaultBranchRef.name' })
  if not branch then return nil end
  local remote = 'origin/' .. branch
  return system({ 'git', 'rev-parse', '--verify', '--quiet', remote }) and remote or branch
end

--- Change the gitsigns base to a branch, or to the merge-base of HEAD and that branch.
---@param branch string?
---@param merge_base boolean compare against the merge-base rather than the branch tip
local function change_base(branch, merge_base)
  if not branch then return vim.notify('Could not determine base branch', vim.log.levels.ERROR) end
  local base = merge_base and system({ 'git', 'merge-base', 'HEAD', branch }) or branch
  if not base then return vim.notify('No merge-base with ' .. branch, vim.log.levels.ERROR) end
  require('gitsigns').change_base(base, true)
  vim.notify(('Gitsigns base: %s%s'):format(merge_base and 'merge-base with ' or '', branch))
end

--- Open diffview against the merge-base of HEAD and the PR base branch.
local function diff_merge_base()
  local branch = gh_base_branch()
  local base = branch and system({ 'git', 'merge-base', 'HEAD', branch })
  if not base then return vim.notify('Could not determine merge-base', vim.log.levels.ERROR) end
  vim.cmd.DiffviewOpen(base)
end

--- Mark whether a buffer is shown in diffview's inline layout. While `b:diffview_inline` is set
--- ufo's fold providers are disabled (see its `provider_selector`), so that it only renders the
--- layout's own folds. Providers are selected on attach, hence the re-attach.
---@param bufnr integer
---@param inline boolean
local function set_inline(bufnr, inline)
  if not vim.api.nvim_buf_is_valid(bufnr) or (vim.b[bufnr].diffview_inline or false) == inline then return end
  vim.b[bufnr].diffview_inline = inline or nil
  if package.loaded['ufo'] and require('ufo').hasAttached(bufnr) then
    require('ufo').detach(bufnr)
    require('ufo').attach(bufnr)
  end
end

--- Pick the gitsigns base branch with fzf; ctrl-t toggles between merge-base and branch tip.
local function pick_base()
  local merge_base = true
  require('fzf-lua').git_branches({
    prompt = 'Merge-base> ',
    actions = {
      ['enter'] = function(selected)
        if selected[1] then change_base(selected[1]:match('%s-[%+%*]?%s+([^ ]+)'), merge_base) end
      end,
      ['ctrl-t'] = {
        fn = function() merge_base = not merge_base end,
        exec_silent = true,
        -- flip the prompt in step with the flag; plain `&&`/`||` so it runs under fish and sh alike
        postfix = [[transform-prompt(echo "$FZF_PROMPT" | grep -q Merge && echo "Branch tip> " || echo "Merge-base> ")]],
        header = 'toggle merge-base',
      },
      ['ctrl-x'] = false,
      ['ctrl-a'] = false,
    },
  })
end

return {
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'LazyFile',
    cmd = { 'Gitsigns' },
    opts = {
      signs = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '╽' },
        topdelete    = { text = '╿' },
        changedelete = { text = '┣' },
        untracked    = { text = '┆' },
      },
      signs_staged = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '╽' },
        topdelete    = { text = '╿' },
        changedelete = { text = '┣' },
        untracked    = { text = '┆' },
      },
    },
    keys = {
      { '[h',         function() require 'gitsigns'.prev_hunk() end,                 desc = 'Previous hunk' },
      { ']h',         function() require 'gitsigns'.next_hunk() end,                 desc = 'Next hunk' },
      { '<leader>h',  '',                                                            desc = 'Git Hunk' },
      { '<leader>hs', function() require 'gitsigns'.stage_hunk() end,                desc = 'Stage hunk' },
      { '<leader>hi', function() require 'gitsigns'.toggle_current_line_blame() end, desc = 'Toggle current line blame' },
      { '<leader>hr', function() require 'gitsigns'.reset_hunk() end,                desc = 'Reset hunk' },
      { '<leader>hS', function() require 'gitsigns'.stage_buffer() end,              desc = 'Stage buffer' },
      { '<leader>hu', function() require 'gitsigns'.undo_stage_hunk() end,           desc = 'Undo stage hunk' },
      { '<leader>hp', function() require 'gitsigns'.preview_hunk_inline() end,       desc = 'Preview hunk inline' },
      { '<leader>hP', function() require 'gitsigns'.preview_hunk() end,              desc = 'Preview hunk' },
      { '<leader>hb', function() require 'gitsigns'.blame_line({ full = true }) end, desc = 'Blame line' },
      { '<leader>hB', function() require 'gitsigns'.blame() end,                     desc = 'Blame buffer' },
      { '<leader>hd', function() require 'gitsigns'.diffthis() end,                  desc = 'Diff this' },
      { '<leader>hD', function() require 'gitsigns'.diffthis('~') end,               desc = 'Diff this (cached)' },
      { '<leader>hm', function() change_base(gh_base_branch(), true) end,            desc = 'Base: merge-base with PR base (gh)' },
      { '<leader>hM', pick_base,                                                     desc = 'Base: pick branch (fzf)' },
      { '<leader>hc', function() require 'gitsigns'.reset_base(true) end,            desc = 'Base: reset to index' },
      { 'ah',         function() require 'gitsigns'.select_hunk() end,               desc = 'Select hunk',                       mode = { 'o', 'x' } },

      {
        '<leader>hR',
        confirm('Are you sure you want to reset the buffer?', function() require 'gitsigns'.reset_buffer() end),
        desc = 'Reset buffer',
      },
      {
        '<leader>hs',
        function() require 'gitsigns'.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
        desc = 'Stage hunk',
        mode = 'v',
      },
      {
        '<leader>hr',
        function() require 'gitsigns'.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
        desc = 'Reset hunk',
        mode = 'v'
      },
      {
        '<leader>hw',
        function() require 'gitsigns'.toggle_word_diff() end,
        desc = 'Reset hunk',
        mode = 'v',
      },
    }
  },
  {
    'dlyongemallo/diffview-plus.nvim',
    main = 'diffview',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    opts = {
      enhanced_diff_hl = true,
      view = {
        cycle_layouts = {
          default = { "diff2_horizontal", "diff1_inline", "diff2_vertical" },
        },
        inline = {
          fold_unchanged = true,
        },
      },
      hooks = {
        diff_buf_win_enter = function(bufnr, _, ctx)
          set_inline(bufnr, ctx.layout_name == 'diff1_inline')
        end,
        view_closed = function()
          for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do set_inline(bufnr, false) end
        end,
      },
    },
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory' },
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>',          desc = 'Open diff view' },
      { '<leader>gm', diff_merge_base,                  desc = 'Diff to merge-base with PR base (gh)' },
      { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = 'Git file history' },
    }
  },
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'ibhagwan/fzf-lua',
      'nvim-tree/nvim-web-devicons',
    },
    cmd = { 'Octo' },
    keys = {
      { '<leader>go', '<cmd>Octo<cr>', desc = 'Open GitHub UI' }
    },
    opts = {
      picker = 'fzf-lua',
      picker_config = {
        mappings = {
          -- open_in_browser = { lhs = '<C-s-b>', desc = 'open issue in browser' },
        }
      },
      mappings = {
        issue = {
          -- open_in_browser = { lhs = '<C-S-b>', desc = 'open issue in browser' },
        },
        pull_request = {
          -- open_in_browser = { lhs = '<C-S-b>', desc = 'open PR in browser' },
        },
      }
    }
  }
}
