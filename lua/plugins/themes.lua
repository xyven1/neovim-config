return {
  {
    'Mofiqul/vscode.nvim',
    opts = {
      italic_comments = true,
      group_overrides = {
        LspSignatureActiveParameter = { ctermbg = 0, bg = 'NONE', fg = '#179fff' },
        DapBreakpoint = { ctermbg = 0, fg = '#bf321d' },
        DapStopped = { ctermbg = 0, fg = '#ffcc00' },
        DapStoppedLine = { ctermbg = 0, bg = '#4b4b26' },
        BracketHighlighting0 = { fg = '#ffd700' },
        BracketHighlighting1 = { fg = '#da70d6' },
        BracketHighlighting2 = { fg = '#179fff' },
      },
    },
  },
  {
    'folke/tokyonight.nvim',
    opts = {},
  },
  {
    'olimorris/onedarkpro.nvim',
    opts = {},
  },
  {
    'xyven1/onedark.nvim',
    opts = {},
  },
  {
    'rebelot/kanagawa.nvim',
    opts = {},
  },
  {
    'sainnhe/gruvbox-material',
    opts = {},
    init = function()
      vim.g.gruvbox_material_background = 'medium'
      vim.g.gruvbox_material_foreground = 'original'
      vim.g.gruvbox_material_enable_italic = 1
    end,
  },
}
