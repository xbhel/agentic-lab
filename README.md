# Xbhel's Skills

> A skill-first workspace for Coding Agents, with shared agent conventions, reusable prompt skills, and local setup helpers. 🚀

## 🧭 Overview

This repository is the source of truth for a personal AI skill library. It keeps skill definitions, supporting references, and workspace instructions in one place so the same workflows can be reused across tools.

## ✨ What It Provides

- A shared skill library under `skills/`
- Workspace conventions in `AGENTS.md`, `CLAUDE.md`, and `copilot-instructions.md`
- A helper script for linking skills into local tool directories
- A Python environment for running helper scripts when needed

## 🗂️ Structure

| Path | Purpose |
| --- | --- |
| `skills/` | Skill definitions, references, and helper scripts |
| `scripts/` | Utility scripts such as `load-skills.ps1` |
| `AGENTS.md` | Shared authoring and workflow rules |
| `CLAUDE.md` | Claude-facing instruction entry point |
| `copilot-instructions.md` | Copilot-facing instruction entry point                |
| `pyproject.toml`          | Python environment and tool configuration             |

## ⚙️ Setup

### Load the workspace in Copilot

Point `~/.copilot` at this repo so Copilot can load the workspace instructions and local skills.

**Linux/macOS**

```bash
ln -s /path/to/agentic-lab ~/.copilot
```

**Windows (PowerShell)**

```powershell
# Requires Developer Mode or Admin. Use Junction if SymbolicLink is unavailable.
New-Item -ItemType SymbolicLink -Path "$HOME\.copilot" -Target "C:\path\to\agentic-lab"
# or
New-Item -ItemType Junction -Path "$HOME\.copilot" -Target "C:\path\to\agentic-lab"
```

### Load skills in Codex

Codex looks for skills at `~/.codex/skills/<skill-name>/SKILL.md`. It does not scan nested folders, so each skill directory must be linked into `~/.codex/skills`.

**Linux/macOS**

```bash
source="/path/to/agentic-lab/skills"
for dir in "$source"/*/; do
  ln -s "$dir" "$HOME/.codex/skills/$(basename "$dir")"
done
```

**Windows (PowerShell)**

```powershell
.\scripts\load-skills.ps1 -DestinationRoot codex
```

You can also sync skills for both Codex and Copilot with one command:

```powershell
.\scripts\load-skills.ps1 -DestinationRoot codex,copilot
```

> Restart Codex after adding or updating skills.

### Python Environment

This repo uses Python 3.12 and `uv`.

```bash
uv sync
source .venv/bin/activate   # Windows: .venv\Scripts\activate
```

## 💬 Usage

After the workspace or skills are linked, invoke a skill directly in chat with its slash command. Examples:

- `/clarify` for requirement clarification
- `/document` for engineering documentation
- `/review` for code review

Each skill lives in `skills/<skill-name>/SKILL.md`, and many skills also include supporting reference files in a local `references/` directory.

## Development Workflow

1. Edit the relevant skill in `skills/<skill-name>/SKILL.md`.
2. Update any supporting references or scripts in the same skill directory.
3. Keep the skills list in this README synchronized with the actual `skills/` directory.
4. Re-run `./scripts/load-skills.ps1 -DestinationRoot codex,copilot` on Windows if you need to refresh linked skills locally.

## 🧩 Skills

- [/analyze](skills/analyze/SKILL.md): Build an evidence-based understanding of a codebase or feature area before changing it.
- [/architect](skills/architect/SKILL.md): Design a clear, maintainable architecture proposal with explicit boundaries and trade-offs.
- [/clarify](skills/clarify/SKILL.md): Turn incomplete or ambiguous requirements into a structured, codebase-aware specification.
- [/decompose](skills/decompose/SKILL.md): Break work into small tasks and produce a dependency-aware execution plan.
- [/develop](skills/develop/SKILL.md): Orchestrate end-to-end feature delivery from clarification through implementation and handoff.
- [/digest](skills/digest/SKILL.md): Summarize links and organize the results into a readable index.
- [/document](skills/document/SKILL.md): Create structured engineering documentation such as drafts, specs, designs, ADRs, guides, quickstarts, and READMEs.
- [/gitops](skills/gitops/SKILL.md): Perform common Git workflows with shared conventions for branching, syncing, and pull requests.
- [/polish](skills/polish/SKILL.md): Rewrite user requests into clear, natural, beginner-friendly English.
- [/review](skills/review/SKILL.md): Review code changes for bugs, regressions, coverage gaps, and design risk.
- [/simplify](skills/simplify/SKILL.md): Improve code clarity and maintainability without changing behavior.
- [/summarize](skills/summarize/SKILL.md): Synthesize information from various sources into a concise and coherent summary that captures the essential points, insights, or decisions.
- [/tdd](skills/tdd/SKILL.md): Drive implementation with a failing test first, then follow red-green-refactor.
- [/test](skills/test/SKILL.md): Add, fix, run, and report tests to improve confidence in code behavior.
- [/vocab](skills/vocab/SKILL.md): Explain English vocabulary with pronunciation, meanings, phrases, and examples for learners.

## 📚 Related Documentation

- [AGENTS.md](AGENTS.md): shared rules for skill authoring and workflow behavior
- [CLAUDE.md](CLAUDE.md): Claude-facing instruction entry point
- [copilot-instructions.md](copilot-instructions.md): Copilot-facing instruction entry point

## 🤝 Contribution Notes

- Follow the structure and conventions defined in `AGENTS.md` when editing or adding skills.
- Keep documentation in English.
- Keep the `README.md` skills list synchronized with the contents of `skills/`.
