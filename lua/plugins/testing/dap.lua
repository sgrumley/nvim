local debug_utils = require("pkg.debug_utils")

return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"leoluz/nvim-dap-go",
			"nvim-neotest/nvim-nio",
			{
				"theHamsta/nvim-dap-virtual-text",
				opts = {},
			},
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
			local dap_ui_ok, ui = pcall(require, "dapui")
			if not dap_ui_ok then
				require("notify")("dap-ui not installed", "warning")
			end

			require("dap-go").setup({})
			ui.setup()

			dap.listeners.before.attach.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function(session)
				vim.notify("Debug session terminated", vim.log.levels.INFO)
				ui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function(_, exit_code)
				vim.notify("Debug session exited with code: " .. tostring(exit_code), vim.log.levels.INFO)
				ui.close()
			end

			-- debug with vscode format launch.json file
			-- NOTE: this requires strict json and cannot have trailing commas or comments
			local debug_with_launch = function()
				if vim.fn.filereadable(".vscode/launch.json") then
					-- Path to the `launch.json` file. Defaults to
					-- `.vscode/launch.json` in the current working directory.
					require("dap.ext.vscode").load_launchjs()
				end
				require("dap").continue()
			end

			local uitoggle = function()
				require("dapui").toggle({})
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
			vim.keymap.set("n", "<leader>du", uitoggle, { desc = " ui toggle" })
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
