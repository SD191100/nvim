return {
	{
		"NvChad/nvim-colorizer.lua",
		event = "BufReadPre",
		config = function()
			require("colorizer").setup({
				user_default_options = {
					RGB = true, -- #RGB hex codes
					RRGGBB = true, -- #RRGGBB hex codes
					names = false, -- "red", "blue"
					RRGGBBAA = true, -- #RRGGBBAA
					AARRGGBB = true, -- 0xAARRGGBB
					rgb_fn = true, -- rgb(255,0,0)
					hsl_fn = true, -- hsl(...)
					css = true,
					css_fn = true,
					mode = "background", -- or "foreground"
				},
			})
		end,
	},
}
