vim.keymap.set('n', '<leader>gd', function()
    vim.cmd('tabedit %')
    vim.cmd('Gvdiffsplit')
end, { desc = "Open git diff in a new tab" })

vim.keymap.set('n', '<leader>ga', function()
    vim.cmd('Git add %')
end, { desc = "Git add file to staging area" })

vim.keymap.set('n', '<leader>gc', function()
    vim.cmd('Git commit --verbose')
end, { desc = "Git commit" })
