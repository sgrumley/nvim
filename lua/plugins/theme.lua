return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 2000,
		config = function()
			require("catppuccin").setup({
				integrations = {
					diffview = true,
					treesitter = true,
					blink_cmp = true,
					flash = true,
					gitsigns = true,
					noice = true,
					telescope = true,
					illuminate = {
						enabled = true,
						lsp = false,
					},
					which_key = true,
					-- lualine = true,
				},
			})

			-- TODO: this might need a dep
			require("barbecue").setup({
				theme = "catppuccin-mocha",
			})

			-- set theme
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
}
