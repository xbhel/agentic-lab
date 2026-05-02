# Open Pull Request

Open a pull request from a source branch to a target branch, using a repository template when available and adding reviewers or assignees when needed.

## PR Title Format

`<type>(<scope>)#<workitem>: <short_description>`

Fields are derived from the source branch name, user request, or `git log --oneline {target}..{source}`:

- type: `feat` | `fix` | `chore` | `docs` | `style` | `refactor` | `perf` | `test` | `build` | `ci` | `revert` | `release`
- scope: Optional, area of the codebase affected (e.g., auth, ui, api, config)
- workitem: The work item or issue number
- short_description: Concise summary from commits or user input

## PR Body Template

MUST first check the repository for PR templates (e.g., `.github/pull_request_template.md`); if multiple exist, prompt the user to select one.

Only if no repository-level template exists at all, use the default template at [assets/pull-request-template.md](../assets/pull-request-template.md).

## MCP Servers

| Platform     | Server                             | Server Aliases |
| ------------ | ---------------------------------- | -------------- |
| Azure DevOps | microsoft/azure-devops-mcp         | azure-devops   |
| GitHub       | io.github.github/github-mcp-server | github         |

## CLI Tools

| Platform     | CLI |
| ------------ | --- |
| Azure DevOps | az  |
| GitHub       | gh  |

**IMPORTANT:** ALWAYS run CLI with `--help` first to see available options. For example, `gh pr create --help` or `az repos pr create --help`.

## Iron Laws

- MUST strictly follow the PR title and body format for consistency and traceability
- MUST use repository templates when available to ensure PRs include required information and follow standards
- MUST report the PR creation success and the assignment failures separately if the PR is created but reviewer/assignee assignment partially fails
- MUST stop and report when neither an MCP server nor a CLI tool is available for the target repository

## Workflow

1. Resolve `source`, `target`, `reviewers`, and `assignees` from the request and context
2. Run `git log --oneline {target}..{source}` to retrieve commit history and generate the PR title using the format defined above
3. Populate the selected PR template using commit history and user context to generate the PR body
4. Create the PR using the MCP server listed in MCP Servers above. If no matching MCP server is available, use appropriate tool from CLI Tools above instead
5. After PR creation, add the specified `reviewers` and `assignees` to the PR

## Output

- PR URL, title, and target branch
- Reviewers and assignees successfully added
