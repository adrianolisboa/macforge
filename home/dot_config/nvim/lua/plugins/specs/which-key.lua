-- Returned straight into lazy's spec list from plugins/init.lua, the same way
-- claudecode.lua is. Requiring this file inside a `config` function would only
-- build the table and throw it away.
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    delay = 300,
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = true,
        motions = true,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },
    win = {
      border = "single",
      padding = { 2, 2 },
    },
    layout = {
      width = { min = 20, max = 50 },
      spacing = 3,
      align = "center",
    },
    show_help = true,
    spec = {
      { "<leader>b", group = "Buffer" },
      { "<leader>c", group = "Claude Code / copy path" },
      { "<leader>f", group = "Find (Telescope)" },
      { "<leader>g", group = "Git" },
      { "<leader>h", group = "Git hunk" },
      { "<leader>m", group = "Format" },
      { "<leader>n", group = "NvimTree" },
      { "<leader>r", group = "Rename" },
      { "<leader>t", group = "Tests" },
    },
  },
}
