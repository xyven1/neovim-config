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
  return col and string.format("#%06x", col) or nil
end

local function fg(name)
  local col = color(name)
  return col and { fg = col } or nil
end

local function macro_recording()
  local mode = require("noice").api.status.mode.get()
  return mode and string.match(mode, "(recording @.*)") or ""
end

return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'arkav/lualine-lsp-progress' },
    opts = function()
      -- vim.opt.showmode = false
      return {
        options = {
          theme = "auto",
          globalstatus = true,
        },
        sections = {
          lualine_a = { 'mode', },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 'lsp_progress' },
          lualine_x = {
            'overseer',
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = fg("Statement"),
            },
            {
              macro_recording,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = fg("Constant"),
            },
            {
              function() return "  " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = fg("Debug"),
            },
          },
          lualine_y = { 'encoding', 'fileformat', },
          lualine_z = { 'progress', 'location' }
        },
      }
    end,
    event = 'VeryLazy',
  },
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    opts = {
      options = {
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match("error") and " " or
              level:match("warning") and " "
          return icon and icon .. count or ''
          --   local s = ''
          --   local level_str = {
          --     error = ' ', warning = ' ', info = ' ', hint = ' ',
          --   }
          --   for e, n in pairs(diagnostics_dict) do
          --     if n > 0 and level_str[e] ~= nil then
          --       s = s .. level_str[e] .. n
          --     end
          --   end
          --   return s
        end,
        offsets = { { filetype = 'NvimTree', text = 'File Explorer', text_align = 'left' } },
        show_buffer_close_icons = false,
        show_close_icon = false,
        separator_style = 'none',
      }
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd("BufAdd", {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
    keys = {
      { '<tab>',   '<cmd>BufferLineCycleNext<cr>', desc = "Next buffer" },
      { '<s-tab>', '<cmd>BufferLineCyclePrev<cr>', desc = "Previous buffer" },
      { '[b',      '<cmd>BufferLineMovePrev<cr>',  desc = "Move buffer left" },
      { ']b',      '<cmd>BufferLineMoveNext<cr>',  desc = "Move buffer right" },
    }
  },
}
