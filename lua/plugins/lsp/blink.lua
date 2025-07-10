---@diagnostic disable: missing-fields
return {
	{
		-- want this functionality
		-- dependencies = {
		-- 		"Snikimonkd/cmp-go-pkgs",
		-- 		"hrsh7th/cmp-cmdline",
		-- }
		"saghen/blink.cmp",
		dependencies = "rafamadriz/friendly-snippets",
		version = "v0.*",
		opts = {
			completion = {
				menu = {
					border = "rounded",
				},
				documentation = {
					auto_show = true,
					window = {
						border = "rounded",
					},
				},
			},
			appearance = {
				nerd_font_variant = "mono",
				use_nvim_cmp_as_default = true,
			},
			sources = {
				per_filetype = {
					codecompanion = { "codecompanion" },
				},
				default = { "lsp", "path", "buffer", "lazydev", "snippets" },
				providers = {
					lsp = { fallbacks = { "lazydev" } },
					lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
				},
			},
			keymap = {
				preset = "default",
				-- ["<CR>"] = { "accept", "fallback" },
				["<Tab>"] = { "accept", "fallback" },
				["<C-j>"] = { "select_next" },
				["<C-k>"] = { "select_prev" },
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			},
			-- experimental signature help support
			signature = {
				enabled = true,
				window = {
					border = "rounded",
				},
			},
		},
		opts_extend = { "sources.default" },
	},
}
