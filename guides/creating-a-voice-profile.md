# Creating a Voice Profile

AI writes like AI. You've seen it: the same rhythms, the same hedging, the same consultant vocabulary in every output. "It's worth noting that there are several key factors to consider." Nobody talks like that. Certainly not you.

A voice profile teaches your AI what *you* sound like. It captures the patterns, preferences, and hard bans that make your writing yours. word-smithy loads it before every writing task, so everything that comes out the other side sounds like you wrote it.

This guide walks you through building one.

## Collect Your Samples

Pull together 5 to 10 pieces of your best writing. The writing you're proudest of, the stuff that sounds most like you. Mix the contexts:

- A blog post or essay
- A few emails (one professional, one casual)
- A social media post that felt right
- A presentation or talk transcript
- A journal entry or personal note

You need range. Your voice isn't one register. It shifts depending on audience and context, and your profile should capture that.

If you don't have much written work, record yourself talking about something you care about for five minutes and transcribe it. Your speaking voice is your writing voice with fewer filters.

## Find the Patterns

Read through your samples and look for what repeats. Not the topics, the *moves*. How do you start things? How do you end them? What words do you reach for? What words do you never use?

### Structural habits

How do you build an argument?

- Do you lead with the problem or the solution?
- Do you use analogies? From what domain?
- Do you layer points (framework, then example, then nuance) or state the conclusion first?
- How long are your paragraphs? Do they vary?

### Sentence-level patterns

How do your sentences sound?

- Do you alternate short sentences with long ones, or keep a steady rhythm?
- Do you address the reader as "you" or talk in the third person?
- Do you use contractions? Always, sometimes, never?
- Do you swear? When?
- Do you ask rhetorical questions?

### Word-level preferences

What's your vocabulary like?

- Do you use plain words ("figure out") or formal ones ("determine")?
- Are there words or phrases that show up in everything you write?
- Are there words you never use? Words that make you cringe when you see them in AI output?

## Write Your Hard Bans

Everyone has words, phrases, or patterns they never want to see in their writing. These are your hard bans, the zero-tolerance list. When your AI produces something with a hard ban in it, it's wrong, full stop.

Common hard bans:

- Specific words: "leverage," "utilize," "optimize," "synergy"
- Patterns: "It's not X. It's Y." (a recognizable AI construction)
- Transitions: "Furthermore," "Additionally," "Moreover," "In conclusion"
- Hedging: "It's worth considering," "One approach might be"
- Expanded contractions: "do not" instead of "don't," "it is" instead of "it's"

Be specific. "Don't sound corporate" isn't a hard ban. "Never use the word 'stakeholders'" is.

## Define Your Registers

Your voice changes depending on context. You write differently in a professional email than in a blog post. A voice profile should capture these registers, not just one mode.

For each register you write in, describe:

- **The context:** When do you use this register?
- **How it differs:** What changes from your default voice? More formal? Looser? Different vocabulary?
- **What stays the same:** Which patterns persist across every register? (These are the core of your voice.)

Example registers:

- **Professional email:** Direct, warm, contractions always, short paragraphs. Greeting: casual.
- **Blog post:** Core voice with the leash off. More humor, more personality, longer sentences allowed.
- **Social media:** Punchy, fragmented, highest energy. Pop culture references OK.

## Write Your Voice Tests

A voice test is a simple question you can ask about any piece of writing to check if it sounds like you. Two or three tests are enough.

Examples:

- **The Coffee Test:** Would you say this to a friend over coffee? If the language is too elevated for that, dial it back.
- **The Attribution Test:** If someone read this without a byline, would they guess you wrote it? If it could have been written by anyone, it's too generic.
- **The Cringe Test:** Is there a single line that makes you wince? Cut it.

Your tests should be specific to what matters to you. If you care most about warmth, test for warmth. If you care most about directness, test for directness.

## Structure the File

Put it all together in a markdown file that follows this structure:

```markdown
# [Your Name]: Voice Profile

## Identity
[One paragraph: who you are, what you write, why your voice matters]

## Core Patterns

### Structural Habits
[Your structural patterns with examples]

### Sentence-Level Patterns
[Your sentence-level patterns with examples]

### Word-Level Preferences
[Preferred vocabulary, with "I say / AI tends to say" comparisons]

## Hard Bans
[Zero-tolerance list, each with a brief reason]

## Registers

### [Register 1]
[Context, differences, constants]

### [Register 2]
[Context, differences, constants]

## Voice Tests
[Your 2-3 tests, each with a clear pass/fail criterion]
```

Include examples from your actual writing wherever you can. The more examples the AI has to pattern-match against, the better it will reproduce your voice.

## Where to Put It

For a voice profile that applies across all your projects:

```
~/.claude/shared/voice-core.md
```

For a project-specific voice (a brand voice, a product voice):

```
[project-root]/docs/voice-profile.md
```

Then point to it in your word-smithy config:

```yaml
voice:
  - ~/.claude/shared/voice-core.md        # shared
  - docs/voice-profile.md                 # project-specific
```

Both layers load together. If they conflict, the project-level voice wins for that project.

## Iteration

Your first voice profile won't be perfect. That's fine. Use it for a week, notice where the AI still sounds wrong, and update the profile. The most useful additions come from catching specific failures: "It keeps using 'furthermore' even though I banned formal transitions. Let me add that to the hard bans list."

The profile is a living document. Update it when you notice a pattern you hadn't captured, or when your voice evolves. The goal isn't a perfect document on day one. The goal is a document that gets better every time you use it.
