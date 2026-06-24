-- hyprland.lua
-- Place at: ~/.config/hypr/hyprland.lua

-- ============================================================
-- ENVIRONMENT VARIABLES
-- ============================================================

hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Simp1e-Adw-Dark")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "mesa")
hl.env("AMD_VULKAN_ICD", "radeonsi")
hl.env("__NV_PRIME_RENDER_OFFLOAD", "0")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("ADW_DISABLE_PORTAL", "1")
hl.env("XDG_MENU_PREFIX", "arch-")

-- ============================================================
-- CONFIG
-- ============================================================

hl.config({
	general = {
		gaps_in = 3,
		gaps_out = 7,
		border_size = 2,
		["col.active_border"] = "rgba(D282AFff)",
		["col.inactive_border"] = "rgba(2d478cff)",
		layout = "dwindle",
		allow_tearing = false,
		resize_on_border = true,
	},

	decoration = {
		rounding = 0,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		blur = {
			enabled = false,
			size = 3,
			passes = 1,
		},
	},

	animations = {
		enabled = true,
	},

	input = {
		kb_layout = "us",
		repeat_delay = 200,
		repeat_rate = 35,
		numlock_by_default = true,
		follow_mouse = 1,
		sensitivity = 0.4,
		touchpad = {
			natural_scroll = true,
		},
	},

	misc = {
		disable_hyprland_logo = true,
		force_default_wallpaper = 0,
	},

	dwindle = {
		preserve_split = true,
	},
})

-- ============================================================
-- BEZIER CURVES & ANIMATIONS
-- ============================================================

hl.curve("easeOutExpo", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 2, bezier = "easeOutExpo", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2, bezier = "easeOutExpo", style = "slide" })
hl.animation({ leaf = "fade", enabled = true, speed = 2, bezier = "easeOutExpo" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.5, bezier = "easeOutExpo", style = "slide" })
-- ============================================================
-- MONITOR
-- ============================================================

hl.monitor({
	output = "eDP-1",
	mode = "1920x1080@60",
})

-- ============================================================
-- AUTOSTART
-- ============================================================

hl.on("hyprland.start", function()
	hl.exec_cmd("kbuildsycoca6")
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
	hl.exec_cmd("noctalia")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme prefer-dark")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3")
end)

-- ============================================================
-- WINDOW RULES
-- ============================================================

hl.window_rule({
	match = { class = "firefox", title = "^Picture-in-Picture$" },
	float = true,
})

-- ============================================================
-- BINDS
-- ============================================================

local mod = "SUPER"

-- Terminal
hl.bind(mod .. " + Return", hl.dsp.exec_cmd("alacritty"))

-- File manager
hl.bind(mod .. " + E", hl.dsp.exec_cmd("dolphin"))

-- App launcher
hl.bind(mod .. " + Space", hl.dsp.exec_cmd("sh -c 'noctalia msg panel-toggle launcher'"))

-- Control center
hl.bind(mod .. " + S", hl.dsp.exec_cmd("sh -c 'noctalia msg panel-toggle control-center'"))

-- Settings
hl.bind(mod .. " + comma", hl.dsp.exec_cmd("sh -c 'noctalia msg settings-toggle'"))

-- Clipboard
hl.bind(mod .. " + V", hl.dsp.exec_cmd("noctalia msg panel-toggle clipboard"))

-- Exit
hl.bind(mod .. " + SHIFT + M", hl.dsp.exit())

-- Lock screen
hl.bind(mod .. " + L", hl.dsp.exec_cmd("sh -c 'noctalia msg session lock'"))

-- Toggle floating
hl.bind(mod .. " + SHIFT + V", hl.dsp.window.float({ action = "toggle" }))

-- Night light
hl.bind(mod .. " + N", hl.dsp.exec_cmd("sh -c 'noctalia msg nightlight-enable'"))

-- Close window
hl.bind(mod .. " + Q", hl.dsp.window.close())

-- Fullscreen
hl.bind("SHIFT + F11", hl.dsp.window.fullscreen())

-- Focus movement (hl.dsp.focus, not hl.dsp.window.focus)
hl.bind(mod .. " + Left", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + Right", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + Up", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + Down", hl.dsp.focus({ direction = "down" }))
hl.bind(mod .. " + J", hl.dsp.layout("togglesplit"))

-- Move window
hl.bind(mod .. " + CTRL + Left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mod .. " + CTRL + Right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mod .. " + CTRL + Up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mod .. " + CTRL + Down", hl.dsp.window.move({ direction = "down" }))

-- Workspaces (focus = switch, window.move = send window)
for i = 1, 9 do
	local key = i % 10
	hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mod .. " + 0", hl.dsp.focus({ workspace = 10 }))
hl.bind(mod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Workspace scroll with mouse wheel
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { mouse = true })
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }), { mouse = true })

-- Workspace movement with 3 finger gesture
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- Mouse window drag/resize
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Screenshots
hl.bind(
	mod .. " + SHIFT + S",
	hl.dsp.exec_cmd("sh -c 'noctalia msg screenshot-region ~/dotfiles/scripts/screenshot.sh output'")
)
hl.bind("Print", hl.dsp.exec_cmd("sh -c 'noctalia msg screenshot-fullscreen pick'"))

-- Volume
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("sh -c 'noctalia msg volume-up'"), { locked = true, repeating = true })
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("sh -c 'noctalia msg volume-down'"),
	{ locked = true, repeating = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("sh -c 'noctalia msg volume-mute'"), { locked = true })

-- Brightness
hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd("sh -c 'noctalia msg brightness-up'"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd("sh -c 'noctalia msg brightness-down'"),
	{ locked = true, repeating = true }
)

-- Touchpad & Numlock
hl.bind("XF86TouchpadOn", hl.dsp.exec_cmd("bash ~/dotfiles/scripts/touchpad.sh on"), { locked = true })
hl.bind("XF86TouchpadOff", hl.dsp.exec_cmd("bash ~/dotfiles/scripts/touchpad.sh off"), { locked = true })
hl.bind("Num_Lock", hl.dsp.exec_cmd("bash ~/dotfiles/scripts/numlock.sh"), { locked = true })

-- Media keys
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- For Noctalia Color templates
require("noctalia")
