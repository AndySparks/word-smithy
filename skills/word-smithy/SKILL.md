---
name: word-smithy
description: >
  Universal editorial skill. Use when writing anything: blog posts, emails, social media,
  card content, or any prose. Routes to the right editorial workflow based on what you're
  working on. Discovers voice docs, writing references, and editorial protocols from shared
  and project configs. Also detects existing writing context in AGENTS.md, CLAUDE.md,
  .cursorrules, and other tool configs. Invoke for any writing task, even if you're unsure
  which process to follow. Triggers: write, draft, edit, polish, publish, blog, email,
  social, card, essay, dispatch, copy, prose, editorial, voice check, McPhee Loop.
license: MIT
metadata:
  author: andysparks
  version: "1.0"
---

# /word-smithy

The editorial workshop. One entry point for all writing workflows.

## When Invoked

### Step 1: Load Baseline Context

Read the shared config and project config (if present) to discover all available resources.

**Shared config locations to check, in order:**
- `~/.agents/word-smithy/config.md`
- `~/.claude/shared/word-smithy/config.md`

Use the first one that exists.

**Project config location:** `.word-smithy/config.md` in the current project root

From each config, load:
- **Voice docs** (always loaded, governs all writing)
- **Principles docs** (always loaded, governs all writing)

Do NOT load references or protocol bodies yet. Those are loaded on demand.

### Step 1b: Discover Existing Writing Context

Scan for writing-related context that exists outside word-smithy's own configs:

- `AGENTS.md` in the project root (look for voice, style, tone, or writing sections)
- `~/.agents/AGENTS.md` (global rules for AGENTS-based harnesses)
- `CLAUDE.md` in the project root (look for voice, style, tone, or writing sections)
- `.claude/rules/` files that mention writing, voice, editorial, or style
- `~/.claude/CLAUDE.md` (global rules)
- `.cursorrules` or `.github/copilot-instructions.md` (for Cursor/Copilot users)

If any are found, acknowledge them:

> I found existing writing context in:
> - [list files found]
>
> I'll use these alongside word-smithy's configs. If anything conflicts, your project-level rules win.

This ensures word-smithy layers on top of what the user already has rather than replacing it. Users do not need to migrate existing rules into word-smithy's format for them to be respected.

### Step 1c: First-Run Check

After loading configs and discovering context, check whether anything meaningful was found. Specifically:

1. Do the `voice` paths in the config(s) point to files that actually exist?
2. Was any writing context discovered in Step 1b (AGENTS.md, CLAUDE.md, .cursorrules, etc.)?

**If no voice file exists AND no external writing context was found**, the user has nothing loaded. Enter onboarding mode instead of proceeding to Step 2.

**If a voice file exists** (or meaningful writing context was found in Step 1b), skip onboarding and proceed to Step 2.

### Step 1d: Onboarding (first-run only)

When onboarding is triggered, walk the user through creating a minimal voice profile. Don't send them to the guide. Do it here, interactively.

Say:

> word-smithy is installed, but you don't have a voice profile yet. That's the thing that keeps your AI from sounding like a robot.
>
> Want to set one up now? Takes about five minutes.

If the user says no, proceed to Step 2 with no voice loaded (the skill still works, just without voice guardrails).

If the user says yes, walk through these four steps:

**1. Collect samples**

> Paste 2-3 short pieces of writing you're proud of. Emails, blog posts, social posts, anything. I need to hear what you sound like.

Read what they provide. Identify patterns: sentence length habits, vocabulary preferences, structural tendencies, tone.

**2. Confirm the patterns**

Present what you found:

> Here's what I'm noticing in your writing:
> - [structural pattern, e.g., "You lead with the problem, not the solution"]
> - [sentence pattern, e.g., "Short sentences mixed with longer ones, lots of contractions"]
> - [vocabulary pattern, e.g., "Plain words, no jargon"]
>
> Does that sound right? Anything I'm missing?

Let them correct or add. This is collaborative, not prescriptive.

**3. Hard bans**

> What words or phrases do you never want to see in your writing? Things that make you cringe when AI produces them.
>
> Common ones people ban: "leverage," "utilize," "Furthermore," "It's worth noting," "It's not X. It's Y."

Collect their list.

**4. Save the profile**

Write the voice profile to the shared voice path from their config.

If no shared config exists yet:
- In AGENTS-based harnesses, create `~/.agents/word-smithy/config.md` and save the voice profile to `~/.agents/voice-core.md`.
- In Claude Code, create `~/.claude/shared/word-smithy/config.md` and save the voice profile to `~/.claude/shared/voice-core.md`.
- If you cannot tell which harness the user is using, ask one short question before saving anything.

When creating a new shared config during onboarding, make sure it points to the voice file you just saved so future `/word-smithy` invocations discover it automatically.

Use the structure from the [Creating a Voice Profile](guides/creating-a-voice-profile.md) guide. Confirm:

> Saved your voice profile to `[path]`. It's loaded now and will be loaded every time you invoke `/word-smithy`.
>
> This is a living document. Next time something sounds off, tell me and I'll update it.

Then proceed to Step 2.

**After onboarding, offer next steps (don't block on them):**

> Your voice profile is set. Two optional things when you have time:
> - **Condense a writing book** you love into an AI reference (see `guides/condensing-a-book.md`)
> - **Write a protocol** for a workflow you repeat (see `guides/writing-a-protocol.md`)
>
> For now, let's write something.

### Step 2: Ask the Question

Ask the user:

> What are you working on?

Wait for a plain-text answer. No menu, no numbered options.

### Step 3: Match Intent to Protocol

Scan all protocol paths from both configs (shared + project). For each `.md` file found:
1. Read the YAML frontmatter
2. Check for `name`, `triggers`, and `description` fields
3. If a file lacks these fields, skip it (it is not a word-smithy protocol)

Match the user's answer against the `triggers` field of all discovered protocols. Use semantic matching, not exact string matching. The `triggers` field contains representative phrases, not an exhaustive list.

**If a match is found:**
> Looks like **[protocol name]**. [description]
>
> Running it.

Then load the full protocol file and any files listed in its `loads` field. Walk through the protocol step by step.

**If no match is found:**
> I don't have a protocol for that yet. Two options:
>
> 1. **Create one** (I'll help you write a protocol doc for this workflow)
> 2. **Just write** (I'll work with voice and principles loaded, no formal process)

If the user chooses "just write," proceed with voice + principles as guardrails. This is still better than writing without `/word-smithy` because the baseline context is active.

If the user chooses "create one," guide them through writing a new protocol doc:
- Ask what the workflow involves
- Ask where it should live (shared or project)
- Draft the protocol with proper frontmatter
- Save it to the appropriate directory
- It is immediately available for future `/word-smithy` invocations

### Step 4: Execute Protocol

When running a matched protocol:
1. The full protocol document is the process. Follow it step by step.
2. Load files from the `loads` field only when a step references them, not all at once.
3. Voice + principles stay loaded throughout as guardrails.
4. If a protocol references another protocol (e.g., BPP calls the McPhee Loop), discover and load that protocol when the step calls for it.

### Step 5: "Just Write" Fallback

When no protocol matched and the user chose to freestyle:
1. Voice core + any project voice profile are active.
2. Principles (if any) are active.
3. Writing references are available on request but not pre-loaded.
4. Apply the voice tests from voice-core.md to any draft before presenting it.

## Cross-Layer Rules

- Shared protocols never reference project protocols.
- Project protocols can reference shared protocols and shared references.
- If a project protocol and shared protocol have overlapping triggers, the project protocol wins.
- Voice and principles from both layers are always loaded together.

## Protocol Doc Format

For creating new protocol docs, use this frontmatter template:

```yaml
---
name: [Human-Readable Name]
triggers: [comma-separated phrases that describe when to use this]
description: [One-line description shown when confirming the match]
layer: [shared or project]
loads:
  - [paths to reference files this protocol needs]
---
```

The body of the protocol is the workflow itself. Write it however makes sense for the process. The skill reads and follows it as instructions.
