return {
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'LazyFile',
    main = 'ibl',
    ---@module 'ibl'
    ---@type ibl.config
    opts = {
      indent = {
        char = '▏',
      },
      exclude = {
        filetypes = { 'dashboard' },
      },
      scope = {
        show_start = false,
        show_end = false,
        injected_languages = true,
      }
    },
  },
  {
    'NMAC427/guess-indent.nvim',
    event = 'LazyFile',
    opts = {}
  }
}
