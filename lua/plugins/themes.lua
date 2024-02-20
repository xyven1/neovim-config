return {
  {
    'Mofiqul/vscode.nvim',
    config = function()
      local transparent = vim.env.TERM == 'wezterm'
      local config = {
        transparent = transparent,
        italic_comments = true,
        disable_nvimtrre_bg = transparent,
        group_overrides = {
          WinBar = { ctermbg = 0, bg = 'NONE' },
          WinBarNC = { ctermbg = 0, bg = 'NONE' },
          DapBreakpoint = { ctermbg = 0, fg = '#bf321d' },
          DapStopped = { ctermbg = 0, fg = '#ffcc00' },
          DapStoppedLine = { ctermbg = 0, bg = '#4b4b26' },
          DiagnosticUnnecessary = { link = 'NonText' },
          DiffviewDiffDeleteDim = { link = 'NonText' },
          NotifyBackground = { ctermbg = 0, bg = '#1e1e1e' },
          BracketHighlighting0 = { fg = '#ffd700' },
          BracketHighlighting1 = { fg = '#da70d6' },
          BracketHighlighting2 = { fg = '#179fff' },
          NormalFloat = { ctermbg = 0, bg = 'NONE' },
          StatusLine = { ctermbg = 0, bg = 'NONE' },
          Pmenu = { ctermbg = 0, bg = 'NONE' },
        },
      }
      require('vscode').setup(config)
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
}
