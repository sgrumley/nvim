local function moons()
	return [[          ]]
end

return {
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				icons_enabled = true,
				theme = "catppuccin",
				section_separators = { left = "", right = "" },
				component_separators = " ",
			},
			sections = {
				-- this could replace bbq? needs some refinement
				-- 	lualine_a = {
				-- 		"filename",
				-- 		function()
				-- 			return require("nvim-treesitter").statusline({
				-- 				indicator_size = 70,
				-- 				type_patterns = { "class", "function", "method" },
				-- 				seperator = " -> ",
				-- 			})
				-- 		end,
				-- 	},
				lualine_c = {
					"%=",
					{ moons },
					{},
				},
			},
		},
	},
}
