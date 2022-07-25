local db = require('dashboard')
local home = os.getenv('HOME')

db.custom_center = {
  { icon = '  ',
    desc = 'Open current directory\'s session       ',
    action = 'SessionManager load_current_dir_session' },
  { icon = '  ',
    desc = 'Open lastest session                    ',
    action = 'SessionManager load_last_session' },
  { icon = '  ',
    desc = 'Recently opened sessions                ',
    action = 'SessionManager load_session' },
  { icon = '  ',
    desc = 'Open Personal dotfiles                  ',
    action = 'cd ' .. home .. '/.config/nvim/' },
}
