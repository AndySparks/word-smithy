# Condensing a Book into an AI Reference

You've read a book about writing that changed how you think. Maybe it's Zinsser's *On Writing Well*, or King's *On Writing*, or McPhee's *Draft No. 4*. You've internalized some of it, but not all of it. And when you sit down with an AI assistant, you can't just say "write like Zinsser would" and expect it to know what you mean.

The fix: condense the book into a structured reference file that your AI can actually load and use.

This guide walks you through the process.

## Before You Start

Buy the book. Read it. This is not a shortcut for skipping the reading. A condensed reference is a personal tool you build *after* you've done the work of understanding the author's ideas. It's the notes you'd write in the margins if you were the kind of person who writes in margins.

Don't redistribute your reference files. They're derived from copyrighted work and meant for your personal use with your AI tools.

## What Makes a Good Reference

A good condensed reference is not a summary. Summaries flatten everything to the same weight. What you want is the author's **core moves**: the specific techniques, principles, and patterns that make their approach distinctive.

Think of it this way. If you could sit the author down and say "teach me the five things that matter most," what would they say? That's what goes in the reference.

A good reference includes:

- **Principles with teeth.** Not "write clearly" but "cut every word that doesn't do work." The principle should be specific enough that you can test a sentence against it.
- **Examples that show the move.** For each principle, include a before/after or a passage that demonstrates it. AI needs examples to pattern-match against.
- **The author's hierarchy.** What does this author care about *most*? Zinsser cares about cutting clutter above all else. McPhee cares about structure. King cares about honest storytelling. The hierarchy tells the AI what to prioritize when principles conflict.

A bad reference reads like a book report. It lists chapter topics without capturing the author's actual technique.

## The Process

### Step 1: Identify the core moves

Go through the book and pull out the 5 to 10 things the author repeats, emphasizes, or builds their entire approach around. These are the moves that show up across multiple chapters, the ones the author clearly considers non-negotiable.

For Zinsser, this might be:
- Strip every sentence to its cleanest components
- Use active verbs (not passive, not adverbs propping up weak verbs)
- Write in the first person without apology
- Cut qualifiers ("a bit," "sort of," "kind of")
- Unity of pronoun, tense, and mood within a piece

### Step 2: Write each move as a principle

For each core move, write a short section that includes:

1. **The principle in one sentence.** Direct, actionable, no hedging.
2. **Why it matters.** One to two sentences on what goes wrong when you violate it.
3. **An example.** A before/after pair, or a passage from the book that demonstrates the principle in action. Quote the author where you can.

Here's what one entry might look like:

```markdown
### Cut qualifiers

Strip words like "a bit," "sort of," "kind of," "quite," "very," and "rather."
They dilute the sentence without adding meaning.

**Why:** Qualifiers signal that the writer is hedging. They weaken every sentence
they touch. "It was quite cold" says less than "It was cold."

**Example (Zinsser):** "Every little qualifier whittles away some fraction of
the reader's trust. Readers want a writer who believes in himself and in what
he is saying. Don't diminish that belief."
```

### Step 3: Add the hierarchy

At the top of the file, state what this author cares about most. This is the tiebreaker. When two principles pull in different directions, the hierarchy tells the AI which one wins.

```markdown
## Hierarchy

Zinsser's north star is clarity through simplicity. When in doubt:
1. Cut the clutter (always wins)
2. Use active, specific language
3. Maintain the writer's identity and warmth
```

### Step 4: Structure for AI consumption

Use clear markdown headers. Keep each principle self-contained (the AI might load one section, not the whole file). Use consistent formatting so the AI can parse it predictably.

The full file should follow this structure:

```markdown
# [Author]: Condensed Reference

## Source
- **Book:** [Title]
- **Author:** [Name]
- **Why this reference:** [One sentence on what this author teaches]

## Hierarchy
[What this author cares about most, in priority order]

## Core Moves

### [Move 1 name]
[Principle + why + example]

### [Move 2 name]
[Principle + why + example]

...
```

## Where to Put It

Drop the file in your shared writing references directory:

```
[shared-root]/writing-references/zinsser.md
[shared-root]/writing-references/king.md
[shared-root]/writing-references/mcphee.md
```

Then make sure your word-smithy config points to this directory:

```yaml
references:
  - [shared-root]/writing-references/
```

## How word-smithy Uses It

References aren't loaded by default. They're loaded on demand when a protocol's `loads` field calls for them. A protocol for polishing blog posts might load your Zinsser reference. A protocol for structuring long-form pieces might load McPhee.

You can also ask word-smithy to load a specific reference mid-session: "Load the Zinsser reference and apply it to this draft."

## How Many References Do You Need?

Start with one. The book that changed how you write. Build from there if you find yourself reaching for different authors in different contexts. Three to five is probably the right number. More than that and you're collecting, not using.
