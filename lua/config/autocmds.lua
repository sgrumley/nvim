-- windows to close
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"OverseerForm",
		"OverseerList",
		"checkhealth",
		"floggraph",
		"fugitive",
		"git",
		"help",
		"lspinfo",
		"man",
		"neotest-output",
		"neotest-summary",
		"qf",
		"query",
		"spectre_panel",
		"startuptime",
		"toggleterm",
		"tsplayground",
		"vim",
		"neoai-input",
		"neotest",
		"neoai-output",
		"notify",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- TODO: WIP
-- it would be cool to customise folds per language
-- cmd should be on filetype rather than bufreadpost
-- vim.api.nvim_create_autocmd("BufReadPost", {
-- 	callback = function()
-- 		-- attempt to set custom folds per language
-- 		local treesitter_parsers = require("nvim-treesitter.parsers")
-- 		if treesitter_parsers.has_parser("go") then
-- 			local folds_query = [[
--         [
--           (function_declaration)
--         ] @fold
--       ]]
-- 			require("vim.treesitter.query").set("go", "folds", folds_query)
-- 		end
-- 	end,
-- })
