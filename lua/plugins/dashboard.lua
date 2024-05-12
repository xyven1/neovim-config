return {
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    opts = {
      theme = 'doom',
      config = {
        week_header = {
          enable = true,
        },
        center = {
          {
            icon = '  ',
            desc = 'Open current directory\'s session       ',
            key = 's',
            action = 'SessionManager load_current_dir_session'
          },
          {
            icon = '  ',
            desc = 'Open lastest session                    ',
            key = 'l',
            action = 'SessionManager load_last_session'
          },
          {
            icon = '󰈢  ',
            desc = 'Recently opened sessions                ',
            key = 'r',
            action = 'SessionManager load_session'
          },
        },
      },
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
}
