# Xbhel's Agent Workspace

> From zero to agentic: custom AI agents, skill libraries, and MCP workflows in one workspace. 🚀

## Structure

| Directory      | Purpose                                            |
| -------------- | -------------------------------------------------- |
| `agents/`      | Agent definitions that orchestrate multiple skills |
| `skills/`      | Skill definitions and implementations              |
| `mcp_servers/` | MCP server implementations                         |
| `scripts/`     | Utility scripts for testing and maintenance        |

## Setup

### Load the workspace in Copilot

Point `~/.copilot` at this repo so Copilot picks it up automatically.

**Linux/macOS**

```bash
ln -s /path/to/agentic-lab ~/.copilot
```

**Windows (PowerShell)**

```powershell
# Requires Developer Mode or Admin. Use Junction if SymbolicLink is unavailable.
New-Item -ItemType SymbolicLink -Path "$HOME\.copilot" -Target "\path\to\agentic-lab"
# or
New-Item -ItemType Junction -Path "$HOME\.copilot" -Target "\path\to\agentic-lab"
```

### Load skills in Codex

Codex looks for skills at `~/.codex/skills/<skill-name>/SKILL.md`. It does not scan nested folders, so link each directory under `skills/` into `~/.codex/skills`.

**Linux/macOS**

```bash
source="/path/to/agentic-lab/skills"
for dir in "$source"/*/; do
  ln -s "$dir" "$HOME/.codex/skills/$(basename "$dir")"
done
```

**Windows (PowerShell)**

```powershell
$source = "\path\to\agentic-lab\skills"
Get-ChildItem -LiteralPath $source -Directory | ForEach-Object {
  New-Item -ItemType Junction -Path "$HOME\.codex\skills\$($_.Name)" -Target $_.FullName
}
```

> Restart Codex after adding or updating skills.

### Python Environment

This repo uses Python 3.12 and `uv`.

```bash
uv sync
source .venv/bin/activate   # Windows: .venv\Scripts\activate
```

## Skills

- [/analyze](skills/analyze/SKILL.md): Analyze an existing codebase, or a specific area within a codebase, to build a clear, evidence-based understanding of how it works, how its parts interact, and how it can be changed or extended safely.
- [/architect](skills/architect/SKILL.md): Design a clear, extensible, and maintainable architecture proposal with explicit boundaries, responsibilities, integration points, and scalability considerations.
- [/clarify](skills/clarify/SKILL.md): Analyze the user’s requirements, resolve ambiguities, and align intent with existing codebase context when necessary.
- [/decompose](skills/decompose/SKILL.md): Break requirements, features, or work into small, independently executable and verifiable tasks and produce an execution-ready plan with explicit dependencies and parallelism.
- [/gitops](skills/gitops/SKILL.md): Execute common Git actions using consistent conventions for branching, committing, pushing, cleanup, and pull requests.
- [/guide](skills/guide/SKILL.md): Provide a clear, beginner-friendly guide for a topic, focusing on what it is, how it works, and how to get started.
- [/rewrite](skills/rewrite/SKILL.md): Rewrite user requests into clear, natural, and beginner-friendly English.
- [/simplify](skills/simplify/SKILL.md): Simplify and refine existing code for clarity, consistency, and maintainability without changing behavior.
