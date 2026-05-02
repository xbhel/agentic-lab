# Commit and Push Changes

Commit the intended local changes from a working branch, rebase onto the selected base branch, and push the result safely.

## Commit Message Format

**Subject:** `<type>(<scope>)#<workitem>: <short_description>`

**Body:** Detailed description of the change, context, and intent, formatted as a Markdown list.

**Breaking Changes:** MUST append `!` after `type` or `type(scope)` in the subject and include a `BREAKING CHANGE:` footer in the commit body.

Fields:

- type: Inferred from the branch name, changes, or user input. Common values: `feat`, `fix`, `chore`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `revert`, `release`
- scope: Optional, area of the codebase affected (e.g., auth, ui, api, config)
- workitem: Required work item ID. Inferred from the branch name (e.g., feat/1234567_xxx → 1234567); if not found, generate a random 7-digit number
- short_description: Concise summary derived from the work item or change context

Example:

```markdown
Subject: feat(auth)!#1234567: switch to JWT authentication

Body:
Switch authentication from session-based to JWT for improved security and scalability. 
- Replace session-based authentication with JWT 
- Update login flow and token validation 
- BREAKING CHANGE: Clients must send a bearer token instead of session cookies
Workitem: #1234567
```

## Iron Laws

- NEVER commit or push directly to protected branches: `dev`, `main`, `master`, `<base>`
- MUST strictly follow the commit message format above for consistency and traceability
- MUST stop and ask the user to resolve conflicts manually if a conflict cannot be confidently resolved
- MUST stop and report the exact failing step, while preserving the branch state for manual recovery

## Workflow

1. If `target` is protected, **MUST create a new branch** from it using [create-branch](./create-branch.md) and switch to it.
2. Stash any uncommitted or untracked changes to keep the working tree clean for the next step.
3. Fetch the latest `origin/<base>` and rebase the current branch on top of it.
4. Restore the stash if one was created in step 2.
5. Stage and commit any remaining changes using the commit message format defined above.
6. Push the branch using the following command.

    ```bash
    git push origin <current_branch> --force-with-lease || git push origin <current_branch> || git push -u origin <current_branch>
    ```

## Output

- Pushed branch name.
- Commit subject.
- Included commits.
- Summary of changed files.
