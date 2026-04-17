---
name: gitops
description: Execute common Git actions using consistent conventions. Use this when the request involves standard Git operations such as creating branches, synchronizing, committing or pushing changes, applying or pushing cherry-picks, cleaning up branches, or opening pull requests.
metadata:
  version: 1.0.0
  author: xbhel
---

# Git Operations

## Goal

Execute common Git actions using consistent conventions for branch creation, commits, pushes, cherry-picking, branch cleanup, and pull request creation.

## Action References

See the below reference when it match the user's request:

- [create-branch.md](./references/create-branch.md): Creates a new working branch from a base branch using the shared naming convention
- [commit-and-push.md](./references/commit-and-push.md): Commits changes to the current branch with a descriptive message and pushes to the remote repository
- [cherry-pick.md](./references/cherry-pick.md): Cherry-picks selected commits onto a new branch created from the target branch and pushes it
- [cleanup-branches.md](./references/cleanup-branches.md): Deletes specified branches both locally and remotely to clean up stale branches
- [open-pull-request.md](./references/open-pull-request.md): Opens a pull request from the current branch to a target branch with a descriptive title and body

## Commands

Use the following commands to perform Git operations:

- Get repo URL: `git remote get-url origin`
- Get repo root: `git rev-parse --show-toplevel`
- Get current branch: `git branch --show-current`
- Create a new branch: `git checkout -b <new_branch> origin/<target>`
- Check working tree status: `git status --short`
- Log commits: `git log origin/<target>..HEAD --oneline`
- List changed files: `git diff --name-status origin/<target>..HEAD`
- Inspect changes: `git diff` and `git diff --cached`
- Fetch latest from branch: `git fetch origin <target>`
- Rebase current branch on branch: `git rebase origin/<target>`
- Stash changes: `git stash push -m <message> --include-untracked`
- Restore stashed changes: `git stash pop`
- Add changes to staging: `git add <files>`
- Unstage files: `git restore --staged <files>`
- Commit changes: `git commit -m <subject> -m <body>`
- Push branch without force: `git push origin <target>`
- Push branch (safe force): `git push origin <target> --force-with-lease`
- Switch branch: `git switch <target>`
- Pull latest from branch: `git pull origin <target>`

## Core Principles

- MUST read and follow the selected reference before executing any action
- Prefer using the provided reference commands and conventions for consistency across operations
- MUST execute multiple actions in the required order when the request spans more than one.
- MUST combine consecutive independent commands using `&&` into a single execution to reduce round-trips.
- MUST report failed actions with the command that failed and the error message for reference.

## Workflow

1. Identify the required action from the request.
2. Select the corresponding reference from the Action References above.
3. Read the reference and resolve required inputs.
4. Execute the action following the reference.
5. If multiple actions are requested, repeat the process in order.
