#!/bin/bash
# Memory Companion - Manual capture with category

set -e

MEMORY_DIR="${HOME}/.openclaw/workspace/skills/memory-companion/memory"
CONFIG_FILE="${HOME}/.openclaw/workspace/skills/memory-companion/scripts/config.sh"

CATEGORY=""
CONTENT=""

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --category)
      CATEGORY="$2"
      shift 2
      ;;
    --content)
      CONTENT="$2"
      shift 2
      ;;
    *)
      shift
      ;;
  esac
done

if [[ -z "$CATEGORY" ]] || [[ -z "$CONTENT" ]]; then
  echo "Usage: memory-companion capture --category <cat> --content \"<stuff>\""
  exit 1
fi

SESSION_FILE="$MEMORY_DIR/sessions/$(date +%Y-%m-%d).md"
mkdir -p "$MEMORY_DIR/sessions"

TIMESTAMP=$(date -Iseconds)
ID=$(date +%s)

echo "## $ID | $CATEGORY" >> "$SESSION_FILE"
echo "**Time:** $TIMESTAMP" >> "$SESSION_FILE"
echo "**Content:** $CONTENT" >> "$SESSION_FILE"
echo "" >> "$SESSION_FILE"

echo "✓ Captured!"
echo "  Category: $CATEGORY"
echo "  Content: $CONTENT"