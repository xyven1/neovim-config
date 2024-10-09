return {
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {
      check_ts = true,
      map_cr = false,
    },
    keys = {
      {
        '<cr>',
        function()
          local npairs = require('nvim-autopairs')
          return vim.api.nvim_feedkeys(npairs.autopairs_cr(), "n", false) or ""
        end,
        desc = 'Map autopairs CR',
        mode = { 'i' },
        expr = true
      },
      {
        '<C-l>',
        function()
          local closers = { ")", "]", "}", ">", "'", "\"", "`", "," }
          local line = vim.api.nvim_get_current_line()
          local row, col = unpack(vim.api.nvim_win_get_cursor(0))
          local after = line:sub(col + 1, -1)
          local closer_col = #after + 1
          local closer_i = nil
          for i, closer in ipairs(closers) do
            local cur_index, _ = after:find(closer)
            if cur_index and (cur_index < closer_col) then
              closer_col = cur_index
              closer_i = i
            end
          end
          if closer_i then
            vim.api.nvim_win_set_cursor(0, { row, col + closer_col })
          else
            vim.api.nvim_win_set_cursor(0, { row, col + 1 })
          end
        end,
        desc = 'Escape pair',
        mode = { 'i' }
      },
    }
  },
  {
    'kylechui/nvim-surround',
    event = 'LazyFile',
    opts = {}
  },
  {
    'windwp/nvim-ts-autotag',
    event = 'LazyFile',
    opts = {}
  }
}
