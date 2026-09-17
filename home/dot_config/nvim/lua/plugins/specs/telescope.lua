local telescope = require("telescope")

telescope.setup({
  defaults = {
    -- These are Lua patterns, not literal text: an unanchored ".git" also
    -- matches .gitignore, .gitlab-ci.yml and any path containing "git".
    file_ignore_patterns = {
      "^%.git/",
      "/%.git/",
      "^node_modules/",
      "/node_modules/",
      "^_build/",
      "/_build/",
      "^%.cache/",
      "/%.cache/",
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({}),
    },
  },
})

-- Both extensions are inert until loaded: fzf replaces the sorters, and
-- ui-select takes over vim.ui.select.
telescope.load_extension("fzf")
telescope.load_extension("ui-select")
