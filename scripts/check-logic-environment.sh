#!/usr/bin/env bash
set -euo pipefail

echo "BS0030 logic environment check"
command -v swipl >/dev/null
swipl --version

tmp_file="$(mktemp --suffix=.pl)"
trap 'rm -f "$tmp_file"' EXIT

cat >"$tmp_file" <<'PROLOG'
parent(alice,bob).
child(C,P) :- parent(P,C).
:- initialization(main).
main :-
    child(bob,alice),
    writeln('SWI-Prolog smoke test: OK'),
    halt(0).
PROLOG

swipl -q -s "$tmp_file"
