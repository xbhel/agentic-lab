# Rebase

Rebase the current branch onto a target branch to incorporate the latest changes and maintain a linear history.

- Rebase: `git rebase origin/<target>`
- Interactive rebase: `git rebase -i origin/<target>`
- Rebase control: `git rebase --abort | --continue | --skip`
- Force push after rebase: `git push origin <branch> --force-with-lease`

## Iron Laws

- NEVER rebase directly on protected branches: `dev`, `main`, `master`
- MUST stop and ask the user to resolve conflicts manually if a conflict cannot be confidently resolved
- MUST use `--force-with-lease` (never `--force`) when pushing after a rebase
- MUST stop and report the exact failing step, preserving the branch state for manual recovery

## Workflow

1. Resolve the `target` branch to rebase onto from the request or current context
2. Fetch the latest state of `target`: `git fetch origin <target>`
3. Rebase the current branch: `git rebase origin/<target>`
4. If conflicts occur, stop and ask the user to resolve them manually
5. After conflicts are resolved, continue: `git rebase --continue`
6. Push the rebased branch: `git push origin <branch> --force-with-lease`

## Output

- Rebased branch name
- Target branch rebased onto
- Summary of any conflicts encountered
