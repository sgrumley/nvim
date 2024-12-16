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
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
					end

					-- code nav
					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
					map("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
					map("gt", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

					-- code actions
					map("<leader>cr", vim.lsp.buf.rename, "[C]ode [R]ename")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
					map("<leader>cs", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
					map(
						"<leader>cS",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)

					-- docs
					map("K", vim.lsp.buf.hover, "Hover Documentation")
					map("gK", vim.lsp.buf.signature_help, "Signature Help")

					-- diagnostics
					diaFunc = function(next, severity)
						local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
						severity = severity and vim.diagnostic.severity[severity] or nil
						return function()
							go({ severity = severity })
						end
					end

					map("]d", vim.diagnostic.goto_next, "Next Diagnostic")
					map("[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
					map("]e", diaFunc(true, "ERROR"), "Next Error")
					map("[e", diaFunc(false, "ERROR"), "Prev Error")
					map("]w", diaFunc(true, "WARNING"), "Next Warning")
					map("[w", diaFunc(false, "WARNING"), "Prev Warning")
				end,
			})

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
				-- buf_ls = {},
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

			require("mason").setup()

			-- add any mason supported tools that are not lsp, liniting or formatting
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format lua code
			})
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
			vim.filetype.add({
				extension = {
					templ = "templ",
				},
			})
		end,
	},
}
