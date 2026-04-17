# Cherry-pick and Push Changes

Cherry-pick selected commits from a source branch onto a new working branch created from the target branch, then push the result.

- Cherry-pick commits: `git cherry-pick <commit>...`
- Cherry-pick control: `git cherry-pick --abort | --continue | --skip`
- Filter commits: `git log --oneline origin/<target> [--grep="<keyword>"] [--author="<name>"] [--after="<date>"] [--before="<date>"]`

## Core Principles

- MUST stop and ask the user to resolve conflicts manually if a conflict cannot be confidently resolved

## Workflow

1. Resolve the `source` and `target` branches from the request and current context
2. Identify commits to cherry-pick:
   - If explicit SHAs are provided, use them directly
   - If not, infer commits using filters (keyword, author, date range, or combinations) on `source`
   - If ambiguous, request user clarification
3. List matched commits and confirm with user before proceeding
4. Switch to `target` and pull latest changes
5. Create a new working branch from `target` using [create-branch](./create-branch.md) and switch to it
6. Cherry-pick the selected commits onto the working branch
7. Push the working branch with `git push -u origin <working_branch>`

## Output

- Working branch name.
- Cherry-picked commit list.
- Summary of changed files.
