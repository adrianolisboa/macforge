local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

return require("lazy").setup({
  -- Manage lazy.nvim itself
  { "folke/lazy.nvim" },

  ------ UI Plugins ------
  -- Colorscheme (Solarized Dark)
  {
    "ishan9299/nvim-solarized-lua",
    lazy = false, -- Load during startup
    priority = 1000, -- Ensure it loads before other plugins
    config = function()
      -- nvim-solarized-lua draws the tabline and statusline with reverse video.
      -- Neovim combines every bar segment with these base groups, so the reverse
      -- leaked into bufferline and lualine and swapped their colors (grey tabs).
      -- Redefine the base groups without it each time the colorscheme loads.
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "solarized",
        callback = function()
          local set = vim.api.nvim_set_hl
          set(0, "TabLine", { fg = "#586e75", bg = "#073642" })
          set(0, "TabLineFill", { fg = "#586e75", bg = "#073642" })
          set(0, "TabLineSel", { fg = "#93a1a1", bg = "#002b36", bold = true })
          set(0, "StatusLine", { fg = "#93a1a1", bg = "#073642" })
          set(0, "StatusLineNC", { fg = "#586e75", bg = "#073642" })
          set(0, "StatusLineTerm", { link = "StatusLine" })
          set(0, "StatusLineTermNC", { link = "StatusLineNC" })
        end,
      })
      vim.cmd([[ colorscheme solarized ]])
    end,
  },

  -- Treesitter for better syntax highlighting. The `main` branch is a rewrite:
  -- it only installs parsers, and Neovim's own treesitter does the highlighting.
  -- It does not support lazy loading. Needs tree-sitter-cli (Brewfile).
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("plugins.specs.treesitter")
    end,
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("plugins.specs.nvim-tree")
    end,
  },

  -- Icons for file explorer
  {
    "nvim-tree/nvim-web-devicons",
    opts = {
      default = true, -- Enable default icons
    },
  },

  -- Icon provider snacks.nvim prefers when it is installed
  {
    "echasnovski/mini.icons",
    version = false,
    config = function()
      require("mini.icons").setup()
    end,
  },

  -- Telescope for fuzzy finding
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      require("plugins.specs.telescope")
    end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("plugins.specs.lualine")
    end,
  },

  -- Bufferline
  {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("plugins.specs.bufferline")
    end,
  },

  -- Indentation guides
  {
    "lukas-reineke/indent-blankline.nvim",
    version = "v3.*",
    config = function()
      require("plugins.specs.indent_blankline")
    end,
  },

  -- Formatter
  {
    "stevearc/conform.nvim",
    config = function()
      require("plugins.specs.conform")
    end,
  },

  -- Markdown rendered in normal mode, raw in insert mode
  require("plugins.specs.render-markdown"),

  ------ A.I Plugins ------
  require("plugins.specs.claudecode"),

  ------ Programming Plugins ------
  -- test.nvim: Test runner
  {
    "vim-test/vim-test",
    config = function()
      require("plugins.specs.vim-test")
    end,
  },

  -- nvim-cmp: Auto-completion plugin
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),

        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),

        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
      })
    end,
  },

  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("plugins.specs.gitsigns")
    end,
  },

  ------ Language Server Plugins ------
  -- LSP configuration
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.specs.lsp")
    end,
  },

  -- Which-key for displaying keybindings
  require("plugins.specs.which-key"),
})
