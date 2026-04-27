#!/bin/bash
# Memory Vault - Search memories

set -e

VAULT_DIR="${HOME}/.openclaw/workspace/skills/memory-vault/vault"

if [[ -z "$1" ]]; then
  echo "Usage: $0 <search query>"
  exit 1
fi

QUERY="$1"

# Check if vault exists
if [[ ! -d "$VAULT_DIR/memories" ]]; then
  echo "No memories found. Run capture to add memories first."
  exit 0
fi

# Search through memory files
echo "=== Memory Search Results for: $QUERY ==="
echo ""

# Simple grep search - could be upgraded to embeddings later
grep -r -i "$QUERY" "$VAULT_DIR/memories/" 2>/dev/null | while read -r line; do
  # Extract relevant portion
  echo "$line" | head -c 500
  echo "..."
  echo "---"
done

# If no results
if [[ -z "$(grep -r -i "$QUERY" "$VAULT_DIR/memories/")" ]]; then
  echo "No memories found matching '$QUERY'"
fi