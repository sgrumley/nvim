return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, {
					"yaml",
				})
			end
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "yamllint" })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				yamllint = {},
			},
		},
	},
}
