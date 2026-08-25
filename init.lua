-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- General settings
vim.o.hlsearch = false
vim.opt.number = true
vim.opt.relativenumber = true 
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true
vim.opt.shiftwidth = 4
vim.opt.colorcolumn = '80'
vim.opt.mouse = 'a'
vim.opt.splitright = true
vim.diagnostic.config({ virtual_text = true })

-- Plugins
vim.pack.add({
    -- Colors
    'https://github.com/joshdick/onedark.vim',
    'https://github.com/ellisonleao/gruvbox.nvim',
    -- Status line
    'https://github.com/nvim-lualine/lualine.nvim',
    -- For installing parsers using TSInstall language
    'https://github.com/nvim-treesitter/nvim-treesitter',
    -- LSP (install each language server manually, install instructions on github)
    'https://github.com/neovim/nvim-lspconfig',
     -- Completion engine 
     'https://github.com/hrsh7th/nvim-cmp',
     -- Snippets 
     'https://github.com/L3MON4D3/LuaSnip',
     'https://github.com/saadparwaiz1/cmp_luasnip',
     -- Displaying
     'https://github.com/onsails/lspkind.nvim',
     -- Completion sources 
     'https://github.com/hrsh7th/cmp-buffer',
     'https://github.com/hrsh7th/cmp-path',
     'https://github.com/hrsh7th/cmp-nvim-lsp',
    -- Oil
    'https://github.com/stevearc/oil.nvim',
    -- Todo
    'https://github.com/folke/todo-comments.nvim',
    -- git
    'https://github.com/tpope/vim-fugitive',
    -- Markdown preview
    'https://github.com/davidgranstrom/nvim-markdown-preview',
    -- Fuzzy finding
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/nvim-telescope/telescope.nvim',
})
vim.cmd.colorscheme('gruvbox')

require('telescope-config')
require('lualine-config')
require('cmp-config')
require('oil-config')
require('snip-config')
require('todo-comments').setup()
require('fugitive')

-- Save and restart
vim.keymap.set("n", "<leader>r", "<cmd>write | restart<cr>", { 
  desc = "Save file and restart Neovim" 
})

-- Treesitter
vim.api.nvim_create_autocmd('FileType', {
  pattern = { '<filetype>' },
  callback = function() vim.treesitter.start() end,
})

-- LSP
vim.lsp.enable({"pyright", "clangd"})

-- Terminal mode settings
vim.keymap.set('t', '<C-[>', '<C-\\><C-n>', { desc = 'Escape terminal mode' })
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader>te', function() vim.cmd('vertical terminal') end, { desc = 'Open terminal in right split' })

vim.keymap.set('n', '<leader>ot', function() 
    -- Find the first available terminal buffer
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[bufnr].buftype == 'terminal' then
	    vim.api.nvim_set_current_buf(bufnr)
	    return
	end
    end
    print("No active terminal found")
end, { desc = 'Open existing terminal buffer' })

vim.keymap.set('n', '<leader>p', function()
    -- Find the first available terminal buffer
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[bufnr].buftype == 'terminal' then
	    -- Save current buffer
	    vim.cmd('write')
	    -- Get name of current buffer
	    local fname = vim.api.nvim_buf_get_name(0)
	    local buf_dir = vim.fs.dirname(fname)
	    local ftype = vim.bo[0].filetype
            local job_id = vim.b[bufnr].terminal_job_id
            if job_id then
		vim.api.nvim_chan_send(job_id, "cd " .. buf_dir .. "\r")
		if ftype == "python" then
		    vim.api.nvim_chan_send(job_id, "python " .. fname .. "\r")
		    return
		elseif ftype == "sh" then
		    vim.api.nvim_chan_send(job_id, "bash " .. fname .. "\r")
		    return
		else
		    print("Non-implemented file type " .. ftype)
		    return
		end
            end
        end
    end
    print("No active terminal found")
end, { desc = "Python run current buffer" })

vim.api.nvim_create_autocmd({'BufEnter', 'TermOpen'}, {
    pattern = 'term://*',
    callback = function()
	vim.cmd.startinsert()
    end,
    })

-- Prevent comments rolling over
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ 'r', 'o' }) 
  end,
})

-- Return to previous place in file
vim.cmd([[
autocmd BufRead * autocmd FileType <buffer> ++once
     \ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif
]])

-- Highlight on yanking
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- General keyboard shortcuts
vim.keymap.set('v', '<C-y>', '"+y', { desc = 'Copy to global clipboard' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<leader>u', function()
  vim.cmd('cd %:h')
  print("cwd changed to " .. vim.fn.getcwd())
end, { desc = '[u]pdate cwd to current file directory' })


-- return require('packer').startup(function(use)
--      -- Packer
--      use 'wbthomason/packer.nvim'
--      -- Colors
--      use 'joshdick/onedark.vim'
--      use 'ellisonleao/gruvbox.nvim'
--      -- Line
--      use 'nvim-lualine/lualine.nvim'
--      -- Treesitter and lsp
--      use {
--     'nvim-treesitter/nvim-treesitter', branch = 'master',
--      }
--      use {
--        'williamboman/mason.nvim',
--        'williamboman/mason-lspconfig.nvim',
--        'neovim/nvim-lspconfig',
--      }
--      -- Commenting
--      use 'numToStr/Comment.nvim'
--      -- Completion engine 
--      use 'hrsh7th/nvim-cmp'
--      -- Completion sources 
--      use 'hrsh7th/cmp-buffer'
--      use 'hrsh7th/cmp-path'
--      use 'hrsh7th/cmp-nvim-lsp'
--      -- Snippets 
--      use 'L3MON4D3/LuaSnip'
--      use 'saadparwaiz1/cmp_luasnip'
--      -- Displaying
--      use 'onsails/lspkind.nvim'
--      -- Fuzzy finding
--      use 'nvim-lua/plenary.nvim'
--      use {
--        'nvim-telescope/telescope.nvim', tag = '0.2.*',
--        requires = { {'nvim-lua/plenary.nvim'} }
--      }
--      use {'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
--      -- Code runner
--      use { 'michaelb/sniprun', run = 'bash ./install.sh'}
--      -- Markdown preview
--      use 'davidgranstrom/nvim-markdown-preview'
--      -- Oil
--      use 'stevearc/oil.nvim'
--      -- Todo
--      use 'folke/todo-comments.nvim'
--      -- git
--      use 'tpope/vim-fugitive'
-- end)
