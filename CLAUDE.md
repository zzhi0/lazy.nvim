# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration built on [LazyVim](https://www.lazyvim.org/) with lazy.nvim as the plugin manager. It uses LazyVim as a base distribution and overrides/extends it via files in `lua/plugins/`.

## Architecture

- **Entry point**: `init.lua` → `lua/config/lazy.lua` (bootstraps lazy.nvim)
- **Core config**: `lua/config/` — options, keymaps, autocmds
- **Plugin specs**: `lua/plugins/` — each file returns a list of lazy.nvim plugin specs
- **Locked versions**: `lazy-lock.json` (commit the lock file when updating)
- **LazyVim extras**: `lazyvim.json` (AI/Copilot, Yanky, Markdown, TOML enabled)

## Plugin File Responsibilities

| File | Purpose |
|------|---------|
| `core.lua` | lazy.nvim + LazyVim base |
| `lsp.lua` | Mason, nvim-lspconfig (clangd, pyright, eslint, tsserver) |
| `editor.lua` | neo-tree, gitsigns, todo-comments, vim-easy-align |
| `telescope.lua` | Fuzzy finder with fzf-native, all search keymaps |
| `cmp.lua` | blink.cmp completion + LuaSnip |
| `treesitter.lua` | Parsers + treesitter-context |
| `colorscheme.lua` | Catppuccin (fallback: habamax) |
| `disabled.lua` | Explicitly disabled LazyVim default plugins |

## Key Settings

- Leader key: `;`
- Formatter: StyLua (2-space indent, 120 col width — see `stylua.toml`)
- Picker: Telescope (not snacks)
- Animations: disabled

## Updating Plugins

```sh
# Inside nvim
:Lazy update        # update all plugins
:Lazy sync          # sync to lock file
:LazyExtras         # manage LazyVim extras
:Mason              # manage LSP servers / formatters
```

## Formatting

```sh
stylua lua/          # format all Lua files
stylua lua/plugins/lsp.lua  # format a single file
```
