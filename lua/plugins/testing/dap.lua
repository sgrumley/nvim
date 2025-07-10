local debug_utils = require("pkg.debug_utils")

return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{
				"igorlfs/nvim-dap-view",
				opts = {},
			},
			"leoluz/nvim-dap-go",
			"nvim-neotest/nvim-nio",
			{
				"jay-babu/mason-nvim-dap.nvim",
				dependencies = "mason.nvim",
				cmd = { "DapInstall", "DapUninstall" },
				opts = {
					automatic_installation = true,
					handlers = {},
					ensure_installed = {
						"delve",
					},
				},
			},
		},
		config = function()
			local dap_ok, dap = pcall(require, "dap")
			if not dap_ok then
				require("notify")("dap not installed", "warning")
			end

			local dap_view_ok, ui = pcall(require, "dap-view")
			if not dap_view_ok then
				require("notify")("dap-view not installed", "warning")
			end

			require("dap-go").setup({
				tests = {
					verbose = true,
				},
			})
			ui.setup()

			dap.listeners.before.attach["dap-view-config"] = function()
				ui.open()
			end
			dap.listeners.before.launch["dap-view-config"] = function()
				ui.open()
			end
			dap.listeners.before.event_terminated["dap-view-config"] = function()
				ui.close()
			end
			dap.listeners.before.event_exited["dap-view-config"] = function()
				ui.close()
			end

			-- debug with vscode format launch.json file
			-- TODO: This plugin has been updated, migrate https://github.com/leoluz/nvim-dap-go/tree/main?tab=readme-ov-file#vscode-launch-config
			-- NOTE: this requires strict json and cannot have trailing commas or comments
			local debug_with_launch = function()
				if vim.fn.filereadable(".vscode/launch.json") then
					-- Path to the `launch.json` file. Defaults to
					-- `.vscode/launch.json` in the current working directory.
					require("dap.ext.vscode").load_launchjs()
				end
				require("dap").continue()
			end

			-- execution commands
			vim.keymap.set(
				"n",
				"<Leader>det",
				":lua require('dap-go').debug_test()<CR>",
				{ desc = "under cursor (func)" }
			)
			vim.keymap.set("n", "<Leader>der", ":lua require('dap-go').debug_last_test()<CR>", { desc = "last test" })
			vim.keymap.set("n", "<leader>dec", debug_utils.run_go_table_test, { desc = "test case" })
			vim.keymap.set("n", "<Leader>del", debug_with_launch, { desc = "with launch.json" })

			local eval = function()
				require("dapui").eval()
			end

			-- runtime commands
			vim.keymap.set("n", "<leader>du", ":DapViewToggle<CR>", { desc = "ui toggle" })
			vim.keymap.set("n", "<Leader>db", ":DapToggleBreakpoint<CR>")
			vim.keymap.set("n", "<Leader>dc", ":DapContinue<CR>")
			vim.keymap.set("n", "<Leader>dx", ":DapTerminate<CR>")
			vim.keymap.set("n", "<Leader>do", ":DapStepOver<CR>")
			vim.keymap.set("n", "<Leader>di", ":DapStepInto<CR>")
			vim.keymap.set("n", "<Leader>dO", ":DapStepOut<CR>")
			vim.keymap.set("n", "<leader>de", eval, { desc = "evaluate" })
		end,
	},
}

-- possible key maps
--   keys = {
--     { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
--     { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
--     { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
--     { "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
--     { "<leader>dj", function() require("dap").down() end, desc = "Down" },
--     { "<leader>dk", function() require("dap").up() end, desc = "Up" },
--     { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
--     { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
