#!/usr/bin/env bash
# Run the lecture examples and compare their exact expected output.
set -euo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

NVM_SCRIPT="${NVM_DIR:-/usr/local/share/nvm}/nvm.sh"
if [[ -f "$NVM_SCRIPT" ]]; then
    # shellcheck disable=SC1090
    source "$NVM_SCRIPT"
fi

SOURCE="$ROOT/labs/week01/examples"
TEMP="$(mktemp -d)"
trap 'rm -rf -- "$TEMP"' EXIT

expected_python=$'average = 80.0\nscores >= 80 = 3'
expected_other=$'average = 80\nscores >= 80 = 3'

check_output() {
    local label="$1" expected="$2" actual="$3"
    if [[ "$actual" != "$expected" ]]; then
        printf 'FAIL: %s\nExpected:\n%s\nActual:\n%s\n' \
            "$label" "$expected" "$actual" >&2
        exit 1
    fi
    printf 'PASS: %s\n' "$label"
}

PYTHONPYCACHEPREFIX="$TEMP/pycache" python3 -m py_compile "$SOURCE/scores.py"
check_output 'Python' "$expected_python" "$(python3 "$SOURCE/scores.py")"

node --check "$SOURCE/scores.js"
check_output 'JavaScript / Node.js' "$expected_other" "$(node "$SOURCE/scores.js")"

for compiler in g++ clang++; do
    command -v "$compiler" >/dev/null 2>&1 || {
        printf 'MISSING: %s\n' "$compiler" >&2
        exit 1
    }
    "$compiler" -std=c++20 -Wall -Wextra -Wpedantic -Werror -O0 \
        "$SOURCE/scores.cpp" -o "$TEMP/scores"
    check_output "C++ / $compiler" "$expected_other" "$("$TEMP/scores")"
done

printf 'All four execution paths passed.\n'
