# Neovim Configuration

A clean, modular Neovim setup using `lazy.nvim` for plugin management.

This config is part of [macforge](../../../README.md) and is stowed to
`~/.config/nvim`. You don't clone it separately — running `./macforge setup`
symlinks it into place. Edit the files here in the repo, not in `~/.config/nvim`
(that path is a symlink back to this directory).

## Layout

```
init.lua                 -- entry point (loads settings + plugins)
lazy-lock.json           -- pinned plugin versions (committed for reproducibility)
lua/settings/            -- options, keymaps, autocommands
lua/plugins/init.lua     -- lazy.nvim plugin list
lua/plugins/specs/       -- per-plugin config (lsp, telescope, conform, ...)
```

## First launch

After `./macforge setup` has symlinked the config, `lazy.nvim` bootstraps itself
on first launch. Just open Neovim and let it install:

```bash
nvim
# inside Neovim, if needed:
# :Lazy sync
```

## Language servers and formatting

The Brewfile installs every server; `lua/plugins/specs/lsp.lua` turns them on.

| Language | Server |
| --- | --- |
| Elixir | `expert` |
| Lua | `lua_ls` |
| TypeScript / JavaScript / React | `vtsls` |
| ESLint, JSON, CSS | `eslint`, `jsonls`, `cssls` |
| Tailwind | `tailwindcss` (only starts in Tailwind projects) |

Format on save (`lua/plugins/specs/conform.lua`): `mix format` for Elixir,
`stylua` for Lua, and `prettierd` for web files only when the repo has a
prettier config. Web files never fall back to LSP formatting, so a repo without
prettier is not reformatted.

## AI plugin

Uses [`claudecode.nvim`](https://github.com/coder/claudecode.nvim) (Claude Code
integration). Keymaps under `<leader>c*` — see `lua/plugins/specs/claudecode.lua`.

## Markdown

[`render-markdown.nvim`](https://github.com/MeanderingProgrammer/render-markdown.nvim)
draws headings, lists, checkboxes, tables and code blocks in normal mode.
Insert mode shows the raw text, and so does the line under the cursor.
`<leader>mr` turns the rendering on and off. Markdown buffers also soft wrap at
word boundaries, and `j`/`k` move by screen line.

`lua/plugins/specs/treesitter-compat.lua` patches three query directives that the
archived `master` branch of nvim-treesitter breaks on Neovim 0.12 (code blocks in
markdown crashed with `attempt to call method 'range'`). Delete it when moving to
the `main` branch.

## Required font

Works best with a Nerd Font (e.g. FiraCode Nerd Font):

```bash
brew install --cask font-fira-code-nerd-font
```

Then set your terminal to "FiraCode Nerd Font" (or "… Mono").
