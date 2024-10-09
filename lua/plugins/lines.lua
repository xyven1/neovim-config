local function color(name, bg)
  local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
  local col = nil
  if hl then
    if bg then
      col = hl.bg
    else
      col = hl.fg
    end
  end
  return col and string.format('#%06x', col) or nil
end

local function fg(name)
  local col = color(name)
  return col and { fg = col } or nil
end

local function macro_recording()
  local mode = require('noice').api.status.mode.get()
  return mode and string.match(mode, '(recording @.*)') or ''
end

return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'arkav/lualine-lsp-progress' },
    opts = function()
      -- vim.opt.showmode = false
      return {
        options = {
          theme = 'auto',
          globalstatus = true,
        },
        sections = {
          lualine_a = { 'mode', },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 'lsp_progress' },
          lualine_x = {
            'overseer',
            {
              function() return require('noice').api.status.command.get() end,
              cond = function() return package.loaded['noice'] and require('noice').api.status.command.has() end,
              color = fg('Statement'),
            },
            {
              macro_recording,
              cond = function() return package.loaded['noice'] and require('noice').api.status.mode.has() end,
              color = fg('Constant'),
            },
            {
              function() return '  ' .. require('dap').status() end,
              cond = function() return package.loaded['dap'] and require('dap').status() ~= '' end,
              color = fg('Debug'),
            },
          },
          lualine_y = { 'encoding', 'fileformat', },
          lualine_z = { 'progress', 'location' }
        },
      }
    end,
  },
  {
    'akinsho/bufferline.nvim',
    event = 'LazyFile',
    opts = {
      options = {
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, level, _, _)
          local icon = level:match('error') and '󰅚 ' or
              level:match('warning') and ' '
          return icon and icon .. count or ''
        end,
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'File Explorer',
            highlight = 'Directory',
            text_align = 'center'
          }
        },
        show_buffer_close_icons = false,
        show_close_icon = false,
        separator_style = 'none',
      }
    },
    config = function(_, opts)
      require('bufferline').setup(opts)
      vim.api.nvim_create_autocmd({ 'BufAdd', 'BufDelete' }, {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
    keys = {
      { '<tab>',   '<cmd>BufferLineCycleNext<cr>', desc = 'Next buffer' },
      { '<s-tab>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Previous buffer' },
      { '[b',      '<cmd>BufferLineMovePrev<cr>',  desc = 'Move buffer left' },
      { ']b',      '<cmd>BufferLineMoveNext<cr>',  desc = 'Move buffer right' },
    }
  },
  {
    'luukvbaal/statuscol.nvim',
    event = 'LazyFile',
    config = function()
      local builtin = require('statuscol.builtin')
      vim.opt.foldcolumn = '1'
      vim.opt.fillchars = {
        foldopen = '',
        foldsep = ' ',
        foldclose = '',
      }

      require('statuscol').setup({
        relculright = true,
        ft_ignore = { 'neo-tree' },
        segments = {
          {
            text = { builtin.foldfunc, ' ' },
            condition = { true, builtin.not_empty }
          },
          {
            sign = { namespace = { 'diagnostic/signs' }, auto = true, foldclosed = true },
            click = 'v:lua.ScSa'
          },
          {
            sign = { name = { '.*' }, maxwidth = 1, auto = true, wrap = true },
            click = 'v:lua.ScSa'
          },
          { text = { builtin.lnumfunc }, click = 'v:lua.ScLa', },
          {
            sign = {
              namespace = { 'gitsigns' },
              maxwidth = 1,
              colwidth = 1,
              auto = false,
              wrap = true,
            },
            click = 'v:lua.ScSa'
          },
        }
      })
    end,
  }
}
