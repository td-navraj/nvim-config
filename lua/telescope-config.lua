-- Telescope
require('telescope').setup{
}

-- require('telescope').load_extension('fzf')

-- Keymaps
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[S]earch current [B]uffers' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>sc', builtin.current_buffer_fuzzy_find, { desc = '[S]earch [C]urrent Buffer' })
vim.keymap.set('n', '<leader>sr', builtin.colorscheme, { desc = '[S]earch [R]ang' })
vim.keymap.set('n', '<leader>sn', "<cmd>Telescope find_files cwd=~/notes/ <CR>", { desc = '[S]earch notes' })
