vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move blocks of code
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Concat line under and keep cursor at beginnig of current line
vim.keymap.set("n", "J", "mzJ`z")

-- Make half-page scrolling better
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep searched text in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Copy to system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Remap "Go to last file opened"
vim.keymap.set("n", "<leader><Tab>", "<C-^>")

-- Diagnostics
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)

-- Normal mode: open current file on branch
vim.keymap.set('n', '<leader>gb', function()
  vim.cmd('GBrowse')
end, { desc = 'GBrowse current file on branch' })

-- Visual mode: open selected lines on branch
vim.keymap.set('v', '<leader>gb', function()
  -- Exit visual mode and run GBrowse! with the last visual selection
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "x", false)
  vim.schedule(function()
    vim.cmd("'<,'>GBrowse")
  end)
end, { desc = 'GBrowse selected lines on branch' })
