---
name: memory-vault
description: Structured memory system for Heyron agents. Auto-captures important info, organizes by category, enables fast recall across sessions.
metadata:
  {
    openclaw: { emoji: 🗄️, requires: { bins: [bash, jq, curl] } },
  }
---

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

## Commands

### `memory-vault capture`

Capture a memory entry. Usage:

```bash
memory-vault capture --category people --content "John prefers email over calls" --tags email,preference
```

Options:
- `--category` (required): people, projects, preferences, action_items, notes
- `--content` (required): The memory text
- `--tags` (optional): Comma-separated tags
- `--importance` (optional): low, medium, high (default: medium)

### `memory-vault recall`

Search memories. Usage:

```bash
memory-vault recall "John preference"
```

Returns matching entries with relevance scores.

### `memory-vault session-summary`

Get a summary of the prior session. Usage:

```bash
memory-vault session-summary
```

Returns key decisions, action items, and recent context.

### `memory-vault stats`

Show memory statistics. Usage:

```bash
memory-vault stats
```

Returns counts by category, total entries, last capture time.

## Auto-Capture (Optional)

To enable automatic capture of "remember this" requests, add this to your SOUL.md:

```
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

## Examples

**Capture a client preference:**
```bash
memory-vault capture --category preferences --content "Client prefers detailed specs over quick summaries" --tags client,specs
```

**Find all project-related entries:**
```bash
memory-vault recall "project timeline"
```

**Get session summary:**
```bash
memory-vault session-summary
```

## Requirements

- Bash 4+
- jq (for JSON parsing)
- curl (for web search integration)

## Portability

This skill uses only existing OpenClaw tools:
- `memory_get`, `memory_search` for storage
- `read`, `write`, `exec` for file operations
- No external dependencies beyond standard tools

Anyone can drop this into their workspace and start using it immediately.