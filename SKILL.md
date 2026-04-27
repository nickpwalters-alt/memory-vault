---
name: memory-companion
description: An adaptive memory system that learns your preferences, auto-captures important details before context compression, and tailors itself to how you work.
metadata:
  {
    openclaw: { emoji: 🧠, requires: { bins: [bash, jq] } },
  }
---

# Memory Companion

A drop-in skill that acts as your memory assistant — learns your preferences, auto-captures important info, and ensures nothing is lost to context compression.

## What It Does

- **Auto-capture before compression** — Extracts key info (decisions, action items, facts) before context gets compressed
- **User-defined triggers** — Captures what matters to YOU (dollar amounts, names, project keywords)
- **Tailored setup** — First-run questionnaire customizes categories, keywords, and capture rules
- **Session context on demand** — Get a summary of everything that happened before your next message

## Installation

1. Drop this folder into `~/workspace/skills/memory-companion/`
2. Run setup: `memory-companion setup`
3. That's it — it learns as you use it

## Commands

### `memory-companion setup`

First-run wizard. Asks questions to tailor the skill to you:

```bash
memory-companion setup
```

Asks:
- What categories matter to you? (people, projects, tasks, finances, etc.)
- What keywords should trigger capture? (defaults: remember, don't forget, let's do, $$)
- How important is auto-capture? (aggressive, balanced, minimal)

### `memory-companion remember "<thing>"`

Quick capture — works like you'd naturally say it:

```bash
memory-companion remember "John prefers detailed specs over quick summaries"
```

Automatically extracts: people, preferences, context

### `memory-companion capture --category <cat> --content "<stuff>"`

Manual capture with explicit category:

```bash
memory-companion capture --category finances --content "Site costs $500/yr"
```

### `memory-companion recall "<query>"`

Search your memories:

```bash
memory-companion recall "John preference"
```

### `memory-companion context`

Get a summary of the current session — what was decided, what needs doing, key facts:

```bash
memory-companion context
```

### `memory-companion status`

Show what's being tracked:

```bash
memory-companion status
```

## How It Works

### The Compression Problem

Telegram/Discord chats lose context when messages get compressed. By the time you say "remember this", the details are already gone.

### The Solution

Memory Companion runs before each compression cycle and extracts:

- **Decisions** — "We decided to go with Option B"
- **Action items** — "I'll email the supplier"
- **Key facts** — names, numbers, dates, URLs
- **Files created** — anything new you mention

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

## File Structure

```
memory-companion/
├── SKILL.md
├── README.md
├── scripts/
│   ├── setup.sh          # First-run questionnaire
│   ├── config.sh        # User preferences (generated)
│   ├── remember.sh      # Quick capture
│   ├── capture.sh       # Manual capture with categories
│   ├── recall.sh        # Search memories
│   ├── context.sh      # Session summary
│   ├── status.sh       # Show what's tracked
│   └── auto-capture.sh # Background trigger watcher
└── memory/
    └── sessions/        # Where memories are stored
```

## Setup Example

```bash
$ memory-companion setup

Welcome to Memory Companion!
Let's tailor this to how you work.

What categories matter to you?
(categories are separated by commas)
[default: people, projects, tasks, finances, notes]
> people, projects, finances, dogs

What keywords should trigger auto-capture?
(comma-separated, or press enter for defaults)
[keywords: remember, don't forget, note this, let's do, action item, $ amount]
> remember, don't forget, action item, budget, dogs

How aggressive should auto-capture be?
[1] Aggressive (captures almost everything)
[2] Balanced (captures key items)
[3] Minimal (only explicit triggers)
> 2

✓ Setup complete! Run 'memory-companion remember "<thing>"' to start.
```

## Usage Examples

**Quick memory:**
```
user: "remember that the site renewal is $500/yr"
→ extracts: $500/yr, renewal, site → saves to finances + notes
```

**Manual capture:**
```
memory-companion capture --category projects --content "ROC MAFIA launch due May 1"
```

**Session context:**
```
$ memory-companion context

=== Session Context ===

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

Files/Links:
- Pooch Studios spreadsheet
- Vet space photos (indoor + outdoor kennels)
```

## Requirements

- Bash 4+
- jq (for JSON parsing)

## Portability

This skill uses only existing OpenClaw tools:
- `read`, `write`, `exec` for file operations
- No external dependencies

Drop into any Heyron workspace and run setup.

## License

MIT License

## Author

Built by Nick & Buddy for Heyron Agent Jam #1