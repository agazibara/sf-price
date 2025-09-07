 #!/usr/bin/env bash
set -euo pipefail

SRC_DIR="stories"     # .md fajlovi
OUT_DIR="."           # gde ide .html
TEMPLATE="tpl.html"   # pandoc šablon

command -v pandoc >/dev/null 2>&1 || { echo "Pandoc nije instaliran."; exit 1; }
[ -d "$SRC_DIR" ] || { echo "Nema '$SRC_DIR' foldera."; exit 1; }
[ -f "$TEMPLATE" ] || { echo "Nema template '$TEMPLATE'."; exit 1; }

shopt -s nullglob
count=0
for f in "$SRC_DIR"/*.md; do
  base="$(basename "$f" .md)"
  out="$OUT_DIR/${base}.html"
  echo "→ $f  =>  $out"

  pandoc "$f" \
    --from=markdown+yaml_metadata_block+smart \
    --template="$TEMPLATE" \
    -o "$out"

  ((count++))
done
shopt -u nullglob

if [ "$count" -eq 0 ]; then
  echo "Nema .md fajlova u '$SRC_DIR'."
else
  echo "✅ Gotovo. Renderovano: $count fajl(ova)."
fi

