local npairs = require('nvim-autopairs')
npairs.setup({
  disable_filetype = { "TelescopePrompt" },
  check_ts = true,
  ts_config = {
  },
  map_bs = false,
  map_cr = false,
})

local opts = { noremap = true, silent = true }

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
end, opts)

vim.keymap.set('i', '<bs>', function()
  if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
    return npairs.esc('<c-e>') .. npairs.autopairs_bs()
  else
    return npairs.autopairs_bs()
  end
end, opts)
