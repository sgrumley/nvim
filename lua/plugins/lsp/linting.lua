return {
	-- "mfussenegger/nvim-lint",
	-- event = {
	-- 	"BufReadPre",
	-- 	"BufNewFile",
	-- },
	-- config = function()
	-- 	local lint = require("lint")

	-- 	lint.linters_by_ft = {
	-- 		-- go = { "golangcilint" },
	-- 		proto = { "buf_lint" },
	-- 		json = { "jsonlint" },
	-- 		markdown = { "markdownlint" },
	-- 		sql = { "sqlfluff" },
	-- 		yaml = { "yamllint" },
	-- 		zsh = { "zsh" },
	-- 		javascript = { "eslint_d" },
	-- 		typescript = { "eslint_d" },
	-- 		javascriptreact = { "eslint_d" },
	-- 		typescriptreact = { "eslint_d" },
	-- 		-- python = { "pylint" },
	-- 	}

	-- 	local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
	-- 	vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	-- 		group = lint_augroup,
	-- 		callback = function()
	-- 			lint.try_lint()
	-- 		end,
	-- 	})

	-- 	vim.keymap.set("n", "<leader>ll", function()
	-- 		lint.try_lint()
	-- 	end, { desc = "Trigger linting for current file" })
	-- end,
}
