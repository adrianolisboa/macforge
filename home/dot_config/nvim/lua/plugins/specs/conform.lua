require("conform").setup({
  formatters_by_ft = {
    elixir = { "mix" },
    lua = { "stylua" }, -- settings live in .stylua.toml (2 spaces, not the default tabs)
  },
  format_on_save = {
    -- mix format boots the BEAM, which is slow in an umbrella the size of Tiger.
    timeout_ms = 3000,
    lsp_format = "fallback",
  },
})
