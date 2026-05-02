# Rebase

Rebase the current branch onto a target branch to incorporate the latest changes and maintain a linear history.

- Rebase: `git rebase origin/<target>`
- Interactive rebase: `git rebase -i origin/<target>`
- Rebase control: `git rebase --abort | --continue | --skip`

## Iron Laws

- NEVER rebase directly on protected branches: `dev`, `main`, `master`
- MUST stop and report the exact failing step, preserving the branch state for manual recovery

## Workflow

1. Resolve the `target` branch to rebase onto from the request or current context
2. Fetch the latest state of `target`: `git fetch origin <target>`
3. Rebase the current branch: `git rebase origin/<target>`
4. If conflicts occur, stop and ask the user to resolve them manually if they cannot be confidently resolved
5. After conflicts are resolved, continue: `git rebase --continue`

## Output

- Rebased branch name
- Target branch rebased onto
- Summary of any conflicts encountered
