local npairs = require('nvim-autopairs')
npairs.setup({
  disable_filetype = { "TelescopePrompt" },
  check_ts = true,
  ts_config = {
  },
  map_bs = false,
  map_cr = false,
})

local expr_opts = { noremap = true, expr = true, silent = true }

vim.keymap.set('i', '<cr>', function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
      return npairs.esc('<c-y>')
    else
      return npairs.esc('<c-e>') .. npairs.autopairs_cr()
    end
  else
    return npairs.autopairs_cr()
  end
end, expr_opts)

vim.keymap.set('i', '<bs>', function()
  if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
    return npairs.esc('<c-e>') .. '<bs>'
  else
    return '<bs>'
  end
end, expr_opts)
