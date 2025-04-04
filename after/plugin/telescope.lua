local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope find git files' })
vim.keymap.set('n', '<leader>pfs', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

vim.keymap.set('n', '<leader>pfw', function ()
    builtin.grep_string({ search = vim.fn.expand("<cword>") });
end)
