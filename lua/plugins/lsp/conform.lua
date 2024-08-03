return {
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>lf",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				local disable_filetypes = {
					dockerfile = true,
					yaml = true,
					json = true,
					proto = true,
					sql = true,
					md = true,
				}
				return {
					timeout_ms = 500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			formatters_by_ft = {
				go = { "gofumpt", "goimports-reviser" }, -- golines
				-- rust = { "rustfmt" },
				sql = { "sql_formatter" }, -- sqlfluff
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" }, -- yamlfix, yamlfmt
				markdown = { "prettier" },
				lua = { "stylua" },
				-- python = { "isort", "black" },
				proto = { "buf" },
			},
		},
	},
	{
		"zapling/mason-conform.nvim",
	},
}
