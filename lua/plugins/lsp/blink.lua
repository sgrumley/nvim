---@diagnostic disable: missing-fields
return {
	{
		-- dependencies = {
		-- 		"Snikimonkd/cmp-go-pkgs",
		-- 		"hrsh7th/cmp-cmdline",
		-- }
		"saghen/blink.cmp",
		lazy = false, -- lazy loading handled internally
		-- optional: provides snippets for the snippet source
		dependencies = "rafamadriz/friendly-snippets",
		-- use a release tag to download pre-built binaries
		version = "v0.*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
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
				default = { "lsp", "path", "buffer", "cmdline", "lazydev", "snippets" },
				providers = {
					lsp = { fallback_for = { "lazydev" } },
					lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
				},
			},
			keymap = {
				preset = "default",
				["<CR>"] = { "accept", "fallback" },
				["<C-j>"] = { "select_next" },
				["<C-k>"] = { "select_prev" },
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			},
			-- experimental signature help support
			-- signature = {
			-- 	enabled = true,
			-- 	window = {
			-- 		border = "rounded",
			-- 	},
			-- },
		},
		opts_extend = { "sources.default" },
	},
}
