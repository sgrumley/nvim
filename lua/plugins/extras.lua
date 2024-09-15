return {
	{ "tpope/vim-sleuth" },
	-- new lines for lsp diagnostics
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup()
			-- turn off on startup
			require("lsp_lines").toggle()

			toggle_lines = function()
				require("lsp_lines").toggle()
				local current_virtual_text = vim.diagnostic.config().virtual_text
				vim.diagnostic.config({
					virtual_text = not current_virtual_text, -- toggle virtual_text
				})
			end

			nmap("<leader>cl", toggle_lines, "[C]ode [L]ines [T]oggle")
		end,
	},
	-- {
	-- 	"folke/trouble.nvim",
	-- 	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- 	opts = {},
	-- },
	-- scrol bar on right side, this could be enhanced
	{
		"petertriho/nvim-scrollbar",
		opts = {},
	},
	{
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},
	-- commenting lines
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
	-- auto add closing brackets
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		dependencies = { "hrsh7th/nvim-cmp" },
		config = function()
			require("nvim-autopairs").setup({})
			-- If you want to automatically add `(` after selecting a function or method
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
	-- smooth scrolling
	{
		"karb94/neoscroll.nvim",
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
}

-- currently using treesitter whitespace fill
-- {
-- 	"lukas-reineke/indent-blankline.nvim",
-- 	main = "ibl",
-- 	opts = {},
-- 	config = function()
-- 		-- local highlight = {
-- 		-- 	"Rosewater",
-- 		-- 	"Mauve",
-- 		-- 	"Peach",
-- 		-- 	"Green",
-- 		-- 	"Lavendar",
-- 		-- }

-- 		-- local hooks = require("ibl.hooks")
-- 		-- -- create the highlight groups in the highlight setup hook, so they are reset
-- 		-- -- every time the colorscheme changes
-- 		-- hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
-- 		-- 	vim.api.nvim_set_hl(0, "Rosewater", { fg = "#f5e0dc" })
-- 		-- 	vim.api.nvim_set_hl(0, "Mauve", { fg = "#cba6f7" })
-- 		-- 	vim.api.nvim_set_hl(0, "Peach", { fg = "#fab387" })
-- 		-- 	vim.api.nvim_set_hl(0, "Green", { fg = "#a6e3a1" })
-- 		-- 	vim.api.nvim_set_hl(0, "Lavendar", { fg = "#b4befe" })
-- 		-- end)

-- 		-- require("ibl").setup({
-- 		indent = {
-- 		highlight = highlight,
-- 		char = "┊",
-- 		filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
-- show_trailing_blankline_indent = false,
-- show_current_context = false,
-- 		}
-- 		})
-- 		require("ibl").setup()
-- 	end,
-- },
