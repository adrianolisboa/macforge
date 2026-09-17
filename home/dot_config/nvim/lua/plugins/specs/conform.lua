require("conform").setup({
  formatters_by_ft = {
    elixir = { "mix" },
    -- stylua is installed and configured in .stylua.toml, but deliberately not
    -- wired up here: it collapses this config's aligned trailing comments.
  },
  format_on_save = {
    -- mix format boots the BEAM, which is slow in an umbrella the size of Tiger.
    timeout_ms = 3000,
    lsp_format = "fallback",
  },
})
