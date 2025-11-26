# Repository Guidelines

## Project Structure & Module Organization
- Core entrypoint: `init.lua` loads AstroNvim user configuration.
- User overrides live in `lua/`:
  - `lua/plugins/*.lua` defines plugin specs for Lazy, LSP, UI, and tools (e.g., `astrolsp.lua`, `astrocore.lua`, `mason.lua`).
  - Helpers and custom logic reside in files like `lua/autowrite.lua`, `lua/include_open_tabs.lua`, and `lua/polish.lua`.
- Lockfiles & metadata: `lazy-lock.json` (plugin versions), `selene.toml` (Lua lint rules), optional `neovim.yml` (CI/local task hints).

## Build, Test, and Development Commands
- `nvim +Lazy! sync +qa` — install or update plugins headlessly; rerun after changing `lua/plugins/`.
- `nvim --headless '+Lazy! check' '+qa'` — validate plugin specs resolve and report missing deps.
- `selene lua` — lint Lua against Neovim std (respects `selene.toml`). Install via `brew install selene` if needed.
- `nvim` then `:checkhealth` — interactive health report; run after adding new native deps (ripgrep, clangd, etc.).

## Coding Style & Naming Conventions
- Lua: 2-space indent; prefer local functions; avoid globals unless explicitly intentional (see relaxed `selene.toml`).
- Naming: plugin spec files use `snake_case.lua`; module tables use descriptive keys mirroring plugin purpose (`codecompanion`, `none-ls_sql`).
- Formatting: keep tables compact; trailing commas for multi-line tables; align with AstroNvim defaults. Use `:lua vim.lsp.buf.format()` when an LSP formatter is available.

## Testing Guidelines
- Aim for a clean `nvim --headless '+Lazy! check' '+qa'` before pushing.
- Smoke test UI-critical changes: open Neo-tree, check completion, run `:Mason` and `:LspInfo`.
- If modifying LSP/tooling, verify diagnostics in a sample buffer (e.g., C/C++ with clangd, SQL with sqls/none-ls) and that commands like `:NullLsInfo` respond.

## Commit & Pull Request Guidelines
- Prefer Conventional Commit prefixes (`feat:`, `fix:`, `chore:`, `docs:`); keep scope short (e.g., `feat: tweak neo-tree filters`).
- One logical change per commit; include context in the body for config rationale (links to plugin docs/issues help).
- PRs should note:
  - What was changed and why.
  - Manual checks performed (headless Lazy check, UI smoke tests).
  - Screenshots or short clips when altering UI (statusline, notifications, Neo-tree).

## Security & Configuration Tips
- Never commit API keys or auth tokens (AI/chat tools like Codeium, Gemini, CodeCompanion expect env vars or local files).
- Keep `lazy-lock.json` in sync with tested plugin versions; update only after running sync and checks.
- When adding new tools that require external binaries, document the install command in the PR description.
