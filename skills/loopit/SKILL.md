---
name: loopit
description: Use when the user explicitly invokes /loopit to execute an approved implementation plan with human review after each task or chunk.
---

# Loopit

## Overview

`/loopit` is a shortcut for human-reviewed plan execution. It routes to the existing Superpowers workflows instead of redefining them.

## Required Dependency

This workflow requires Superpowers. Before executing:

- In Claude Code, Superpowers is available when skills such as `superpowers:writing-plans` or `superpowers:executing-plans` can be invoked.
- In Codex, Superpowers is available when `~/.agents/skills/superpowers` exists and contains `executing-plans/SKILL.md`.

If Superpowers is missing, stop before implementation and guide setup for the current environment. Do not run network or plugin installation commands without user approval.

For Claude Code:

```text
/plugin install superpowers@claude-plugins-official
```

If the official marketplace is unavailable:

```text
/plugin marketplace add obra/superpowers-marketplace
/plugin install superpowers@superpowers-marketplace
```

For Codex:

```bash
git clone https://github.com/obra/superpowers.git ~/.codex/superpowers
mkdir -p ~/.agents/skills
ln -s ~/.codex/superpowers/skills ~/.agents/skills/superpowers
```

For Codex subagent workflows, also ensure `~/.codex/config.toml` contains:

```toml
[features]
multi_agent = true
```

After setup, tell the user to restart the agent session and invoke `/loopit` again.

## Workflow

1. Find the approved implementation plan from `$ARGUMENTS` or the current conversation.
2. If no approved plan exists, use `superpowers:writing-plans` first.
3. Execute the plan through `superpowers:executing-plans`.
4. Override the interaction style: stop after each task or coherent chunk.
5. Report briefly what changed, what verification ran, and any blocker or risk.
6. Wait for user approval before continuing.
7. Before claiming completion, use `superpowers:verification-before-completion`.
8. Finish through `superpowers:finishing-a-development-branch`: present its options and wait for the user's explicit choice.

## Rules

- Do not duplicate detailed Superpowers workflow instructions.
- Do not continue past a chunk until the user approves.
- Stay in `superpowers:executing-plans` even where it recommends switching to `superpowers:subagent-driven-development`. Human checkpoints are the point of `/loopit`; autonomous execution is `/loopitauto`.
- Never merge, push, open a PR, or delete a branch without an explicit user choice from the finishing options. Chunk approval — including "ok" or "finish up" on the last chunk — approves that chunk only; it does not select an integration option the user has not seen. After the options are presented, a reply that does not name a specific option is not a choice — ask again.
- Respect local repository instructions, especially commit message and verification rules.
- Do not run intrusive full builds unless repository instructions or concrete risk justify them.
- Match the user's language.
