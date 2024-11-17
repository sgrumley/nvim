return {
	"mfussenegger/nvim-lint",
	dependencies = {
		"williamboman/mason.nvim",
		"rshkarin/mason-nvim-lint",
	},
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		local lint = require("lint")
		local mason_nvim_lint = require("mason-nvim-lint")

		-- Setup Mason integration with nvim-lint
		mason_nvim_lint.setup({
			-- Auto-install linters configured in nvim-lint
			ensure_installed = {
				"buf", -- for buf_lint
				"tflint", -- for tflint
				-- "jsonlint", -- for prettier
				"golangci-lint",
				-- "golangci-lint", -- for golangci_lint_ls
			},
		})

		-- Configure linters by filetype
		lint.linters_by_ft = {
			proto = { "buf_lint" },
			terraform = { "tflint" },
			-- json = { "jsonlint" },
			go = { "golangcilint" },
		}

		-- Auto-lint on specific events
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		-- Keymap to trigger linting manually
		vim.keymap.set("n", "<leader>ll", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
