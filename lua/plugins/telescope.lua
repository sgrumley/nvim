return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-telescope/telescope-dap.nvim" },
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		cmd = "Telescope",
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
			{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
			{ "<leader>fl", "<cmd>Telescope live_grep<cr>", desc = "Grep Search" },
			{ "<leader>fp", "<cmd>Telescope jumplist<cr>", desc = "Find Places" },
			{ "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
			{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Search Diagnostics" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
			{ "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
			{ "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
			{ "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
			{ "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
			{ "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
			{ "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
			{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
			{ "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
			{ "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
			{ "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
			{ "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
			{ "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
			{ "<leader>fP", "<cmd>Telescope projects<CR>", desc = "[F]ind [P]rojects" },
			{ "<leader>fDs", "<cmd>Telescope dap_configurations<CR>", desc = "[F]ind [D]ap [S]ettings" },
			{ "<leader>fDc", "<cmd>Telescope dap_commands<CR>", desc = "[F]ind [D]ap [C]ommands" },
			{ "<leader>fDb", "<cmd>Telescope dap_list_breakpoints<CR>", desc = "[F]ind [D]ap [B]reakpoints" },
		},
		config = function()
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = {
						"vendor",
					},
					mappings = {
						i = {
							-- scroll docs is  <C-u> and <C-d>
							["<C-j>"] = function(...)
								require("telescope.actions").move_selection_next(...)
							end,
							["<C-k>"] = function(...)
								require("telescope.actions").move_selection_previous(...)
							end,
							["<C-n>"] = function(...)
								require("telescope.actions").cycle_history_next(...)
							end,
							["<C-p>"] = function(...)
								require("telescope.actions").cycle_history_prev(...)
							end,
						},
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension("dap"))
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")
		end,
	},
}
