-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file
--
local function get_config(name)
    return string.format("require(\"config/%s\")", name)
end

-- Automatically install and set up packer.nvim on any machine you clone your configuration to
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  Packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

local packer = require("packer")

packer.init {
    enable = true, -- enable profiling via :PackerCompile profile=true
    threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    git = {
        clone_timeout = 1000,
    }
}

local use = packer.use
packer.reset()

use 'wbthomason/packer.nvim' -- Package manager. packer can manage itself

use {
    'williamboman/nvim-lsp-installer',
    requires = {
        'neovim/nvim-lspconfig',
    },
    config = get_config('lsp')
}

use {
    'hrsh7th/nvim-cmp',
    requires = {
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-nvim-lsp',
        'saadparwaiz1/cmp_luasnip', -- snippets
        'L3MON4D3/LuaSnip' -- snippets
    },
    config = get_config('nvim-cmp')
}

use { 'ellisonleao/gruvbox.nvim', config = get_config('gruvbox') }

use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = get_config('nvim-tree')
}

use {'sheerun/vim-polyglot'}

use {
  'nvim-telescope/telescope.nvim',
  requires = { {'nvim-lua/plenary.nvim'} },
}

use { "aserowy/tmux.nvim", config = get_config('tmux') }
use {'b3nj5m1n/kommentary'}

use {'tpope/vim-surround'}

use {
  'lewis6991/gitsigns.nvim',
  requires = {
    'nvim-lua/plenary.nvim'
  },
  config = get_config('gitsigns')
}

-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
if Packer_bootstrap then
    require('packer').sync()
end
