return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "proto" })
			end
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				buf = {},
			},
		},
	},
	{
		-- TODO: set formatting options
		"stevearc/conform.nvim",
	},
	{
		-- TODO: set lint options
		"mfussenegger/nvim-lint",
	},
}
