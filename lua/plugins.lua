local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file
function get_config(name)
  return string.format("require(\"config/%s\")", name)
end

-- bootstrap packer if not installed
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    "git", "clone", "https://github.com/wbthomason/packer.nvim",
    install_path
  })
  execute "packadd packer.nvim"
end

-- initialize and configure packer
local packer = require("packer")
packer.init {
  enable = true, -- enable profiling via :PackerCompile profile=true
  threshold = 0 -- the amount in ms that a plugins load time must be over for it to be included in the profile
}
local use = packer.use
packer.reset()

-- plugins list
use "wbthomason/packer.nvim"

use "lewis6991/impatient.nvim"

use "nathom/filetype.nvim"

use "dstein64/vim-startuptime"

use "neovim/nvim-lspconfig"

use {
  "williamboman/nvim-lsp-installer",
  config = get_config("lsp")
}

use {
  "ggandor/lightspeed.nvim",
  opt = false
}

use "github/copilot.vim"

use 'Mofiqul/vscode.nvim'

use {
  "nvim-lualine/lualine.nvim",
  config = get_config("lualine"),
  event = "VimEnter",
  requires = { "kyazdani42/nvim-web-devicons", opt = true }
}

use 'arkav/lualine-lsp-progress'

use {
  "lewis6991/gitsigns.nvim",
  requires = { "nvim-lua/plenary.nvim" },
  event = "BufReadPre",
  config = get_config("gitsigns")
}

use {
  'ibhagwan/fzf-lua',
  requires = { 'kyazdani42/nvim-web-devicons' }
}

use {'kevinhwang91/nvim-bqf', ft = 'qf'}

use {
  "nvim-treesitter/nvim-treesitter",
  config = get_config("treesitter"),
  run = ":TSUpdate"
}

use "nvim-treesitter/nvim-treesitter-textobjects"

use {
  "folke/todo-comments.nvim",
  requires = { "nvim-lua/plenary.nvim" },
  config = get_config("todo")
}

use {
  "ms-jpq/coq_nvim",
  config = get_config("coq")
}

use "ms-jpq/coq.artifacts"

use {
  "ms-jpq/coq.thirdparty",
  config = get_config("coqthirdparty")
}

use {
  "ray-x/lsp_signature.nvim",
  config = get_config("signature")
}

use {
  "mfussenegger/nvim-dap",
  config = get_config("dap")
}

use {
  "rcarriga/nvim-dap-ui",
  config = get_config("dapui")
}

use {
  'kyazdani42/nvim-tree.lua',
  requires = {
    'kyazdani42/nvim-web-devicons',
  },
  opt = true,
  cmd = {"NvimTreeOpen", "NvimTreeToggle"},
  config = get_config("tree")
}

use {
  'sindrets/diffview.nvim',
  requires = 'nvim-lua/plenary.nvim'
}

use {
  "folke/trouble.nvim",
  opt = true,
  cmd = {"Trouble", "TroubleToggle"},
  requires = "kyazdani42/nvim-web-devicons",
  config = get_config("trouble")
}

use {
  'theHamsta/nvim-dap-virtual-text',
  config = get_config("dapvirtualtext")
}

use 'lambdalisue/suda.vim'

use {
  'akinsho/bufferline.nvim',
  config = get_config("bufferline")
}

use {
  'kazhala/close-buffers.nvim',
  config = get_config("closebuf")
}

use {
  'numToStr/Comment.nvim',
  config = get_config("comment")
}

use {
  "andweeb/presence.nvim",
  config = get_config("presence")
}

use {
  "folke/which-key.nvim",
  config = get_config("whichkey")
}

use {
  'glepnir/dashboard-nvim',
  config = get_config("dashboard")
}

use {
  'Shatur/neovim-session-manager',
  config = get_config("session")
}

use {
  'smjonas/inc-rename.nvim',
  config = get_config("increname")
}

use {
  'windwp/nvim-autopairs',
  config = get_config("autopairs")
}
