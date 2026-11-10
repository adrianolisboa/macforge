-- Key mapping utility
local keymap = vim.keymap.set

-- General key mappings
-- Esc in normal mode also clears the search highlight
keymap("n", "<Esc>", "<cmd>nohlsearch<CR><Esc>", { desc = "Clear search highlight" })

-- Nvim-Tree
keymap("n", "<leader>nt", function()
  require("nvim-tree.api").tree.toggle()
end, { noremap = true, silent = true, desc = "Toggle Nvim Tree" })

-- Keybinding for opening tree at the current file
keymap("n", "<leader>nf", "<cmd>NvimTreeFindFile<CR>", { silent = true, desc = "Show current file in tree" })

-- Telescope. Resolved on keypress rather than at load time, so a telescope
-- failure cannot wipe out every mapping defined below this point.
local function builtin(name)
  return function()
    require("telescope.builtin")[name]()
  end
end

keymap("n", "<leader>ff", builtin("find_files"), { desc = "Telescope find files" })
keymap("n", "<leader>fg", builtin("live_grep"), { desc = "Telescope live grep" })
keymap("n", "<leader>fb", builtin("buffers"), { desc = "Telescope buffers" })
keymap("n", "<leader>fh", builtin("help_tags"), { desc = "Telescope help tags" })
keymap("n", "<leader>fr", builtin("oldfiles"), { desc = "Telescope recent files" })
keymap("n", "<leader>fw", builtin("grep_string"), { desc = "Telescope grep word under cursor" })
keymap("n", "<leader>fd", builtin("diagnostics"), { desc = "Telescope diagnostics" })
keymap("n", "<leader>f.", builtin("resume"), { desc = "Telescope resume last search" })

-- Short versions of the two most used searches, as in LazyVim and VS Code.
keymap("n", "<C-p>", builtin("find_files"), { desc = "Find files" })
keymap("n", "<leader><leader>", builtin("find_files"), { desc = "Find files" })
keymap("n", "<leader>/", builtin("live_grep"), { desc = "Search text in project" })

-- Look up shortcuts: search every map by name, or open the which-key menu.
keymap("n", "<leader>fk", builtin("keymaps"), { desc = "Telescope search shortcuts" })
keymap("n", "<leader>?", function()
  require("which-key").show({ global = false })
end, { desc = "Shortcuts for this buffer" })

-- Bufferline
keymap("n", "<leader>bn", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
keymap("n", "<leader>bp", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
keymap("n", "<leader>br", "<cmd>BufferLineMoveNext<CR>", { desc = "Move buffer right" })
keymap("n", "<leader>bl", "<cmd>BufferLineMovePrev<CR>", { desc = "Move buffer left" })
keymap("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Close current buffer" })
keymap("n", "<leader>ba", "<cmd>bufdo bdelete<CR>", { desc = "Close all buffers" })
keymap("n", "<leader>bo", "<cmd>%bd|e#|bd#<CR>", { desc = "Close all except current" })

-- Vim-Test
keymap("n", "<leader>tn", "<cmd>TestNearest<CR>", { desc = "Run nearest test" })
keymap("n", "<leader>tf", "<cmd>TestFile<CR>", { desc = "Run tests in file" })
keymap("n", "<leader>ts", "<cmd>TestSuite<CR>", { desc = "Run entire test suite" })
keymap("n", "<leader>tl", "<cmd>TestLast<CR>", { desc = "Re-run last test" })
keymap("n", "<leader>tv", "<cmd>TestVisit<CR>", { desc = "Visit last test location" })

-- Formatter
keymap("n", "<leader>mf", function()
  require("conform").format({ async = true })
end, { desc = "Format current file" })

keymap("n", "<leader>md", function()
  require("conform").format({ diff = true })
end, { desc = "Format and show diff" })

keymap("n", "<leader>mv", function()
  require("conform").format({ async = false, verbose = true })
end, { desc = "Verbose format" })

-- Other key mappings
keymap("n", "<leader>cf", "<cmd>CopyFullPath<CR>", { silent = true, desc = "Copy full file path" })
keymap("n", "<leader>cr", "<cmd>CopyRelativePath<CR>", { silent = true, desc = "Copy relative file path" })

return true
