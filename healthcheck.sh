#!/bin/sh
# Prüft, ob die GitHub-Pages-Site von basketball-predictions lebt.
# Exit 1, sobald eine Seite nicht 200 liefert.
set -u

BASE="https://marvinmouroum.github.io/basketball-predictions"
PAGES="/ /results.html /lineups-spiel2.html /quick-card-spiel2.html"
fail=0

for p in $PAGES; do
  code=$(curl -s -o /dev/null -w '%{http_code}' -L --max-time 15 "$BASE$p")
  printf '%s %s\n' "$code" "$BASE$p"
  [ "$code" = "200" ] || fail=1
done

title=$(curl -s -L --max-time 15 "$BASE/" | grep -o -m1 '<title>[^<]*</title>')
printf 'title %s\n' "${title:-<keine>}"

if [ "$fail" -ne 0 ]; then
  echo "FAIL — Pages prüfen: gh api repos/marvinmouroum/basketball-predictions/pages"
  exit 1
fi

echo "OK"