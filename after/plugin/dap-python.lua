local dap = require('dap')
local dap_ui = require('dapui')
local dap_python = require('dap-python')


dap_ui.setup()
dap_python.setup("~/.venvs/debugpy/bin/python")



opts = { noremap = true, silent = true }

-- Toggle breakpoint
vim.keymap.set('n', '<leader>db', function()
    dap.toggle_breakpoint()
end, opts)

-- Continue / Start
vim.keymap.set('n', '<leader>dc', function()
    dap.continue()
end, opts)

-- Step Over
vim.keymap.set('n', '<leader>do', function()
    dap.step_over()
end, opts)

-- Step Into
vim.keymap.set('n', '<leader>di', function()
    dap.step_into()
end, opts)

-- Step Out
vim.keymap.set('n', '<leader>dO', function()
    dap.step_out()
end, opts)

-- Terminate
vim.keymap.set('n', '<leader>dt', function()
    dap.terminate()
end, opts)

-- DapUI Toggle
vim.keymap.set('n', '<leader>du', function()
    dap_ui.toggle()
end, opts)
