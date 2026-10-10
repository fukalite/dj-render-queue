# Local Project Instructions & Tooling

## Available Tooling
- **asdf Toolchain**: Integrated via `$HOME/.asdf/shims` (and in PATH):
  - **Python**: Python 3.12.4 (`python`, `python3`)
  - **Just**: just 1.58.0 (`just check`, `just test`, `just typecheck`)
  - **UV**: uv 0.12.17 (`uv run`, `uv pip`)
  - **Poetry**: Poetry 2.1.1 (`poetry`)
  - **Node.js**: v24.21.0 (`node`, `npm`)
  - **Direnv**: 2.35.0 (`direnv`)
- **GitHub CLI**: `gh` v2.101.0 installed and authenticated as `marcelkornblum` with SSH protocol.
  - Create draft PRs: `gh pr create --draft ...`
  - Trigger automated reviews: `gh pr comment <pr_number> --body "/review"`
  - Update PR branches from main: ALWAYS use merge (`gh pr update-branch` without `--rebase`, or `git merge origin/main`).

## Git Safety Rules
- **NEVER Force Push or Rebase**: Do NOT use `git push -f`, `--force-with-lease`, or rebase on remote branches. Never rewrite history. Always use merge commits to update branches with `main`.
- **Verify Before Commit**: Always run `just check` and `just test` before creating any commit.
- **PR Review Resolution**: Address review feedback, reply to/resolve comments on GitHub, and ensure CI passes.

## Response & Communication Format
- **Step Reporting**: ALWAYS output the step currently in progress with a **Title** and a **sentence of description** explaining what is being done.
