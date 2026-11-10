-- Draws markdown in place: headings, bullets, checkboxes, tables, code blocks,
-- quotes and links. Rendering shows in normal mode; insert mode shows the raw
-- text again, so editing never fights the decorations.
return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "echasnovski/mini.icons",
  },
  keys = {
    { "<leader>mr", "<cmd>RenderMarkdown toggle<cr>", desc = "Markdown: toggle render", ft = "markdown" },
  },
  opts = {
    render_modes = { "n", "c", "t" },
    -- Show the raw line under the cursor so moving through the file stays readable.
    anti_conceal = { enabled = true },
    heading = {
      sign = false,
      icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      width = "block",
      left_pad = 1,
      right_pad = 2,
    },
    code = {
      sign = false,
      width = "block",
      left_pad = 2,
      right_pad = 4,
      border = "thin",
    },
    bullet = { icons = { "●", "○", "◆", "◇" } },
    checkbox = {
      unchecked = { icon = "󰄱 " },
      checked = { icon = "󰱒 " },
      custom = {
        todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo" },
      },
    },
    pipe_table = { preset = "round" },
    latex = { enabled = false }, -- needs a latex converter we do not install
  },
}
