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
			notify_on_error = true,
			format_on_save = false,
			-- format_on_save = function(bufnr)
			-- 	local disable_filetypes = {
			-- 		dockerfile = true,
			-- 		sql = true,
			-- 		yaml = true,
			-- 		json = true,
			-- 		proto = true,
			-- 		md = true,
			-- 	}
			-- 	return {
			-- 		timeout_ms = 200,
			-- 		lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
			-- 	}
			-- end,
			formatters_by_ft = {
				go = { "gofumpt", "goimports-reviser" }, -- golines
				sql = { "sql_formatter" }, -- sqlfluff
				javascript = { "biome" },
				typescript = { "biome" },
				javascriptreact = { "biome" },
				typescriptreact = { "biome" },
				svelte = { "biome" },
				css = { "biome" },
				html = { "biome" },
				json = { "biome" },
				yaml = { "yamlfmt" },
				markdown = { "prettier" },
				lua = { "stylua" },
				terraform = { "terraform_fmt" },
				proto = { "buf" },
			},
		},
	},
	{
		"zapling/mason-conform.nvim",
	},
}
