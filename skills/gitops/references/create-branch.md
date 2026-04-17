# Create Branch

Create a new working branch from the correct base branch using the shared branch naming convention.

## Branch Name Format

`<type>/<workitem>_<descriptive_name>`:

- type: Inferred from the request or context. Common values:
  - `feat`: new features or significant changes
  - `fix`: bug fixes or minor improvements
  - `chore`: maintenance or non-functional changes
  - `docs`: documentation only
  - `style`: formatting/style changes
  - `refactor`: code restructuring without behavior change
  - `perf`: performance improvements
  - `test`: adding or updating tests
  - `build`: changes to build process or dependencies
  - `ci`: CI/CD pipeline changes
  - `revert`: reverting a previous commit
  - `release`: changes related to versioning or releases
- descriptive_name: Concise hyphen-separated summary of the change (max 20 characters), derived from the work item or request.
- workitem: The work item number associated with the change, inferred from context or request; if unavailable, generate a random 7-digit number.

Example: `feat/1234578_add-user-auth`

## Core Principles

- MUST stop and ask whether to reuse the branch or create a different name if the branch already exists.
- MUST stop and report the failure if `base` cannot be fetched or does not exist on origin.

## Workflow

1. Resolve `base`, `type`, `workitem`, and `descriptive_name` from the request or current context.
2. Fetch the latest `origin/<base>`.
3. Normalize `descriptive_name` to a concise, hyphen-separated slug (max 20 characters).
4. Create the branch using the format defined above from `base` and switch to it.

## Output

- Created branch name and base branch used
