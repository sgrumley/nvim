configs = {
	opts = {
		history = true,
		delete_check_events = "TextChanged",
	},
	keys = {
		{
			"<C-j>",
			function()
				return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<C-j>"
			end,
			expr = true,
			remap = true,
			silent = true,
			mode = "i",
		},
		{
			"<C-j>",
			function()
				require("luasnip").jump(1)
			end,
			mode = "s",
		},
		{
			"<C-k>",
			function()
				require("luasnip").jump(-1)
			end,
			mode = { "i", "s" },
		},
	},

	dependencies = {
		{
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
	},
}

return configs
