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
				lualine_c = {
					"%=",
					{ moons },
				},
			},
		},
	},
}
