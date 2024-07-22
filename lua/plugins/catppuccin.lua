return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		enabled = true,
		priority = 1000,
		config = function()
			local catppuccin = require("catppuccin")

			catppuccin.setup({
				flavour = "mocha",
				term_color = false,
				integrations = {
					cmp = true,
					gitsigns = true,
					treesitter = true,
					native_lsp = { enabled = true },
					harpoon = true,
					dap = true,
					dap_ui = true,
					noice = true,
					telescope = {
						enabled = true,
					},
					illuminate = {
						enabled = true,
						lsp = false,
					},
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
