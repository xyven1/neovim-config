vim.keymap.set('n', '<leader>m', function()
  vim.o.background = vim.o.background == 'dark' and 'light' or 'dark'
end, {
  noremap = true,
  silent = true,
  desc = 'Toggle light/dark mode'
})

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
    priority = 999
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
