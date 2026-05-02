# Worktree

Create and manage additional working trees for the same repository so work can continue on multiple branches or commits without cloning.

## Commands

- Create from existing branch: `git worktree add <path> <branch>`
- Create new branch from base: `git worktree add -b <new_branch> <path> <base>`
- List: `git worktree list`
- Check status: `git -C <path> status --short`
- Remove: `git worktree remove <path>`
- Prune stale metadata: `git worktree prune`
  
## Iron Laws

- MUST ensure the requested path is unique and does not overlap with the main repo or other worktrees
- MUST request a different branch or path if the target branch is already checked out in another worktree
- MUST fail early if the target branch, base branch, or commit does not exist
- MUST ensure all changes are committed, stashed, or safely preserved before removing a worktree
- MUST commit and push only from within the corresponding worktree directory

## Workflow

1. Resolve the target path and whether to use an existing branch or create a new branch from a base
   - If a new branch is needed, use [create-branch](./create-branch.md) to create it.
2. Use `.wt/<branch>` as the standard worktree path format
3. Run `git worktree list` to inspect current worktrees and avoid path or branch conflicts
4. Create the worktree using the appropriate command from the Commands section
5. Enter the worktree directory and  run `git status` to verify it is correctly set up
6. Set up the worktree for development (e.g., install dependencies, configure environment) before starting work
7. When cleanup is requested, remove the worktree and run `git worktree prune`

## Output

- Worktree path and branch created
- Active worktrees (`git worktree list`)
- Worktrees removed, if any
