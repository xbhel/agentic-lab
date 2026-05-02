# Open Pull Request

Open a pull request from a source branch to a target branch, using a repository template when available and adding reviewers or assignees when needed.

- MUST use `git diff` to read and analyze changes instead of reading modified files directly

## PR Title Format

`<type>(<scope>)#<workitem>: <short_description>`

Fields are derived from the source branch name, user request, or `git log --oneline {target}..{source}`:

- type: `feat` | `fix` | `chore` | `docs` | `style` | `refactor` | `perf` | `test` | `build` | `ci` | `revert` | `release`
- scope: Optional, area of the codebase affected (e.g., auth, ui, api, config)
- workitem: The work item or issue number
- short_description: Concise summary from commits or user input

## PR Body Template

```markdown
## Summary
<brief summary>
- type: <type>
- workitem: #<workitem>

- <what changed>

## Validation
- ✔️/❌ <tests or checks run>

## Risks
- <known risks or follow-up items>
```

## MCP Servers

| Platform     | Server                             | Server Aliases |
| ------------ | ---------------------------------- | -------------- |
| Azure DevOps | microsoft/azure-devops-mcp         | azure-devops   |
| GitHub       | io.github.github/github-mcp-server | github         |

## CLI Tools

| Tool | Description |
| ---- | ----------- |
| `pull_request.py` | CLI tool to create pull requests for GitHub, Azure DevOps, and GitLab repositories |

**IMPORTANT:** ALWAYS run `uv run python "<skill_dir>/scripts/<tool>" --help` first to see available options.

- skill_dir: absolute path to the skill root
- repo_root: absolute path to the repository root, from `git rev-parse --show-toplevel`

Example usage:

```bash
uv run --with httpx==0.28.1 python "<skill_dir>/scripts/pull_request.py" \
    --title "Add new feature for testing" \
    --description "This PR adds a new feature." \
    --source feat/278052-add-e2e-tracking \
    --target dev \
    --reviewers xbhel allen \
    --assignees allen \
    --workitems 2798156 \
    --is-draft \
    --is-auto-complete \
    --cwd "<repo_root>"
```

## Iron Laws

- MUST strictly follow the PR title and body format for consistency and traceability.
- MUST use repository templates when available to ensure PRs include required information and follow standards.
- MUST report the PR creation success and the assignment failures separately if the PR is created but reviewer/assignee assignment partially fails.

## Workflow

1. Resolve `source`, `target`, `reviewers`, and `assignees` from the request and context
2. Run `git log --oneline {target}..{source}` to retrieve commit history and generate the PR title using the format defined above
3. Check *.github/* for available PR templates; if multiple exist, prompt the user to select one. If none are found, fall back to the PR Body Template defined above
4. Populate the selected template using commit history and user context to generate the PR body
5. Create the PR using the MCP server listed in MCP Servers above. If no matching MCP server is available, or if the user explicitly requests CLI usage, use appropriate tool from CLI Tools above instead
6. After PR creation, add the specified `reviewers` and `assignees` to the PR

## Output

- PR URL, title, and target branch
- Reviewers and assignees successfully added
