#!/bin/bash
# Memory Companion - Setup Wizard

set -e

MEMORY_DIR="${HOME}/.openclaw/workspace/skills/memory-companion/memory"
CONFIG_FILE="${HOME}/.openclaw/workspace/skills/memory-companion/scripts/config.sh"

echo "============================================"
echo "   Welcome to Memory Companion!"
echo "============================================"
echo ""
echo "Let's tailor this to how you work."
echo ""

# Create memory directory
mkdir -p "$MEMORY_DIR/sessions"

# Ask for categories
echo "What categories matter to you?"
echo "(comma-separated, press enter for default: people, projects, tasks, finances, notes)"
read -p "> " CATEGORIES
CATEGORIES=${CATEGORIES:-"people,projects,tasks,finances,notes"}

# Ask for triggers
echo ""
echo "What keywords should trigger auto-capture?"
echo "(comma-separated, press enter for default: remember, don't forget, note this, let's do, action item)"
read -p "> " TRIGGERS
TRIGGERS=${TRIGGERS:-"remember,don't forget,note this,let's do,action item"}

# Ask for aggressiveness
echo ""
echo "How aggressive should auto-capture be?"
echo "[1] Aggressive (captures almost everything)"
echo "[2] Balanced (captures key items) [default]"
echo "[3] Minimal (only explicit triggers)"
read -p "> " AGGRESSION
AGGRESSION=${AGGRESSION:-2}

# Save config
cat > "$CONFIG_FILE" << EOF
# Memory Companion Configuration
# Generated $(date)

CATEGORIES="$CATEGORIES"
TRIGGERS="$TRIGGERS"
AGGRESSION=$AGGRESSION
LAST_SETUP=$(date +%s)
EOF

echo ""
echo "============================================"
echo "✓ Setup complete!"
echo "============================================"
echo ""
echo "Try these commands:"
echo "  memory-companion remember \"<thing>\"  - Quick capture"
echo "  memory-companion context                 - Get session summary"
echo "  memory-companion status                 - See what's tracked"
echo ""