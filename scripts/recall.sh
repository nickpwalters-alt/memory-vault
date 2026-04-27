#!/bin/bash
# Memory Companion - Search memories

set -e

MEMORY_DIR="${HOME}/.openclaw/workspace/skills/memory-companion/memory"

if [[ -z "$1" ]]; then
  echo "Usage: memory-companion recall \"<query>\""
  exit 1
fi

QUERY="$1"

echo "=== Searching for: $QUERY ==="
echo ""

if [[ ! -d "$MEMORY_DIR/sessions" ]]; then
  echo "No memories found. Run 'memory-companion remember \"<thing>\"' first."
  exit 0
fi

# Search
RESULTS=$(grep -ri "$QUERY" "$MEMORY_DIR/sessions/" 2>/dev/null | head -20)

if [[ -z "$RESULTS" ]]; then
  echo "No results found."
else
  echo "$RESULTS"
fi