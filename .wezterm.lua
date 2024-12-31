local wezterm = require 'wezterm'

local mux = wezterm.mux
wezterm.on("gui-startup", function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)


local config = wezterm.config_builder()
-- Utiliza una de las fuentes de tu sistema
config.font = wezterm.font('VictorMono Nerd Font')

config.font_size = 14

config.window_background_opacity = 0.9
config.win32_system_backdrop = 'Acrylic'
config.initial_cols = 200
config.initial_rows = 50
config.color_scheme = 'Monokai (terminal.sexy)'
config.default_prog = { 'pwsh.exe' }

return config
