return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-fzf-native.nvim' },
    config = function()
        local telescope = require('telescope')

        telescope.setup({
            defaults = {
                file_ignore_patterns = {
                    "venv/",
                    "node_modules/",
                    "__pycache__/",
                    "%.git/",
                    "build/",
                    "dist/",
                },
            },
        })

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pff', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope find git files' })
        vim.keymap.set('n', '<leader>pfs', function()
            builtin.live_grep()
        end)
        vim.keymap.set('n', '<leader>pfw', function()
            builtin.grep_string({ search = vim.fn.expand("<cword>") })
        end)
    end,
}
