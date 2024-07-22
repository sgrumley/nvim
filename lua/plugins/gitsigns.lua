return {
	{
		-- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		config = function()
			local gitsigns = require("gitsigns")
			gitsigns.setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
				on_attach = function(bufnr)
					-- vim.keymap.set('n', '<leader>gh', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

					-- don't override the built-in and fugitive keymaps
					local gs = package.loaded.gitsigns
					vim.keymap.set({ "n", "v" }, "]c", function()
						if vim.wo.diff then
							return "]c"
						end
						vim.schedule(function()
							gs.next_hunk()
						end)
						return "<Ignore>"
					end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
					vim.keymap.set({ "n", "v" }, "[c", function()
						if vim.wo.diff then
							return "[c"
						end
						vim.schedule(function()
							gs.prev_hunk()
						end)
						return "<Ignore>"
					end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
				end,
				current_line_blame = true,
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "right_align",
					delay = 1000,
					ignore_whitespace = false,
				},
			})

			-- keymaps
			nmap("<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", "[G]it Preview Chunk")
			nmap("<leader>gd", "<cmd>Gitsigns diffthis<CR>", "[G]it [D]iff")
			nmap("<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", "[G]it [S]tage Chunk")
			nmap("<leader>gu", "<cmd>Gitsigns reset_hunk<CR>", "[G]it [U]ndo Chunk")
			nmap("<leader>gb", "<cmd>Telescope git_branches<CR>", "[G]it [B]ranches")
			nmap("<leader>gl", function()
				require("gitsigns").blame_line({ full = true })
			end, "[G]it Blame [L]ine")
		end,
	},
}
