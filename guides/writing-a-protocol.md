# Writing a Protocol

A protocol is a repeatable writing workflow that word-smithy can discover and run. You describe the process once in a markdown file, and from then on, word-smithy matches it to your request and walks through it step by step.

You don't need protocols to use word-smithy. Without them, it still loads your voice profile and principles, then writes freestyle. But protocols give you consistency. The third time you find yourself saying "do the same thing you did last time," that's when you write a protocol.

## The Format

Every protocol is a markdown file with YAML frontmatter:

```yaml
---
name: Blog Post Polish
triggers: polish blog post, final pass, blog cleanup, proofread post
description: Three-pass polish for a blog post before publishing
layer: shared
loads:
  - [shared-root]/writing-references/zinsser.md
---
```

The fields:

- **name**: What you'd call this workflow if someone asked. Human-readable.
- **triggers**: Comma-separated phrases that describe when to use this protocol. word-smithy matches your request against these phrases semantically, so they don't need to be exhaustive. Think of them as representative examples.
- **description**: One line shown when word-smithy confirms the match. Tells you what you're about to run.
- **layer**: Either `shared` (available across all projects) or `project` (only available in the current project).
- **loads**: Paths to reference files this protocol needs. These are loaded when the protocol runs, not before.

The body of the file is the workflow itself. Write it however makes sense for the process. word-smithy reads it and follows it as instructions.

## Where Protocols Live

**Shared protocols** live in a directory you point to from your shared config. Common shared config locations are `~/.agents/word-smithy/config.md` and `~/.claude/shared/word-smithy/config.md`. These are available in every project. Good candidates: your blog polish process, your email editing checklist, your social media workflow.

**Project protocols** live in a directory you point to from your project config (`.word-smithy/config.md`). These only load when you're working inside that project. Good candidates: a card-writing process specific to your product, a release notes workflow, a docs style guide.

The rule: if you'd use it across multiple projects, make it shared. If it only makes sense in one project, make it project-level.

## Three Examples

### Simple: a voice check

The simplest useful protocol. Three checks, no reference files.

```yaml
---
name: Voice Check
triggers: voice check, does this sound like me, voice test
description: Quick three-question voice test against your profile
layer: shared
loads: []
---

# Voice Check

Read the draft and answer three questions:

1. Does this sound like it was written by a person or a machine?
   If machine: identify the sentences that feel generic and rewrite them.

2. Would you say this to a friend over coffee?
   If not: the register is too formal. Dial it back.

3. Is there a single line that makes you cringe?
   If yes: cut it. Don't fix it. Cut it.
```

### Medium: a multi-pass edit

A structured editing process with reference material loaded.

```yaml
---
name: Blog Post Polish
triggers: polish blog post, final pass, blog cleanup, proofread post
description: Three-pass polish for a blog post before publishing
layer: shared
loads:
  - [shared-root]/writing-references/zinsser.md
---

# Blog Post Polish

## Pass 1: Clarity (with Zinsser loaded)

Read start to finish. For each paragraph:
- Does this paragraph earn its place?
- Is the main point clear in the first sentence?
- Are there words to cut?

Apply the Zinsser reference: strip clutter, use active verbs, cut qualifiers.

## Pass 2: Flow

Read aloud. Listen for:
- Sentences that all sound the same length
- Mechanical transitions ("Furthermore," "Additionally")
- Places where the energy drops

## Pass 3: Voice

Run your voice tests. Ask:
- Does this sound like me or like a robot?
- Would I say this to a friend?
- Is there a line that makes me cringe?
```

### Complex: an end-to-end creation workflow

A full process that spans multiple phases and loads different references at different steps.

```yaml
---
name: Long-Form Draft
triggers: write a post, draft a piece, long-form writing, write an essay
description: Full drafting workflow from outline through polish
layer: shared
loads:
  - [shared-root]/writing-references/mcphee.md
  - [shared-root]/writing-references/zinsser.md
---

# Long-Form Draft

## Phase 1: Structure (load McPhee reference)

Before writing a single paragraph:
- What is the one thing this piece is about?
- What are the 3-5 sections that build toward that point?
- What is the opening image or scene?
- What is the closing line?

Use McPhee's structural thinking: the piece needs a shape,
not just a sequence.

## Phase 2: Draft

Write the full draft without stopping to edit. Voice profile
is loaded and active. Don't polish. Get it down.

Rules for this phase:
- No going back to fix earlier sections
- Skip transitions (add them in Phase 3)
- If you get stuck, leave a [TODO] marker and move on

## Phase 3: Polish (load Zinsser reference)

Run the blog polish protocol on the finished draft.
Apply Zinsser's principles: cut clutter, strengthen verbs,
remove qualifiers.

## Phase 4: Voice Check

Run the voice check protocol. If it doesn't pass, fix
the specific sentences that fail.
```

## How word-smithy Discovers Protocols

When you invoke `/word-smithy`, it scans every `.md` file in the protocol directories listed in your configs (both shared and project). For each file, it reads the YAML frontmatter and looks for the `name`, `triggers`, and `description` fields. Files without these fields are skipped.

When you describe what you're working on, word-smithy matches your description against the `triggers` fields using semantic matching. It doesn't need an exact string match. "Can you clean up this blog post?" would match a protocol with triggers like "polish blog post, blog cleanup."

If a project protocol and a shared protocol have overlapping triggers, the project protocol wins.

## When You Don't Need a Protocol

If you're doing something for the first time, or something you'll only do once, skip the protocol. Just tell word-smithy what you're working on and choose "just write." Your voice and principles are still active. Protocols are for the workflows you repeat.

The threshold: if you've done it three times and you're going to do it again, write a protocol. If you've done it once, don't bother yet.
