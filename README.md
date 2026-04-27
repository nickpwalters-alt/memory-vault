# Memory Vault

A drop-in skill that gives any Heyron agent a structured, searchable memory system.

## What It Does

- **Auto-capture** — Tags important info (dates, numbers, decisions, action items) from conversations
- **Structured storage** — Memories organized by category (people, projects, preferences, action_items, notes)
- **Fast recall** — Search across all memory files with natural language queries
- **Session continuity** — Summarizes prior session context when you wake up

## Installation

1. Drop this folder into `~/workspace/skills/memory-vault/`
2. That's it — the skill commands are available immediately

```bash
# Example installation
cp -r memory-vault ~/workspace/skills/
```

## Quick Start

```bash
# Capture a memory
~/workspace/skills/memory-vault/scripts/capture.sh --category people --content "John prefers email over calls" --tags email,preference

# Search memories
~/workspace/skills/memory-vault/scripts/recall.sh "John preference"

# Get session summary
~/workspace/skills/memory-vault/scripts/session-summary.sh

# View stats
~/workspace/skills/memory-vault/scripts/stats.sh
```

## Commands

### capture.sh

Capture a memory entry.

```bash
capture.sh --category <category> --content "<memory>" [--tags <tags>] [--importance <level>]
```

**Categories:** people, projects, preferences, action_items, notes

**Importance:** low, medium, high

**Tags:** Comma-separated (optional)

### recall.sh

Search memories.

```bash
recall.sh "<search query>"
```

### session-summary.sh

Get a summary of prior session.

```bash
session-summary.sh
```

### stats.sh

Show memory statistics.

```bash
stats.sh
```

## Auto-Capture Integration

Add this to your SOUL.md to enable "remember this" auto-capture:

```markdown
## Memory Vault Integration
When user says "remember this" or "don't forget", call:
memory-vault capture --category notes --content "<the thing to remember>" --importance high
```

## File Structure

```
memory-vault/
├── SKILL.md              # This file
├── README.md             # Installation & usage
├── scripts/
│   ├── capture.sh        # Capture a memory
│   ├── recall.sh         # Search memories
│   ├── session-summary.sh # Summarize prior session
│   └── stats.sh          # Show memory stats
└── vault/
    └── memories/         # Memory storage (created on first use)
```

## Requirements

- Bash 4+
- jq (optional, for JSON parsing)
- curl (optional, for web search integration)

## Why This Is Useful

- Never lose track of "remember this" requests
- Quick lookup of client preferences, project status
- Automatically surface relevant context when starting a new session
- Portable — anyone can drop it into their workspace and use it

## License

MIT License - feel free to use, modify, and distribute.

## Author

Built for Heyron Agent Jam #1