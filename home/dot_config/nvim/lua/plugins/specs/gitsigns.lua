require("gitsigns").setup({
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
  current_line_blame = true, -- Enable inline git blame
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    -- Key mappings
    local function keymap(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Git blame
    keymap("n", "<leader>gb", function()
      gs.blame_line({ full = true })
    end, { desc = "Git blame" })

    -- Diff the file against the index. Gitsigns has no "status" action.
    keymap("n", "<leader>gs", function()
      gs.diffthis()
    end, { desc = "Diff file against index" })

    -- Checkout (revert changes to file)
    keymap("n", "<leader>gr", function()
      if vim.fn.confirm("Revert file to original status?", "&Yes\n&No", 1) == 1 then
        gs.reset_buffer()
      end
    end, { desc = "Revert file" })

    -- Navigation
    keymap("n", "]c", function()
      gs.nav_hunk("next")
    end, { desc = "Next hunk" })

    keymap("n", "[c", function()
      gs.nav_hunk("prev")
    end, { desc = "Previous hunk" })

    -- Actions
    -- On a hunk that is already staged, stage_hunk unstages it.
    keymap({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "Stage / unstage hunk" })
    keymap({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
    keymap("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
    keymap("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
  end,
})
