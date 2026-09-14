local wezterm = require("wezterm")

return {
	font = wezterm.font_with_fallback({
		"JetBrainsMono Nerd Font Propo",
	}),
	font_size = 15,

	enable_tab_bar = false,
	window_background_opacity = 0.9,

	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},

	enable_wayland = true,

	harfbuzz_features = {
		"calt",
		"liga",
		"clig",
	},

	window_padding = {
		top = 10,
		bottom = 10,
		left = 10,
		right = 10,
	},

	color_scheme_dirs = {
		wezterm.home_dir .. "/.config/noctalia/colors",
	},

	color_scheme = "Noctalia",
}
