local wezterm = require("wezterm")

return {
	font = wezterm.font_with_fallback({
		"JetBrainsMono Nerd Font Propo",
		"Symbols Nerd Font",
	}),
	font_size = 15,

	enable_tab_bar = false,

	window_background_opacity = 0.9,

	window_padding = {
		left = 10,
		right = 10,
		top = 10,
		bottom = 10,
	},

	enable_wayland = true,

	harfbuzz_features = {
		"calt",
		"liga",
		"clig",
	},

	color_scheme_dirs = {
		wezterm.home_dir .. "/.config/wezterm/colors",
	},

	color_scheme = "Noctalia",
}
