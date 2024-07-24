return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "python" })
			end
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "ruff_lsp" })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				ruff_lsp = {
					keys = {
						{
							"<leader>lo",
							function()
								vim.lsp.buf.code_action({
									apply = true,
									context = {
										only = { "source.organizeImports" },
										diagnostics = {},
									},
								})
							end,
							desc = "Organize Imports",
						},
					},
				},
			},
			setup = {
				ruff_lsp = function()
					require("lazyvim.util").lsp.on_attach(function(client, _)
						if client.name == "ruff_lsp" then
							-- Disable hover in favor of Pyright
							client.server_capabilities.hoverProvider = false
						end
					end)
				end,
			},
		},
	},
}
