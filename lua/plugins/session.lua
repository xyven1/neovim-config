return {
  {
    'Shatur/neovim-session-manager',
    dependencies = {
      'ibhagwan/fzf-lua', -- for fzf's ui select
    },
    cmd = { 'SessionManager' },
    keys = {
      { '<leader>w', '<cmd>SessionManager load_session<cr>', desc = 'Load session' },
    },
    config = function()
      require 'session_manager'.setup {
        autoload_mode = require('session_manager.config').AutoloadMode.Disabled,
      }
    end
  },
}
