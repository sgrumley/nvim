return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "saghen/blink.cmp" },
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			{
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						-- Load luvit types when the `vim.uv` word is found
						{ path = "luvit-meta/library", words = { "vim%.uv" } },
					},
				},
			},
			{ "Bilal2453/luvit-meta", lazy = true },
		},
		config = function()
			-- NOTE: servers listed here require minimum configuration.
			-- anything that require more customisaton will be added via
			-- lua/plugins/lang
			local servers = {
				gopls = {},
				templ = {},
				lua_ls = {},
				dockerls = {},
				docker_compose_language_service = {
					filetypes = { "yaml.docker-compose", "compose.yaml" },
				},
				marksman = {},
				-- buf_language_server = {}, // TODO:
				buf = {},
				sqlls = {},
				prettier = {},
				yamlls = {},
				terraformls = {},
				jsonls = {
					settings = {
						json = {
							format = {
								enable = false,
							},
							validate = { enable = true },
						},
					},
				},
			}

			vim.filetype.add({
				extension = {
					templ = "templ",
				},
			})

			local ensure_installed = vim.tbl_keys(servers or {})
			require("mason").setup()
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = require("blink.cmp").get_lsp_capabilities()
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
}
