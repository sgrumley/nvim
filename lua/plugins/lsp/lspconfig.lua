return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
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
			-- NOTE: this doesn't work on mac
			-- {
			-- 	"SmiteshP/nvim-navbuddy",
			-- 	dependencies = {
			-- 		"SmiteshP/nvim-navic",
			-- 		"MunifTanjim/nui.nvim",
			-- 	},
			-- 	opts = { lsp = { auto_attach = true } },
			-- 	keys = {
			-- 		{ "<leader>cn", "<cmd>Navbuddy<CR>", desc = "Toggle popup outline" },
			-- 	},
			-- },
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

			-- LSP servers and clients are able to communicate to each other what features they support.
			--  By default, Neovim doesn't support everything that is in the LSP Specification.
			--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
			--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			-- NOTE: Basic servers are listed here as a minimum experience.
			-- lua/plugins/lang provides customised LSPs, treesitter and language unique packages
			local servers = {
				gopls = {},
				lua_ls = {},
				dockerls = {},
				jsonls = {},
				marksman = {},
				buf = {},
				sqlls = {},
				yamllint = {},
				terraformls = {},
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
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
}
