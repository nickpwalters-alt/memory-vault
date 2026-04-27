# Memory Companion

An adaptive memory system that learns your preferences, auto-captures important details before context compression, and tailors itself to how you work.

## What It Does

- **Auto-capture before compression** — Extracts key info (decisions, action items, facts) before context gets compressed
- **User-defined triggers** — Captures what matters to YOU (dollar amounts, names, project keywords)
- **Tailored setup** — First-run questionnaire customizes categories, keywords, and capture rules
- **Session context on demand** — Get a summary of everything that happened before your next message

## The Problem It Solves

Telegram/Discord chats lose context when messages get compressed. By the time you say "remember this", the details are already gone.

Memory Companion runs before each compression cycle and extracts:
- **Decisions** — "We decided to go with Option B"
- **Action items** — "I'll email the supplier"
- **Key facts** — names, numbers, dates, URLs
- **Files created** — anything new you mention

## Installation

1. Drop this folder into `~/workspace/skills/memory-companion/`
2. Run setup: `memory-companion setup`
3. That's it — it learns as you use it

```bash
cp -r memory-companion ~/workspace/skills/
```

## Quick Start

```bash
# First-time setup (answers questions about your preferences)
~/workspace/skills/memory-companion/scripts/setup.sh

# Quick capture - works like you'd naturally say it
~/workspace/skills/memory-companion/scripts/remember.sh "Remember that John prefers detailed specs"

# Get session summary before next message
~/workspace/skills/memory-companion/scripts/context.sh

# See what's being tracked
~/workspace/skills/memory-companion/scripts/status.sh
```

## Commands

### setup.sh

First-run wizard. Asks questions to tailor the skill to you.

```bash
./scripts/setup.sh
```

### remember.sh

Quick capture — works like you'd naturally say it.

```bash
./scripts/remember.sh "John prefers detailed specs over quick summaries"
```

Automatically extracts: people, preferences, context

### capture.sh

Manual capture with explicit category.

```bash
./scripts/capture.sh --category finances --content "Site costs $500/yr"
```

### recall.sh

Search your memories.

```bash
./scripts/recall.sh "John preference"
```

### context.sh

Get a summary of the current session — what was decided, what needs doing, key facts.

```bash
./scripts/context.sh
```

### status.sh

Show what's being tracked.

```bash
./scripts/status.sh
```

## How It Works

### User-Defined Triggers

You decide what triggers capture. Defaults:
- "remember" / "don't forget" / "note this"
- Dollar amounts (e.g., "$500")
- Project names you specify
- "let's do" / "action item"

### Adaptive Learning

The more you use it, the smarter it gets. It learns:
- Your categories
- Your naming conventions
- What you consider important

## Setup Example

```bash
$ ./scripts/setup.sh

Welcome to Memory Companion!
Let's tailor this to how you work.

What categories matter to you?
(separated by commas, press enter for default)
> people, projects, finances, dogs

What keywords should trigger auto-capture?
(comma-separated)
> remember, don't forget, budget, dogs

How aggressive should auto-capture be?
[1] Aggressive [2] Balanced [3] Minimal
> 2

✓ Setup complete!
```

## Session Context Output

```bash
$ ./scripts/context.sh

=== Session Context - 2026-04-27 ===

Decisions:
- Pooch Studios: Brighton vet space preferred
- Memory Companion: rebuilding for hackathon

Action Items:
- Nick to call IRS tomorrow
- Buddy to finish Memory Companion skill

Key Facts:
- Dog daycare: $40/day, $55/night
- Startup capital: ~$145K
- IRS payment issue pending
```

## File Structure

```
memory-companion/
├── SKILL.md              # This file
├── README.md             # Installation & usage
├── scripts/
│   ├── setup.sh          # First-run questionnaire
│   ├── config.sh         # User preferences (generated)
│   ├── remember.sh       # Quick capture with auto-parse
│   ├── capture.sh        # Manual capture with categories
│   ├── recall.sh         # Search memories
│   ├── context.sh        # Session summary
│   └── status.sh         # Show what's tracked
└── memory/
    └── sessions/         # Where memories are stored
```

## Requirements

- Bash 4+
- jq (optional, for JSON parsing)

## Portability

This skill uses only existing OpenClaw tools:
- `read`, `write`, `exec` for file operations
- No external dependencies

Drop into any Heyron workspace and run setup.

## License

MIT License

## Author

Built for Heyron Agent Jam #1

## Why This Is Different

Most memory skills are vaults — they store things you explicitly save.

Memory Companion is different:
1. **Proactive** — captures before context is lost
2. **Adaptive** — learns your preferences
3. **Session-aware** — gives you context before each new message
4. **User-defined** — you control what matters

That's what makes it useful.