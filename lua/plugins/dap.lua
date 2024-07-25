return {
	{
		-- alternative simple install
		"mfussenegger/nvim-dap",
		dependencies = {
			"leoluz/nvim-dap-go",
			{
				"rcarriga/nvim-dap-ui",
				opts = {},
				keys = {
					{
						"<leader>du",
						function()
							require("dapui").toggle({})
						end,
						desc = "Dap UI",
					},
				},
			},
			"nvim-neotest/nvim-nio",
			{
				"theHamsta/nvim-dap-virtual-text",
				opts = {},
			},
		},
		config = function()
			local dap_ok, dap = pcall(require, "dap")
			local dap_ui_ok, ui = pcall(require, "dapui")
			if not (dap_ok and dap_ui_ok) then
				require("notify")("dap-ui not installed", "warning")
			end

			require("dap-go").setup()

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

			vim.keymap.set("n", "<Leader>db", ":DapToggleBreakpoint<CR>")
			vim.keymap.set("n", "<Leader>dc", ":DapContinue<CR>")
			vim.keymap.set("n", "<Leader>dx", ":DapTerminate<CR>")
			vim.keymap.set("n", "<Leader>do", ":DapStepOver<CR>")
			vim.keymap.set("n", "<Leader>di", ":DapStepInto<CR>")
			vim.keymap.set("n", "<Leader>dO", ":DapStepOut<CR>")
			vim.keymap.set("n", "<Leader>dt", ":lua require('dap-go').debug_test()<CR>")
			vim.keymap.set("n", "<Leader>dr", ":lua require('dap-go').debug_last_test()<CR>")
		end,
	},
}

-- vim: ts=2 sts=2 sw=2 et
