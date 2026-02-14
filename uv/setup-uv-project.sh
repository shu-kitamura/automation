#!/bin/bash
set -euo pipefail

PWD=$(pwd)
project_name=$1

if ! command -v uv >/dev/null 2>&1; then
	echo "uv is not installed, so this script cannot run."
	exit 1
fi

if [[ -z "$project_name" ]]; then
	echo "Usage: $0 <project-name>"
	exit 1
fi

# create uv project with git
uv init $project_name --vcs git

cd $project_name

# add lint, format, test
uv add --dev ruff ty pytest

# mkdir src and tests
mkdir -p src/YOUR_APP_NAME tests

# mv main.py to src
mv main.py src/YOUR_APP_NAME/

# create __init__.py in tests
touch tests/__init__.py
# create a smoke test in tests/test_example.py
cat > tests/test_example.py <<'PY'
def test_example():
    assert 1 + 1 == 2
PY

echo "Project $project_name has been set up with uv, ruff, and pytest."
echo "Don't forget to replace YOUR_APP_NAME with the actual name of your application in the src directory."

cd "$PWD"
