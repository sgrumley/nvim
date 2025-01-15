-- debug_test_case gets 1. the parent function name and 2. the string under cursor then runs debug -run 1./2.
local function debug_test_case()
	-- Get the current line
	local line = vim.api.nvim_get_current_line()
	local col = vim.api.nvim_win_get_cursor(0)[2]

	-- Find the string under cursor (between quotes)
	local before = line:sub(1, col + 1):reverse()
	local after = line:sub(col + 1)

	local s1 = before:find('"')
	local s2 = after:find('"')

	if not s1 or not s2 then
		vim.notify("No string found under cursor", vim.log.levels.ERROR)
		return
	end

	-- Extract case name without quotes and trim whitespace
	local case_name = line:sub(col + 2 - s1, col + s2 - 1):gsub('"', "")

	-- Get the current buffer's content to find parent test function
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

	-- Get the parent test function name
	local current_func = ""
	for _, l in ipairs(lines) do
		local func_name = l:match("func%s+(Test%w+)")
		if func_name then
			current_func = func_name
			break
		end
	end

	if current_func == "" then
		vim.notify("Could not find parent test function", vim.log.levels.ERROR)
		return
	end

	-- Log the test name and case using Noice
	local full_test_name = string.format("%s/%s", current_func, case_name)
	require("noice").notify("Debugging test: " .. full_test_name, "info", {
		title = "Go Test Debug",
		timeout = 2000,
	})

	-- Get the package directory instead of file
	local dir_path = vim.fn.expand("%:p:h")

	-- Configure the debug session
	local dap = require("dap")
	local config = {
		type = "go",
		name = "Debug Test Case",
		request = "launch",
		mode = "test",
		program = dir_path, -- Use package directory instead of file
		args = { "-test.run", full_test_name },
		dlvToolPath = vim.fn.exepath("dlv"),
	}

	-- Start debugging
	dap.run(config)
end

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
			dap.listeners.before.event_terminated.dapui_config = function()
				ui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
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
			vim.keymap.set("n", "<leader>dec", debug_test_case, { desc = "test case" })
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
