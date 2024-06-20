---@param config {args?:string[]|fun():string[]?}
local function get_args(config)
	local args = type(config.args) == "function" and (config.args() or {}) or config.args or {}
	config = vim.deepcopy(config)
	---@cast args string[]
	config.args = function()
		local new_args = vim.fn.input("Run with args: ", table.concat(args, " ")) --[[@as string]]
		return vim.split(vim.fn.expand(new_args) --[[@as string]], " ")
	end
	return config
end

return {
	"mfussenegger/nvim-dap",

	dependencies = {

		-- fancy UI for the debugger
		{
			"rcarriga/nvim-dap-ui",
      -- stylua: ignore
      keys = {
        { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
        { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
      },
			opts = {},
			config = function(_, opts)
				-- setup dap config by VsCode launch.json file
				-- require("dap.ext.vscode").load_launchjs()
				local dap = require("dap")
				local dapui = require("dapui")
				dapui.setup(opts)
				dap.listeners.after.event_initialized["dapui_config"] = function()
					dapui.open({})
				end
				dap.listeners.before.event_terminated["dapui_config"] = function()
					dapui.close({})
				end
				dap.listeners.before.event_exited["dapui_config"] = function()
					dapui.close({})
				end
			end,
		},

		-- virtual text for the debugger
		{
			"theHamsta/nvim-dap-virtual-text",
			opts = {},
		},

		-- which key integration
		{
			"folke/which-key.nvim",
			optional = true,
			opts = {
				defaults = {
					["<leader>d"] = { name = "+debug" },
				},
			},
		},

		-- mason.nvim integration
		{
			"jay-babu/mason-nvim-dap.nvim",
			dependencies = "mason.nvim",
			cmd = { "DapInstall", "DapUninstall" },
			opts = {
				-- Makes a best effort to setup the various debuggers with
				-- reasonable debug configurations
				automatic_installation = true,

				-- You can provide additional configuration to the handlers,
				-- see mason-nvim-dap README for more information
				handlers = {},

				-- You'll need to check that you have the required things installed
				-- online, please don't ask me how to install them :)
				ensure_installed = {
					-- Update this to ensure that you have the debuggers for the langs you want
				},
			},
		},
	},

  -- stylua: ignore
  keys = {
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
    { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
    { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>dj", function() require("dap").down() end, desc = "Down" },
    { "<leader>dk", function() require("dap").up() end, desc = "Up" },
    { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>ds", function() require("dap").session() end, desc = "Session" },
    { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
  },

	-- config = function()
	-- 	local Config = require("config")
	-- 	vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

	-- 	for name, sign in pairs(Config.icons.dap) do
	-- 		sign = type(sign) == "table" and sign or { sign }
	-- 		vim.fn.sign_define(
	-- 			"Dap" .. name,
	-- 			{ text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
	-- 		)
	-- 	end
	-- end,
    -- NOTE: below this is neotest. This might be a good idea to split into another file or move configs into config dir
{
		"folke/which-key.nvim",
		optional = true,
		opts = {
			defaults = {
				["<leader>t"] = { name = "+test" },
			},
		},
	},
	{
		"nvim-neotest/neotest",
		opts = {
			-- Can be a list of adapters like what neotest expects,
			-- or a list of adapter names,
			-- or a table of adapter names, mapped to adapter configs.
			-- The adapter will then be automatically loaded with the config.
			adapters = {},
			-- Example for loading neotest-go with a custom config
			-- adapters = {
			--   ["neotest-go"] = {
			--     args = { "-tags=integration" },
			--   },
			-- },
			status = { virtual_text = true },
			output = { open_on_run = true },
			quickfix = {
				open = function()
					if require("lazyvim.util").has("trouble.nvim") then
						require("trouble").open({ mode = "quickfix", focus = false })
					else
						vim.cmd("copen")
					end
				end,
			},
		},
		config = function(_, opts)
			local neotest_ns = vim.api.nvim_create_namespace("neotest")
			vim.diagnostic.config({
				virtual_text = {
					format = function(diagnostic)
						-- Replace newline and tab characters with space for more compact diagnostics
						local message =
							diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
						return message
					end,
				},
			}, neotest_ns)

			-- if require("lazyvim.util").has("trouble.nvim") then
				opts.consumers = opts.consumers or {}
				-- Refresh and auto close trouble after running tests
				---@type neotest.Consumer
				opts.consumers.trouble = function(client)
					client.listeners.results = function(adapter_id, results, partial)
						if partial then
							return
						end
						local tree = assert(client:get_position(nil, { adapter = adapter_id }))

						local failed = 0
						for pos_id, result in pairs(results) do
							if result.status == "failed" and tree:get_key(pos_id) then
								failed = failed + 1
							end
						end
						vim.schedule(function()
							local trouble = require("trouble")
							if trouble.is_open() then
								trouble.refresh()
								if failed == 0 then
									trouble.close()
								end
							end
						end)
						return {}
					end
				end
			-- end

			if opts.adapters then
				local adapters = {}
				for name, config in pairs(opts.adapters or {}) do
					if type(name) == "number" then
						if type(config) == "string" then
							config = require(config)
						end
						adapters[#adapters + 1] = config
					elseif config ~= false then
						local adapter = require(name)
						if type(config) == "table" and not vim.tbl_isempty(config) then
							local meta = getmetatable(adapter)
							if adapter.setup then
								adapter.setup(config)
							elseif meta and meta.__call then
								adapter(config)
							else
								error("Adapter " .. name .. " does not support setup")
							end
						end
						adapters[#adapters + 1] = adapter
					end
				end
				opts.adapters = adapters
			end

			require("neotest").setup(opts)
		end,
    -- stylua: ignore
    keys = {
      { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
      { "<leader>tT", function() require("neotest").run.run(vim.loop.cwd()) end, desc = "Run All Test Files" },
      { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest" },
      { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run Last" }, 
      { "<leader>tw", function() require("neotest").watch.toggle() end, desc = "Watch Run" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
      { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop" },
    },
	},
	{
		"mfussenegger/nvim-dap",
		optional = true,
    -- stylua: ignore
    keys = {
      { "<leader>td", function() require("neotest").run.run({strategy = "dap"}) end, desc = "Debug Nearest" },
    },
	},
}