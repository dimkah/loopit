# Loopit

Loopit is a tiny convenience layer on top of [Superpowers](https://github.com/obra/superpowers) for Codex and Claude Code. It adds two slash commands for executing implementation plans without retyping the workflow every time.

Unofficial project: Loopit is not affiliated with Superpowers, OpenAI, or Anthropic. It is just a thin wrapper around existing Superpowers workflows.

## Requirements

- [Codex](https://developers.openai.com/codex/) or [Claude Code](https://www.anthropic.com/claude-code)
- [Superpowers](https://github.com/obra/superpowers) — if it is not installed yet, the skills will guide setup for your environment.

## `/loopit`

Use when you want controlled, chunk-by-chunk execution.

Use it instead of "implement this" when you want the agent to pause after each meaningful step, show what changed, and let you steer before it continues.

```text
approved plan
  -> implement next chunk
  -> verify
  -> short report
  -> wait for "ok"
  -> repeat until done
  -> final verification
  -> merge / PR / keep: your explicit choice
```

## `/loopitauto`

Use when the plan is clear and you want to hand execution over to the agent.

Use it when the plan is ready and you do not want to sit next to the agent, but still want it to follow a proper engineering workflow.

```text
approved plan
  -> Superpowers subagent-driven development
  -> per-task review/fix loop
  -> final review
  -> final verification
  -> waits for your merge / PR choice
```

## Examples

`/loopit docs/superpowers/plans/my-feature.md` runs that plan chunk by chunk and waits for approval after each chunk.

`/loopitauto docs/superpowers/plans/my-feature.md` hands that plan to the autonomous Superpowers execution flow.

`/loopit` uses the approved plan already present in the conversation and runs it with human checkpoints.

`/loopitauto` uses the approved plan already present in the conversation and runs it autonomously.

## Install

Clone the repo, then run the helper for your environment:

```bash
# Codex
scripts/install-codex.sh

# Claude Code
scripts/install-claude.sh
```

The helpers symlink `skills/loopit` and `skills/loopitauto` into your agent's skills directory. Restart the agent after installing.

If Superpowers is missing, the skills stop before implementation and guide setup for the current environment.

## Uninstall

Remove the symlinks and restart the agent:

```bash
rm -f ~/.codex/skills/loopit ~/.codex/skills/loopitauto
rm -f ~/.claude/skills/loopit ~/.claude/skills/loopitauto
```

## Contributing

Keep Loopit a thin wrapper over Superpowers. Prefer small improvements that clarify routing, installation, or safety without copying Superpowers workflows into this repo.

## License

MIT
