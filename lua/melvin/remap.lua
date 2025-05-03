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

-- Resize Window Height
vim.keymap.set('n', '<leader>+', ':resize +2<CR>')
vim.keymap.set('n', '<leader>-', ':resize -2<CR>')

-- Resize Window Width
vim.keymap.set('n', '<leader>>', ':vertical resize +5<CR>')
vim.keymap.set('n', '<leader><', ':vertical resize -5<CR>')

-- Run files
vim.keymap.set('n', '<leader>rr', function()
    local filepath = vim.fn.expand("%:p")
    local filedir = vim.fn.fnamemodify(filepath, ":h")

    -- Create a new floating terminal buffer
    local buf = vim.api.nvim_create_buf(false, true)

    -- Set the size of the floating window (80% width and 60% height of the screen)
    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.6)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    -- Open the floating window
    vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
    })

    -- Run the Python file in the terminal inside the floating window
    local cmd = string.format("cd %s && python %s", vim.fn.shellescape(filedir), vim.fn.shellescape(filepath))
    vim.fn.termopen(cmd)

    -- Automatically enter insert mode
    vim.cmd("startinsert")
end, { desc = "Run Python file in floating terminal" })

-- Function to find the root directory by looking for markers (e.g., .git, setup.py)
function find_root_dir(start_dir)
    local dir = start_dir
    while dir ~= "/" do
        if vim.fn.isdirectory(dir .. "/.git") == 1 or
            vim.fn.filereadable(dir .. "/setup.py") == 1 or
            vim.fn.filereadable(dir .. "/pyproject.toml") == 1 then
            return dir
        end
        dir = vim.fn.fnamemodify(dir, ":h") -- Move to the parent directory
    end
    return nil                              -- Return nil if no root is found
end

vim.keymap.set('n', '<leader>rt', function()
    local filepath = vim.fn.expand("%:p")

    -- Find the root directory of the project
    local root_dir = find_root_dir(vim.fn.fnamemodify(filepath, ":h"))
    if not root_dir then
        print("Root directory not found.")
        return
    end

    -- Create a new floating terminal buffer
    local buf = vim.api.nvim_create_buf(false, true)

    -- Set the size of the floating window (80% width and 60% height of the screen)
    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.6)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    -- Open the floating window
    vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
    })

    -- Run the unit tests using python unittest in the terminal inside the floating window
    local cmd = string.format("cd %s && python -m unittest %s", vim.fn.shellescape(root_dir),
        vim.fn.shellescape(filepath))
    vim.fn.termopen(cmd)

    -- Automatically enter insert mode
    vim.cmd("startinsert")
end, { desc = "Run unit tests with unittest in floating terminal" })


vim.keymap.set('n', '<leader>rm', function()
    local filepath = vim.fn.expand("%:p")
    local filedir = vim.fn.fnamemodify(filepath, ":h")

    -- Create a terminal buffer
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')

    -- Window dimensions (80% width, 60% height)
    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.6)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    -- Create floating window
    local win = vim.api.nvim_open_win(buf, true, {
        relative = 'editor',
        width = width,
        height = height,
        row = row,
        col = col,
        style = 'minimal',
        border = 'rounded',
    })

    -- Set keybind to close window with 'q' or '<Esc>'
    vim.keymap.set('t', '<Esc>', '<C-\\><C-n>:q<CR>', { buffer = buf })
    vim.keymap.set('t', 'q', '<C-\\><C-n>:q<CR>', { buffer = buf })

    -- Run glow command
    local cmd = string.format("cd %s && glow -p %s", vim.fn.shellescape(filedir), vim.fn.shellescape(filepath))
    vim.fn.termopen(cmd)

    -- Enter terminal mode
    vim.cmd("startinsert")
end, { desc = "Render markdown file in floating terminal with glow" })

vim.keymap.set('n', '<leader>id', function()
    local now = vim.fn.system("zsh -ic \"now\" 2>/dev/null"):gsub("%s+$", "")
    vim.api.nvim_put({ now }, "c", true, true)
end, { desc = 'Insert current date' })
