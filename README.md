# Word Smithy

Turn your AI assistant into an editorial workshop.

## The Problem

You write with AI, but every session starts from zero. The AI doesn't know your voice, your editing process, or which writing references to load. You explain the same preferences again and again. Your editorial context is scattered across notes, bookmarks, and memory.

## What This Is

word-smithy is a skill for AI coding assistants that routes any writing task to the right workflow, voice docs, and references. You define your voice once, condense your favorite writing books into structured references, and build repeatable editorial protocols. word-smithy discovers all of it and applies it every time you write.

It works with [Claude Code](https://docs.anthropic.com/en/docs/claude-code), [Codex](https://github.com/openai/codex), and [Cursor](https://cursor.sh).

For the full story behind word-smithy, see [Smithing Words](https://www.managementcraft.co/dispatches/smithing-words).

## Quick Start

**1. Install**

```bash
npx skills add andysparks/word-smithy
```

Supports Claude Code, Codex, Cursor, and [40+ other agents](https://skills.sh).

**2. Create a voice profile**

Follow the [Creating a Voice Profile](guides/creating-a-voice-profile.md) guide. This is the single most impactful thing you can do. Even a rough first draft of your voice profile will improve every piece of writing your AI produces.

**3. Invoke it**

In Claude Code:
```
/word-smithy
```

word-smithy asks what you're working on, matches it to a protocol if one exists, and starts writing with your voice and references loaded.

## How It Works

word-smithy uses layered discovery to find your editorial context:

- **Shared config** (`~/.claude/shared/word-smithy/config.md`): Voice docs, references, and protocols that apply across all your projects.
- **Project config** (`.word-smithy/config.md` in your project root): Voice docs, references, and protocols specific to one project.

Both layers load together. Project-level configs win when they conflict with shared configs.

When you invoke `/word-smithy`:

1. It loads your voice profile and editorial principles (always on).
2. It asks what you're working on.
3. It scans your protocols for a match based on trigger phrases.
4. If a match is found, it runs that protocol step by step, loading references as each step calls for them.
5. If no match is found, you can freestyle ("just write") with your voice still active, or create a new protocol on the spot.

## Already Have Writing Rules?

If you've already defined voice, tone, or style rules in `CLAUDE.md`, `.cursorrules`, or `.github/copilot-instructions.md`, word-smithy finds and uses them automatically. You don't need to migrate anything. word-smithy layers on top of what you already have.

## Guides

- **[Creating a Voice Profile](guides/creating-a-voice-profile.md)**: Analyze your writing, capture your patterns, build a voice profile your AI can load.
- **[Condensing a Book](guides/condensing-a-book.md)**: Turn a writing craft book into a structured AI reference. Buy the book first.
- **[Writing a Protocol](guides/writing-a-protocol.md)**: Build repeatable editorial workflows that word-smithy discovers and runs.

## Config Format

word-smithy uses two config files, both optional:

**Shared** (`~/.claude/shared/word-smithy/config.md`):
```yaml
voice:
  - ~/.claude/shared/voice-core.md
references:
  - ~/.claude/shared/writing-references/
protocols:
  - ~/.claude/shared/my-editing-process.md
```

**Project** (`.word-smithy/config.md`):
```yaml
voice:
  - docs/voice-profile.md
protocols:
  - docs/editorial/
```

See [config examples](config/) for full templates.

## Protocol Format

Protocols are markdown files with YAML frontmatter:

```yaml
---
name: Blog Post Polish
triggers: polish blog post, final pass, blog cleanup
description: Three-pass polish for a blog post before publishing
layer: shared
loads:
  - ~/.claude/shared/writing-references/zinsser.md
---

# Blog Post Polish

[Your workflow steps here]
```

See the [example protocol](examples/example-protocol.md) and the [Writing a Protocol](guides/writing-a-protocol.md) guide.

## Contributing

Open an issue or submit a PR. If you've built a protocol or reference that you think others would find useful, I'd love to see it.

## License

MIT
