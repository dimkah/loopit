---
name: loopitauto
description: Use when the user explicitly invokes /loopitauto to execute an approved implementation plan autonomously with Superpowers subagents.
---

# Loopit Auto

## Overview

`/loopitauto` is a shortcut for autonomous plan execution. It routes to Superpowers subagent-driven development and final verification.

## Required Dependency

This workflow requires Superpowers. Before executing:

- In Claude Code, Superpowers is available when skills such as `superpowers:writing-plans` or `superpowers:subagent-driven-development` can be invoked.
- In Codex, Superpowers is available when `~/.agents/skills/superpowers` exists and contains `subagent-driven-development/SKILL.md`.

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

After setup, tell the user to restart the agent session and invoke `/loopitauto` again.

## Workflow

1. Find the approved implementation plan from `$ARGUMENTS` or the current conversation.
2. If no approved plan exists, use `superpowers:writing-plans` first.
3. Execute the plan through `superpowers:subagent-driven-development`.
4. Before claiming completion, use `superpowers:verification-before-completion`.
5. Finish with `superpowers:finishing-a-development-branch`.

## Rules

- Do not duplicate detailed Superpowers workflow instructions.
- Do not ask for per-chunk approval unless blocked or the plan is ambiguous.
- Respect local repository instructions, especially commit message and verification rules.
- Do not run intrusive full builds unless repository instructions or concrete risk justify them.
- Match the user's language.
