--[[
  File: features.lua
  Description: This is for plugins to give base IDE functionality. These should be features of the editor
]]
return {
	{
		-- https://github.com/hedyhli/outline.nvim?tab=readme-ov-file#default-keymaps
		"hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline", "OutlineOpen" },
		keys = {
			{ "<leader>co", "<cmd>Outline<CR>", desc = "Toggle outline tree" },
		},
		opts = {},
	},
	{
		"ThePrimeagen/harpoon",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
		keys = function()
			require("plugins.config.features.harpoon")
		end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = function()
			require("plugins.config.features.flash")
		end,
	},
	{
		"rmagatti/goto-preview",
		config = function()
			require("plugins.config.features.goto")
		end,
	},
	-- TODO: set <leader>m to map each mark, set menu to leader M
	-- https://github.com/chentoast/marks.nvim
	{
		"chentoast/marks.nvim",
		config = function()
			require("marks").setup({
				mappings = {
					toggle = "<leader>kt",
					set = "<leader>ks",
					set_next = "<leader>kn",
					preview = "<leader>kp",
					next = "<leader>k]",
					prev = "<leader>k[",
					delete = "<leader>kd",
					delete_buf = "<leader>kb",
				},
			})
		end,
	},
	-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-surround.md#features
	{ "echasnovski/mini.surround", version = false, opts = {} },
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "nvim-telescope/telescope-ui-select.nvim" },

			-- Useful for getting pretty icons, but requires a Nerd Font.
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
		},
		opts = {
			defaults = {
				file_ignore_patterns = {
					"vendor",
				},
				mappings = {
					i = {
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
		},
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)
			telescope.load_extension("fzf")
		end,
	},
	-- Git
	{
		"sindrets/diffview.nvim",
	},
	{ "tpope/vim-fugitive" },
	{
		-- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		config = function()
			require("plugins.config.features.gitsigns")
		end,
	},
	-- comment
	{
		"numToStr/Comment.nvim",
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
		keys = { { "gc", mode = { "n", "v" } }, { "gcc", mode = { "n", "v" } }, { "gbc", mode = { "n", "v" } } },
		config = function(_, _)
			local opts = {
				ignore = "^$",
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			}
			require("Comment").setup(opts)
		end,
	},

	-- auto pairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		"alexghergh/nvim-tmux-navigation",
		config = function()
			require("nvim-tmux-navigation").setup({})
			vim.keymap.set("n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", {})
			vim.keymap.set("n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", {})
			vim.keymap.set("n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", {})
			vim.keymap.set("n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", {})
		end,
	},
	-- Detect tabstop and shiftwidth automatically
	"tpope/vim-sleuth",
	{ "numToStr/Comment.nvim", opts = {} },
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	-- project one of:
	-- {
	-- 		"ahmedkhalf/project.nvim",
	-- 		config = function()
	-- 			require("project_nvim").setup()
	-- 			require("telescope").load_extension("projects")
	-- 			-- require'telescope'.extensions.projects.projects{}
	-- 		end,
	-- 	},
	-- {
	-- 	"coffebar/neovim-project",

	-- 	opts = {
	-- 		projects = { -- define project roots
	-- 			"~/repo/*",
	-- 			"~/.config/*",
	-- 		},
	-- 	},
	-- 	init = function()
	-- 		-- enable saving the state of plugins in the session
	-- 		vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
	-- 	end,
	-- 	dependencies = {
	-- 		{ "nvim-lua/plenary.nvim" },
	-- 		{ "nvim-telescope/telescope.nvim", tag = "0.1.4" },
	-- 		{ "Shatur/neovim-session-manager" },
	-- 	},
	-- 	lazy = false,
	-- 	priority = 100,
	-- },
	-- {
	-- "ahmedkhalf/project.nvim",
	-- }
}
