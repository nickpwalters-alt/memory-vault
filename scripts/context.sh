#!/bin/bash
# Memory Companion - Session context summary

set -e

MEMORY_DIR="${HOME}/.openclaw/workspace/skills/memory-companion/memory"
TODAY=$(date +%Y-%m-%d)

echo "============================================"
echo "   Session Context - $TODAY"
echo "============================================"
echo ""

if [[ ! -d "$MEMORY_DIR/sessions" ]]; then
  echo "No session memories found."
  exit 0
fi

SESSION_FILE="$MEMORY_DIR/sessions/${TODAY}.md"

if [[ -f "$SESSION_FILE" ]]; then
  echo "=== Today's Captures ==="
  echo ""
  cat "$SESSION_FILE"
else
  echo "No captures yet today."
fi

echo ""
echo "=== Recent Decisions ==="
echo ""
grep -ri "decided\|decision\|agreed\|going with" "$MEMORY_DIR/sessions/" 2>/dev/null | tail -5 || echo "None found."

echo ""
echo "=== Action Items ==="
echo ""
grep -ri "todo\|action item\|will do\|need to\|i'll" "$MEMORY_DIR/sessions/" 2>/dev/null | tail -5 || echo "None found."

echo ""
echo "=== Key Facts (money, names, dates) ==="
echo ""
grep -ri '\$' "$MEMORY_DIR/sessions/" 2>/dev/null | tail -5 || echo "None found."
grep -riE '[A-Z][a-z]+ [A-Z][a-z]+' "$MEMORY_DIR/sessions/" 2>/dev/null | tail -5 || echo "None found."