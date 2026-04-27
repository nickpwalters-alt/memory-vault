#!/bin/bash
# Memory Companion - Quick capture with auto-parse

set -e

MEMORY_DIR="${HOME}/.openclaw/workspace/skills/memory-companion/memory"
CONFIG_FILE="${HOME}/.openclaw/workspace/skills/memory-companion/scripts/config.sh"

# Check for config
if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "Run 'memory-companion setup' first to configure."
  exit 1
fi

source "$CONFIG_FILE"

# Get the memory content
if [[ -z "$1" ]]; then
  echo "Usage: memory-companion remember \"<thing to remember>\""
  exit 1
fi

CONTENT="$1"

# Auto-detect category based on keywords
DETECTED_CATEGORY="notes"
TAGS=""

# Check for money
if echo "$CONTENT" | grep -qE '\$[0-9,]+'; then
  DETECTED_CATEGORY="finances"
  TAGS+="money,"
fi

# Check for people names (capitalized words)
NAMES=$(echo "$CONTENT" | grep -oE '[A-Z][a-z]+ [A-Z][a-z]+' | head -3)
if [[ -n "$NAMES" ]]; then
  DETECTED_CATEGORY="people"
  TAGS+="$NAMES,"
fi

# Check for project keywords
if echo "$CONTENT" | grep -qiE 'launch|site|project|app|website'; then
  DETECTED_CATEGORY="projects"
  TAGS+="project,"
fi

# Check for task/action keywords
if echo "$CONTENT" | grep -qiE 'todo|action|do this|will do|need to'; then
  DETECTED_CATEGORY="tasks"
  TAGS+="action,"
fi

# Clean up tags
TAGS=${TAGS%,}

# Create memory entry
SESSION_FILE="$MEMORY_DIR/sessions/$(date +%Y-%m-%d).md"
mkdir -p "$MEMORY_DIR/sessions"

TIMESTAMP=$(date -Iseconds)
ID=$(date +%s)

echo "## $ID | $DETECTED_CATEGORY" >> "$SESSION_FILE"
echo "**Time:** $TIMESTAMP" >> "$SESSION_FILE"
echo "**Content:** $CONTENT" >> "$SESSION_FILE"
if [[ -n "$TAGS" ]]; then
  echo "**Tags:** $TAGS" >> "$SESSION_FILE"
fi
echo "" >> "$SESSION_FILE"

echo "✓ Captured!"
echo "  Category: $DETECTED_CATEGORY"
[[ -n "$TAGS" ]] && echo "  Tags: $TAGS"
echo "  Content: $CONTENT"