#!/bin/bash
# Memory Vault - Capture a memory entry

set -e

CATEGORY=""
CONTENT=""
TAGS=""
IMPORTANCE="medium"
VAULT_DIR="${HOME}/.openclaw/workspace/skills/memory-vault/vault"

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
    --tags)
      TAGS="$2"
      shift 2
      ;;
    --importance)
      IMPORTANCE="$2"
      shift 2
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

# Validate required args
if [[ -z "$CATEGORY" ]]; then
  echo "Error: --category is required"
  exit 1
fi

if [[ -z "$CONTENT" ]]; then
  echo "Error: --content is required"
  exit 1
fi

# Create vault directory if needed
mkdir -p "$VAULT_DIR/memories"

# Generate ID and timestamp
ID=$(date +%s)
TIMESTAMP=$(date -Iseconds)
DATE=$(date +%Y-%m-%d)

# Create memory entry
MEMORY_FILE="$VAULT_DIR/memories/${DATE}.md"

# Build the entry
ENTRY="## $ID | $CATEGORY | $IMPORTANCE"

if [[ -n "$TAGS" ]]; then
  ENTRY+=" | Tags: $TAGS"
fi

ENTRY+="
**Timestamp:** $TIMESTAMP
**Content:** $CONTENT

---

"

# Append to today's file
echo "$ENTRY" >> "$MEMORY_FILE"

echo "Memory captured successfully!"
echo "  Category: $CATEGORY"
echo "  Importance: $IMPORTANCE"
echo "  Tags: $TAGS"
echo "  File: $MEMORY_FILE"