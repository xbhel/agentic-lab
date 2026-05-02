# Worktree

Create and manage multiple working trees attached to the same repository, enabling parallel work on different branches or commits without cloning the repository

## Commands

- Create: `git worktree add <path> <branch|commit>`
- List: `git worktree list`
- Remove: `git worktree remove <path>`
- Prune: `git worktree prune` (removes references to deleted worktrees)
- Enter worktree: `cd <path>`
- Status: `git -C <path> status`
  
## Iron Laws

- MUST ensure each worktree path is unique and does not overlap with others or the main repo
- MUST remove unused worktrees to avoid clutter and confusion
- MUST run git worktree prune regularly to clean stale references
- MUST ensure all changes are committed or safely saved before removing a worktree
- MUST commit and push only from within the corresponding worktree directory

## Workflow

1. Resolve the target branch or commit and the desired worktree path from the request
2. Create the worktree: `git worktree add <path> <branch|commit>`
3. Enter the worktree: `cd <path>`
4. Perform work — make changes, commit, and push from within the worktree
5. Return to the main repo when done: `cd <repo_root>`
6. Remove the worktree: `git worktree remove <path>`
7. Prune stale references: `git worktree prune`

## Output

- Worktree path created
- Active worktrees (`git worktree list`)
- Worktrees removed, if any
