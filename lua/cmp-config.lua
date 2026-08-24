-- nvim-cmp configuration
local cmp = require'cmp'
local lspkind = require'lspkind'
local ls = require'luasnip'
cmp.setup({
    mapping = cmp.mapping.preset.insert({
      ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
      ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
      ['<C-e>'] = cmp.mapping.abort(),
      ['<C-y>'] = cmp.mapping.confirm({ select = true }), 
      }),

    sources = cmp.config.sources({
      { name = 'nvim_lsp', keyword_length = 2, max_item_count = 6 },
      { name = 'path' },
      { name = 'luasnip' },
      { name = 'buffer', keyword_length = 2, max_item_count = 6},
    }),

    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
	require('luasnip').lsp_expand(args.body)
      end,
    },

    formatting = {
	-- How to set up nice formatting for your sources.
	format = lspkind.cmp_format {
	  mode = "text", -- "symbol_text" adds symbol then text to the right
	  with_text = true,
	  menu = {
	    buffer = "[BUF]",
	    nvim_lsp = "[LSP]",
	    path = "[PATH]",
	    luasnip = "[SNIP]",
	  },
	},
      },
})

