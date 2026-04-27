#!/bin/bash
# Memory Companion - Show status

set -e

MEMORY_DIR="${HOME}/.openclaw/workspace/skills/memory-companion/memory"
CONFIG_FILE="${HOME}/.openclaw/workspace/skills/memory-companion/scripts/config.sh"

echo "============================================"
echo "   Memory Companion Status"
echo "============================================"
echo ""

if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "⚠ Not configured. Run: memory-companion setup"
  exit 0
fi

echo "=== Your Settings ==="
echo ""
source "$CONFIG_FILE"
echo "Categories: $CATEGORIES"
echo "Triggers: $TRIGGERS"
echo "Aggression: $AGGRESSION"
echo ""

echo "=== Memory Stats ==="
echo ""

if [[ -d "$MEMORY_DIR/sessions" ]]; then
  TOTAL=$(grep -c "^## " "$MEMORY_DIR/sessions/"*.md 2>/dev/null | awk -F: '{sum+=$2} END {print sum}')
  echo "Total entries: $TOTAL"

  echo ""
  echo "By Category:"
  grep -rh "^## " "$MEMORY_DIR/sessions/" 2>/dev/null | grep -oP '\| \K[^|]+' | cut -d'|' -f1 | sort | uniq -c | sort -rn

  echo ""
  LAST_FILE=$(find "$MEMORY_DIR/sessions/" -name "*.md" -mmin -60 2>/dev/null | head -1)
  if [[ -n "$LAST_FILE" ]]; then
    echo "Last capture: $LAST_FILE"
  else
    echo "No captures in the last hour"
  fi
else
  echo "No memories yet. Start capturing!"
fi