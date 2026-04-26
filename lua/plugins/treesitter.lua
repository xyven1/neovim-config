local function select(query)
  return function() require('nvim-treesitter-textobjects.select').select_textobject(query) end
end
local function goto_next_start(query)
  return function() require('nvim-treesitter-textobjects.move').goto_next_start(query) end
end
local function goto_next_end(query)
  return function() require('nvim-treesitter-textobjects.move').goto_next_end(query) end
end
local function goto_previous_start(query)
  return function() require('nvim-treesitter-textobjects.move').goto_previous_start(query) end
end
local function goto_previous_end(query)
  return function() require('nvim-treesitter-textobjects.move').goto_previous_end(query) end
end
local function swap_next(query)
  return function() require('nvim-treesitter-textobjects.swap').swap_next(query) end
end
local function swap_previous(query)
  return function() require('nvim-treesitter-textobjects.swap').swap_previous(query) end
end

return {
  {
    'romus204/tree-sitter-manager.nvim',
    event = { 'LazyFile', 'VeryLazy' },
    cmd = { 'TSManager' },
    ---@module 'tree-sitter-manager.config'
    ---@type tree-sitter-manager.Config
    opts = {
      ensure_installed = "all",
      languages = {
        flatbuffers = {
          install_info = {
            url = 'https://github.com/yuanchenxi95/tree-sitter-flatbuffers',
            use_repo_queries = true,
            branch = 'main',
            revision = 'HEAD'
          },
        },
        rust_with_rstml = {
          install_info = {
            url = 'https://github.com/rayliwell/tree-sitter-rstml',
            use_repo_queries = true,
            branch = 'main',
            files = { 'src/parser.c', 'src/scanner.c' },
            location = 'rust_with_rstml',
          },
        }
      }
    },
    init = function()
      vim.filetype.add({ extension = { fbs = 'fbs', } })
      vim.treesitter.language.register('flatbuffers', { 'fbs' })
      vim.treesitter.language.register('rust_with_rstml', { 'rust' })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    init = function()
      vim.g.no_plugin_maps = true
    end,
    opts = {
      select = {
        lookahead = true,
      },
      move = {
        set_jumps = true,
      },
    },
    keys = {
      { mode = { 'x', 'o' },      'af',  select('@function.outer'),               desc = 'Select around function' },
      { mode = { 'x', 'o' },      'if',  select('@function.inner'),               desc = 'Select inside function' },
      { mode = { 'x', 'o' },      'al',  select('@loop.outer'),                   desc = 'Select around loop' },
      { mode = { 'x', 'o' },      'il',  select('@loop.inner'),                   desc = 'Select inside loop' },
      { mode = { 'x', 'o' },      'ib',  select('@block.inner'),                  desc = 'Select inside block' },
      { mode = { 'x', 'o' },      'ab',  select('@block.outer'),                  desc = 'Select around block' },
      { mode = { 'x', 'o' },      'ir',  select('@parameter.inner'),              desc = 'Select inside parameter' },
      { mode = { 'x', 'o' },      'ar',  select('@parameter.outer'),              desc = 'Select around parameter' },
      { mode = { 'x', 'o' },      'ic',  select('@call.inner'),                   desc = 'Select inside call' },
      { mode = { 'x', 'o' },      'ac',  select('@call.outer'),                   desc = 'Select around call' },
      { mode = { 'x', 'o' },      'aC',  select('@class.outer'),                  desc = 'Select around class' },
      { mode = { 'x', 'o' },      'iC',  select('@class.inner'),                  desc = 'Select inside class' },
      { mode = { 'x', 'o' },      'id',  select('@conditional.inner'),            desc = 'Select inside conditional' },
      { mode = { 'x', 'o' },      'ad',  select('@conditional.outer'),            desc = 'Select around conditional' },
      { mode = { 'x', 'o' },      'a/',  select('@comment.outer'),                desc = 'Select around comment' },
      { mode = { 'x', 'o' },      'i/',  select('@comment.inner'),                desc = 'Select inside comment' },
      { mode = { 'n', 'x', 'o' }, ']f',  goto_next_start('@function.outer'),      desc = 'Go to next function start' },
      { mode = { 'n', 'x', 'o' }, ']c',  goto_next_start('@class.outer'),         desc = 'Go to next class start' },
      { mode = { 'n', 'x', 'o' }, ']r',  goto_next_start('@parameter.inner'),     desc = 'Go to next parameter start' },
      { mode = { 'n', 'x', 'o' }, ']F',  goto_next_end('@function.outer'),        desc = 'Go to next function end' },
      { mode = { 'n', 'x', 'o' }, ']C',  goto_next_end('@class.outer'),           desc = 'Go to next class end' },
      { mode = { 'n', 'x', 'o' }, ']R',  goto_next_end('@parameter.inner'),       desc = 'Go to next parameter end' },
      { mode = { 'n', 'x', 'o' }, '[f',  goto_previous_start('@function.outer'),  desc = 'Go to previous function start' },
      { mode = { 'n', 'x', 'o' }, '[c',  goto_previous_start('@class.outer'),     desc = 'Go to previous class start' },
      { mode = { 'n', 'x', 'o' }, '[r',  goto_previous_start('@parameter.inner'), desc = 'Go to previous parameter start' },
      { mode = { 'n', 'x', 'o' }, '[F',  goto_previous_end('@function.outer'),    desc = 'Go to previous function end' },
      { mode = { 'n', 'x', 'o' }, '[C',  goto_previous_end('@class.outer'),       desc = 'Go to previous class end' },
      { mode = { 'n', 'x', 'o' }, '[R',  goto_previous_end('@parameter.inner'),   desc = 'Go to previous parameter end' },
      { mode = { 'n' },           'g>r', swap_next('@parameter.inner'),           desc = 'Swap with next parameter' },
      { mode = { 'n' },           'g>f', swap_next('@function.outer'),            desc = 'Swap with next function' },
      { mode = { 'n' },           'g<r', swap_previous('@parameter.inner'),       desc = 'Swap with previous parameter' },
      { mode = { 'n' },           'g<f', swap_previous('@function.outer'),        desc = 'Swap with previous function' },
    }
  }
}
