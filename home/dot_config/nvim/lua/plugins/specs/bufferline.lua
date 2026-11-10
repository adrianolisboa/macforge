-- Thin tabs: the slant styles need the colorscheme to paint the gaps between
-- tabs, and nvim-solarized-lua does not, which left grey blocks. Colors are set
-- here from the Solarized palette for the same reason.
local c = {
  base03 = "#002b36",
  base02 = "#073642",
  base01 = "#586e75",
  base1 = "#93a1a1",
  blue = "#268bd2",
  orange = "#cb4b16",
  red = "#dc322f",
  yellow = "#b58900",
}

require("bufferline").setup({
  options = {
    close_command = "bdelete! %d",
    right_mouse_command = "bdelete! %d",
    left_mouse_command = "buffer %d",
    diagnostics = "nvim_lsp",
    -- Show only the error count on each tab
    diagnostics_indicator = function(count, level)
      return level:match("error") and (" " .. count) or ""
    end,
    indicator = { style = "icon", icon = "▎" },
    modified_icon = "●",
    offsets = {
      { filetype = "NvimTree", text = "Files", text_align = "left", separator = true },
    },
    separator_style = "thin",
    show_buffer_close_icons = false,
    show_close_icon = false,
    always_show_bufferline = false, -- hide the bar when only one file is open
  },
  highlights = {
    fill = { bg = c.base02 },
    background = { fg = c.base01, bg = c.base02 },
    separator = { fg = c.base02, bg = c.base02 },
    separator_visible = { fg = c.base02, bg = c.base02 },
    separator_selected = { fg = c.base02, bg = c.base03 },
    buffer_visible = { fg = c.base01, bg = c.base02 },
    buffer_selected = { fg = c.base1, bg = c.base03, bold = true, italic = false },
    indicator_selected = { fg = c.blue, bg = c.base03 },
    modified = { fg = c.orange, bg = c.base02 },
    modified_visible = { fg = c.orange, bg = c.base02 },
    modified_selected = { fg = c.orange, bg = c.base03 },
    diagnostic = { bg = c.base02 },
    diagnostic_selected = { bg = c.base03 },
    error = { fg = c.base01, bg = c.base02 },
    error_diagnostic = { fg = c.red, bg = c.base02 },
    error_selected = { fg = c.base1, bg = c.base03, bold = true },
    error_diagnostic_selected = { fg = c.red, bg = c.base03 },
    warning = { fg = c.base01, bg = c.base02 },
    warning_selected = { fg = c.base1, bg = c.base03, bold = true },
    offset_separator = { fg = c.base02, bg = c.base03 },
  },
})
