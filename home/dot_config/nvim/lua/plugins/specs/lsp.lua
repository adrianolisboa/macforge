-- LSP configuration (Neovim 0.11+ API: vim.lsp.config / vim.lsp.enable)

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Defaults applied to every server
vim.lsp.config("*", {
  capabilities = capabilities,
  root_markers = { ".git" },
})

-- Expert (Elixir), the official language server that replaced Lexical.
-- Installed by the Brewfile. nvim-lspconfig has no bundled config for it yet.
vim.lsp.config("expert", {
  cmd = { "expert", "--stdio" },
  filetypes = { "elixir", "eelixir", "heex", "surface" },
  root_markers = { "mix.exs", ".git" },
})

-- Lua (for editing this nvim config). cmd and filetypes come from nvim-lspconfig.
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
})

-- Servers installed by the Brewfile. The ones without a config above use the
-- defaults nvim-lspconfig ships in its lsp/ directory.
vim.lsp.enable({
  "expert", -- Elixir
  "lua_ls", -- Lua
  "vtsls", -- TypeScript / JavaScript / React
  "eslint", -- ESLint diagnostics and fixes
  "jsonls", -- JSON
  "cssls", -- CSS
  "tailwindcss", -- Tailwind class completion; only starts in Tailwind projects
})

-- Buffer-local keymaps when an LSP attaches
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local opts = function(desc)
      return { buffer = bufnr, desc = desc, noremap = true, silent = true }
    end

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("LSP: Go to definition"))
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("LSP: Go to declaration"))
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts("LSP: Go to implementation"))
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts("LSP: References"))
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("LSP: Hover docs"))
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts("LSP: Rename symbol"))
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("LSP: Code action"))
    vim.keymap.set("n", "[d", function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, opts("LSP: Prev diagnostic"))
    vim.keymap.set("n", "]d", function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, opts("LSP: Next diagnostic"))
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts("LSP: Show diagnostic"))
  end,
})

-- Diagnostic display
vim.diagnostic.config({
  virtual_text = { prefix = "●", spacing = 2 },
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
})
