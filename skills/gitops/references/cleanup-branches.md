# Cleanup Branches

Remove local branches and optionally remote branches that are no longer needed, excluding protected branches.

- Protected branches: `dev`, `main`, `master`
- Remote deletion: `git push origin --delete <branch>`

## Iron Laws

- MUST re-confirm with the user before deleting any protected branch
- MUST report any failed local or remote deletions and retain them for manual review
- MUST switch to a safe branch before deleting the currently checked-out branch, and proceed only after user confirmation

## Workflow

1. Resolve target branches or matching pattern, and determine whether remote cleanup is requested
2. Fetch latest remote branch state from origin
3. Identify local branches matching the cleanup criteria
4. Identify corresponding remote branches if remote cleanup is enabled
5. Exclude all protected branches from deletion
6. Delete remaining matched branches locally and optionally remotely

## Output

- Local branches removed
- Remote branches removed
- Skipped protected branches
