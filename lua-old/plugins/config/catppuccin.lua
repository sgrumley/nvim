local catppuccin = require("catppuccin")

catppuccin.setup({
	integrations = {
		cmp = true,
		gitsigns = true,
		treesitter = true,
		harpoon = true,
		dap = true,
		dap_ui = true,
		noice = true,
		telescope = {
			enabled = true,
			style = "nvchad",
		},
		illuminate = {
			enabled = true,
			lsp = false,
		},
	},
	-- config = function()
	--   vim.cmd.colorscheme("catppuccin")
	-- end,
})

-- vim.cmd.colorscheme("catppuccin")
