#!/bin/bash
set -e

TEMPLATE="tpl.html"

# Prođi kroz sve .md fajlove u stories/
for f in stories/*.md; do
  name=$(basename "$f" .md)
  out="$name.html"
  echo "→ $f  =>  $out"
  pandoc "$f" \
    --template="$TEMPLATE" \
    -s -o "$out"
done

echo "✅ Gotovo. Renderovano u root. Koristi se samo style.css."

