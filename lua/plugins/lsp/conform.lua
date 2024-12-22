return {
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, {
				"gofumpt",
				"goimports-reviser",
				"templ",
				"sql_formatter",
				"prettier",
				"stylua",
				"buf",
				"terraform_fmt",
				"yamlfmt",
			})
		end,
	},
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
			notify_on_error = true,
			-- format_on_save = true,
			format_on_save = function(bufnr)
				local disable_filetypes = {
					dockerfile = true,
					sql = true,
					yaml = true,
					json = true,
					proto = true,
					md = true,
				}
				return {
					timeout_ms = 200,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			formatters_by_ft = {
				go = { "gofumpt", "goimports-reviser" }, -- golines
				templ = { "templ" },
				sql = { "sql_formatter" }, -- sql_formatter seems to be the one used in vscode
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "yamlfmt" },
				markdown = { "prettier" },
				lua = { "stylua" },
				terraform = { "terraform_fmt" },
				proto = { "buf" },
			},
		},
	},
}
