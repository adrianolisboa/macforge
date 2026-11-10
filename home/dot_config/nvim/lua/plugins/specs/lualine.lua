-- One statusline for the whole window (laststatus=3), laid out like LazyVim's:
-- mode | branch, git diff | path, diagnostics ... language server, filetype | position
local function lsp_names()
  local names = {}
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    names[#names + 1] = client.name
  end
  return table.concat(names, " ")
end

-- gitsigns already counts the changed lines; reuse it instead of running git again
local function gitsigns_diff()
  local d = vim.b.gitsigns_status_dict
  if d then
    return { added = d.added, modified = d.changed, removed = d.removed }
  end
end

require("lualine").setup({
  options = {
    theme = "solarized_dark",
    globalstatus = true,
    component_separators = "",
    section_separators = "",
    disabled_filetypes = { statusline = { "lazy" } },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      { "branch", icon = "" },
      { "diff", source = gitsigns_diff, symbols = { added = "+", modified = "~", removed = "-" } },
    },
    lualine_c = {
      { "filename", path = 1, symbols = { modified = "●", readonly = "", unnamed = "[sem nome]" } },
      { "diagnostics", symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " } },
    },
    lualine_x = {
      -- Shows "recording @q" while a macro records, since showmode is off
      {
        function()
          return "recording @" .. vim.fn.reg_recording()
        end,
        cond = function()
          return vim.fn.reg_recording() ~= ""
        end,
      },
      { lsp_names, color = { fg = "#586e75" } },
    },
    lualine_y = { { "filetype" } },
    lualine_z = { "location" },
  },
  extensions = { "nvim-tree", "lazy" },
})
