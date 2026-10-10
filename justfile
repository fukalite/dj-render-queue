# dj-render-queue — task runner
# Requires: just (https://just.systems), uv (https://docs.astral.sh/uv/)

# Show available recipes
default:
    @just --list

# Install all dependencies (including dev, docs)
install:
    uv pip install -e ".[dev,docs]"

# Install the pre-commit git hook (runs `just fix` before every commit)
install-hooks:
    #!/usr/bin/env sh
    hook=".git/hooks/pre-commit"
    cat > "$hook" << 'EOF'
    #!/usr/bin/env sh
    set -e
    just fix
    EOF
    chmod +x "$hook"
    echo "Pre-commit hook installed at $hook"

# Run unit tests
test:
    uv run --no-sync pytest tests/

# Run a single test by keyword pattern
test-one pattern:
    uv run --no-sync pytest tests/ -k "{{pattern}}"

# Check linting and formatting without making changes
check:
    uv run --no-sync ruff check .

# Auto-fix all fixable lint and formatting issues (run by pre-commit hook)
fix:
    uv run --no-sync ruff check --fix .
    uv run --no-sync ruff format .

# Alias for fix
fmt: fix

# Run type checking
typecheck:
    uv run --no-sync mypy dj_render_queue/

# Run unit tests with coverage report
coverage:
    uv run --no-sync pytest tests/ --cov --cov-report=term-missing

# Generate and display PR coverage summary comment
coverage-comment:
    uv run --no-sync python .github/scripts/coverage_comment.py --dry-run

# Serve the MkDocs documentation site locally
docs-serve:
    uv run --no-sync mkdocs serve

# Build the MkDocs documentation site
docs-build:
    uv run --no-sync mkdocs build

# Build the distribution packages
build:
    uv build

# Run the example project development server
demo:
    #!/usr/bin/env sh
    uv run --no-sync python example_project/manage.py migrate --run-syncdb
    uv run --no-sync python example_project/manage.py runserver 8000 &
    SERVER_PID=$!
    echo "Starting example project (PID $SERVER_PID) at http://localhost:8000/ ..."
    sleep 2
    xdg-open "http://localhost:8000/" 2>/dev/null || open "http://localhost:8000/" 2>/dev/null || echo "Open http://localhost:8000/ in your browser"
    echo "Press Ctrl+C to stop the server"
    wait $SERVER_PID

# Fetch, parse, and display unresolved PR comments
comments pr_number="":
    uv run --no-sync python .github/scripts/pr_comments.py {{pr_number}}
