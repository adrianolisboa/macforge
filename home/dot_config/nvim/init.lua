-- Enable Lua module loader for faster startup
vim.loader.enable()

-- Load settings and plugins
require("plugins") -- Plugin setup
require("settings.options") -- Options like tab settings, UI tweaks, etc.
require("settings.autocmd") -- Autocommands for specific behaviors
require("settings.markdown") -- Prose options for markdown buffers
require("settings.keymap") -- Key mappings
