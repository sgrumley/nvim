return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				"go",
				"gomod",
				"gowork",
				"gosum",
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "goimports", "gofumpt" })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				gopls = {
					keys = {
						-- Workaround for the lack of a DAP strategy in neotest-go: https://github.com/nvim-neotest/neotest-go/issues/12
						{ "<leader>td", "<cmd>lua require('dap-go').debug_test()<CR>", desc = "Debug Nearest (Go)" },
					},
					settings = {
						gopls = {
							gofumpt = true,
							codelenses = {
								gc_details = false,
								generate = true,
								regenerate_cgo = true,
								run_govulncheck = true,
								test = true,
								tidy = true,
								upgrade_dependency = true,
								vendor = true,
							},
							hints = {
								assignVariableTypes = true,
								compositeLiteralFields = true,
								compositeLiteralTypes = true,
								constantValues = true,
								functionTypeParameters = true,
								parameterNames = true,
								rangeVariableTypes = true,
							},
							analyses = {
								fieldalignment = true,
								nilness = true,
								unusedparams = true,
								unusedwrite = true,
								useany = true,
							},
							usePlaceholders = true,
							completeUnimported = true,
							staticcheck = true,
							directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
							semanticTokens = true,
						},
					},
				},
			},
			setup = {
				gopls = function(_, opts)
					-- attempt to set custom folds per language
					vim.treesitter.set_query(
						"go",
						"folds",
						[[
						(function_definition (block) @fold)
						(class_definition (block) @fold)
					]]
					)
					-- workaround for gopls not supporting semanticTokensProvider
					-- https://github.com/golang/go/issues/54531#issuecomment-1464982242
					require("lazyvim.util").lsp.on_attach(function(client, _)
						if client.name == "gopls" then
							if not client.server_capabilities.semanticTokensProvider then
								local semantic = client.config.capabilities.textDocument.semanticTokens
								client.server_capabilities.semanticTokensProvider = {
									full = true,
									legend = {
										tokenTypes = semantic.tokenTypes,
										tokenModifiers = semantic.tokenModifiers,
									},
									range = true,
								}
							end
						end
					end)
					-- end workaround
				end,
			},
		},
	},
	-- {
	-- 	"mfussenegger/nvim-dap",
	-- 	optional = true,
	-- 	dependencies = {
	-- 		{
	-- 			"williamboman/mason.nvim",
	-- 			opts = function(_, opts)
	-- 				opts.ensure_installed = opts.ensure_installed or {}
	-- 				vim.list_extend(opts.ensure_installed, { "delve" })
	-- 			end,
	-- 		},
	-- 		{
	-- 			"leoluz/nvim-dap-go",
	-- 			config = true,
	-- 		},
	-- 	},
	-- },
	-- NOTE: a rough experience for testing, leaving here as a reminder to check if it's better
	-- {
	-- 	"nvim-neotest/neotest",
	-- 	optional = true,
	-- 	dependencies = {
	-- 		"nvim-neotest/neotest-go",
	-- 	},
	-- 	opts = {
	-- 		adapters = {
	-- 			["neotest-go"] = {
	-- 				-- Here we can set options for neotest-go, e.g.
	-- 				experimental = {
	-- 					test_table = true,
	-- 				},
	-- 				args = { "-count=1", "-timeout=15s" }, -- , "| tparse -format=markdown" },
	-- 			},
	-- 		},
	-- 	},
	-- },
}
