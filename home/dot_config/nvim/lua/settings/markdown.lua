-- Prose settings for markdown buffers.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    local o = vim.opt_local
    o.wrap = true -- soft wrap long lines
    o.linebreak = true -- wrap at word boundaries, not mid-word
    o.breakindent = true -- wrapped lines keep the list indent
    -- Move by screen line on wrapped text.
    vim.keymap.set({ "n", "x" }, "j", "gj", { buffer = true, silent = true })
    vim.keymap.set({ "n", "x" }, "k", "gk", { buffer = true, silent = true })
  end,
})
