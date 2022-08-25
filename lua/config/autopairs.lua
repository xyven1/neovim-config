require("nvim-autopairs").setup({
  disable_filetype = { "TelescopePrompt" },
  check_ts = true,
  ts_config = {
  },
})

local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')
local default_opts = { expr = true, noremap = true }

npairs.setup({ map_bs = false, map_cr = false })

vim.g.coq_settings = { keymap = { recommended = false } }

-- these mappings are coq recommended mappings unrelated to nvim-autopairs
remap('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], default_opts)
remap('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], default_opts)
remap('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], default_opts)
remap('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], default_opts)

-- skip it, if you use another global object
_G.MUtils= {}

MUtils.CR = function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
      return npairs.esc('<c-y>')
    else
      return npairs.esc('<c-e>') .. npairs.autopairs_cr()
    end
  else
    return npairs.autopairs_cr()
  end
end
remap('i', '<cr>', 'v:lua.MUtils.CR()', default_opts)

MUtils.BS = function()
  if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
    return npairs.esc('<c-e>') .. npairs.autopairs_bs()
  else
    return npairs.autopairs_bs()
  end
end
remap('i', '<bs>', 'v:lua.MUtils.BS()', default_opts)
