#!/bin/bash
# Memory Vault - Memory statistics

set -e

VAULT_DIR="${HOME}/.openclaw/workspace/skills/memory-vault/vault"

echo "=== Memory Vault Stats ==="
echo ""

# Total entries
if [[ -d "$VAULT_DIR/memories" ]]; then
  TOTAL=$(find "$VAULT_DIR/memories/" -name "*.md" -exec cat {} \; 2>/dev/null | grep -c "^## " || echo "0")
  echo "Total entries: $TOTAL"
  
  # Count by category
  echo ""
  echo "By Category:"
  grep -rh "^## " "$VAULT_DIR/memories/" 2>/dev/null | grep -oP '\| \K[^*]+' | sort | uniq -c | sort -rn || echo "  No categories found"
  
  # Count by importance
  echo ""
  echo "By Importance:"
  grep -rh "importance:" "$VAULT_DIR/memories/" 2>/dev/null | sort | uniq -c || echo "  No importance levels found"
  
  # Last capture
  echo ""
  LAST_FILE=$(find "$VAULT_DIR/memories/" -name "*.md" -mmin -1 2>/dev/null | head -1)
  if [[ -n "$LAST_FILE" ]]; then
    echo "Last capture: $LAST_FILE"
  else
    echo "No captures in the last minute"
  fi
else
  echo "No vault found. Run capture to create one."
fi