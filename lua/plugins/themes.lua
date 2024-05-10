return {
  {
    'Mofiqul/vscode.nvim',
    opts = {
      italic_comments = true,
      group_overrides = {
        -- WinBar = { ctermbg = 0, bg = 'NONE' },
        -- WinBarNC = { ctermbg = 0, bg = 'NONE' },
        DapBreakpoint = { ctermbg = 0, fg = '#bf321d' },
        DapStopped = { ctermbg = 0, fg = '#ffcc00' },
        DapStoppedLine = { ctermbg = 0, bg = '#4b4b26' },
        -- DiagnosticUnnecessary = { link = 'NonText' },
        -- DiffviewDiffDeleteDim = { link = 'NonText' },
        -- NotifyBackground = { ctermbg = 0, bg = '#1e1e1e' },
        BracketHighlighting0 = { fg = '#ffd700' },
        BracketHighlighting1 = { fg = '#da70d6' },
        BracketHighlighting2 = { fg = '#179fff' },
        -- NormalFloat = { ctermbg = 0, bg = 'NONE' },
        -- StatusLine = { ctermbg = 0, bg = 'NONE' },
        -- Pmenu = { ctermbg = 0, bg = 'NONE' },
      },
    },
    priority = 1000
  },
  {
    'folke/tokyonight.nvim',
    opts = {},
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
  {
    'xyven1/onedark.nvim',
    opts = {},
    priority = 1000
  },
  {
    'rebelot/kanagawa.nvim',
    opts = {},
    priority = 1000
  },
  {
    'sainnhe/gruvbox-material',
    opts = {},
    init = function()
      vim.g.gruvbox_material_background = 'medium'
      vim.g.gruvbox_material_foreground = 'original'
      vim.g.gruvbox_material_enable_italic = 1
    end,
    priority = 1000
  },
}
