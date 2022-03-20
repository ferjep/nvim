require'nvim-tree'.setup({
    auto_close = true,
    filters = {
        dotfiles = true,
        custom = {'node_modules'}
    },
    git = {
        enable = false
    },
    actions = {
        open_file = {
            quit_on_open = true
        }
    }
})
