-- Parsers to keep installed. install() skips the ones already present and runs
-- in the background, so startup does not wait on it.
local parsers = {
  -- Languages in use
  "elixir",
  "eex",
  "heex",
  "lua",
  "python",
  "javascript",
  "typescript",
  "tsx",
  "json",
  "css",
  "html",
  "bash",
  "yaml", -- also markdown front matter
  "markdown",
  "markdown_inline",
  -- Used by Neovim itself (help pages, :checkhealth, commit messages, diffs)
  "vim",
  "vimdoc",
  "query",
  "regex",
  "diff",
  "gitcommit",
}

require("nvim-treesitter").install(parsers)

-- Turn on highlighting and indentation for any buffer whose language has a
-- parser installed. Buffers without one keep the regular Vim syntax.
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)
    if not lang or not pcall(vim.treesitter.start, args.buf, lang) then
      return
    end
    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
