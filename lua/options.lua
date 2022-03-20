HOME = os.getenv("HOME")

vim.cmd([[
    let mapleader=" "
]])
vim.o.completeopt = 'menu,menuone,noselect'
vim.o.compatible = false
vim.o.relativenumber = true
vim.o.number = true
vim.o.hidden = true
vim.o.errorbells = false
vim.o.tabstop=4
vim.o.softtabstop=4
vim.o.shiftwidth=4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.wrap = false
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.undodir = HOME .. '/.vim/undodir'
vim.o.undofile = true
vim.o.incsearch = true
vim.o.scrolloff = 4
vim.o.signcolumn = 'yes'
vim.o.updatetime = 300
vim.o.mouse = vim.o.mouse .. 'a'
vim.o.showmatch = true
vim.o.clipboard = 'unnamedplus'
vim.o.autoread = true
vim.o.termguicolors = true
vim.o.background = "dark"
