-- luasnip
local cmp = require'cmp'
local lspkind = require'lspkind'
local ls = require'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local fmt = require("luasnip.extras.fmt").fmt
local extras = require("luasnip.extras")
local m = extras.m
local l = extras.l
local rep = extras.rep
local postfix = require("luasnip.extras.postfix").postfix

ls.config.set_config{
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
}

vim.keymap.set({ "i", "s" }, "<c-k>", function()
    if ls.expand_or_jumpable() then
	ls.expand_or_jump()
    end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-j>", function()
    if ls.jumpable(-1) then
	ls.jump(-1)
    end
end, { silent = true })

vim.keymap.set({ "i" }, "<c-l>", function()
    if ls.choice_active() then
	ls.change_choice(1)
    end
end)

-- Save the file first and then resource snipconfig with this keymap to view new snippets
vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/snip/snipconfig.lua<CR>")
-- require("luasnip.loaders.from_lua").load({ paths = { "./snippets" } })

ls.add_snippets("all", {
    -- Available in any file type
    s("test", {t("printing static text"),
    }),
    -- Python
    s("imp", { t({"import numpy as np", "import matplotlib.pyplot as plt"})}),
    -- s("plot", { t({"fig, ax = plt.subplots("}), i(1), t({")"})}),
    ls.parser.parse_snippet("prf", "print(f\"{$1 = }\")$0"),
    ls.parser.parse_snippet("sys", "sys.exit(0)"),
    ls.parser.parse_snippet("def", "def $1($2):$0"),
    ls.parser.parse_snippet("fig", "fig, ax = plt.subplots($1constrained_layout=True)\nax.plot($2)\nax.set_xlabel(\"$3\", fontsize=12)\nax.set_ylabel(\"$4\", fontsize=12)\n# ax.legend(loc=\"best\")\nplt.show()"),
    ls.parser.parse_snippet("pub", "fs_ticks = 7.5\nfs_text = 8.6\nfs_labels = 8.6\nwidth = 17.2 / 2.54  # inches\nheight = 0.32 * width  # inches\nfig, axs = plt.subplots(ncols=2, figsize=(width, height), dpi=123.6,\nconstrained_layout=True)"),
    ls.parser.parse_snippet("main", "if __name__ == \"__main__\":"),
    -- HTML
    ls.parser.parse_snippet("img", "<img src=\"$1\" alt=\"$2\" width=\"$3%\">"),
    },
    {
	key = "all",
})
