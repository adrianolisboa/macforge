-- Web formatters only run when the project has its own prettier config, so a
-- repo that does not use prettier (or uses ESLint only) is never reformatted.
local web = { "prettierd", "prettier", stop_after_first = true }
local web_fts = {
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "json",
  "jsonc",
  "css",
  "scss",
  "html",
  "yaml",
}

local formatters_by_ft = {
  elixir = { "mix" },
  lua = { "stylua" }, -- settings live in .stylua.toml (2 spaces, not the default tabs)
}
for _, ft in ipairs(web_fts) do
  formatters_by_ft[ft] = web
end

require("conform").setup({
  formatters_by_ft = formatters_by_ft,
  notify_no_formatters = false, -- most web projects here have no prettier config
  formatters = {
    prettierd = { require_cwd = true },
    prettier = { require_cwd = true },
  },
  format_on_save = function(bufnr)
    -- No LSP fallback for web files: without a prettier config, vtsls would
    -- reformat the file in its own style on every save.
    local is_web = vim.tbl_contains(web_fts, vim.bo[bufnr].filetype)
    -- mix format boots the BEAM, which is slow in an umbrella the size of Tiger.
    return { timeout_ms = 3000, lsp_format = is_web and "never" or "fallback" }
  end,
})
