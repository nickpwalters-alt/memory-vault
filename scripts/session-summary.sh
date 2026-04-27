#!/bin/bash
# Memory Vault - Session summary

set -e

VAULT_DIR="${HOME}/.openclaw/workspace/skills/memory-vault/vault"

echo "=== Session Summary ==="
echo ""

# Check for today's memories
TODAY=$(date +%Y-%m-%d)
MEMORY_FILE="$VAULT_DIR/memories/${TODAY}.md"

if [[ -f "$MEMORY_FILE" ]]; then
  echo "Today's Captures:"
  echo "---"
  cat "$MEMORY_FILE"
else
  echo "No memories captured today."
fi

echo ""
echo "=== Recent Action Items ==="
echo ""

# Find action items
if [[ -d "$VAULT_DIR/memories" ]]; then
  grep -r "action_items" "$VAULT_DIR/memories/" 2>/dev/null | tail -5 || echo "No action items found."
fi

echo ""
echo "=== Last 5 Memories ==="
echo ""

# Show last 5 entries across all files
if [[ -d "$VAULT_DIR/memories" ]]; then
  find "$VAULT_DIR/memories/" -name "*.md" -exec cat {} \; 2>/dev/null | tail -20 || echo "No memories."
fi