---
name: review
description: Review code changes for correctness, regressions, requirement coverage, test quality, design alignment, and delivery risk. Use this when asked to review a change, pull request, diff, commit, patch, or implementation, and provide prioritized findings with concrete evidence and a clear verdict.
argument-hint: changes or features to review
metadata:
  version: 1.1.0
  author: xbhel
---

# Review

## Goal

Produce an evidence-based review of a change, prioritizing correctness, regressions, requirement gaps, design drift, and validation gaps over style feedback.

See [review-checklist.md](./references/review-checklist.md) for a detailed checklist and template for performing comprehensive code reviews when needed.

## Core Principles

- MUST ask for the minimal missing locator (e.g., PR number, diff, or file set) if the review target cannot be identified.
- MUST review the actual diff when available and read surrounding code as needed to verify behavior
- MUST infer cautiously when requirements are missing and explicitly state any uncertainty
- MUST stay strictly scoped to the requested review target, ignoring unrelated local changes
- MUST treat code review as a validation task, not an editing task, unless explicitly asked for fixes
- MUST review behavior, not just syntax, by tracing execution paths and side effects
- MUST prioritize correctness, security, regressions, requirement gaps, data loss, concurrency issues, and missing validation over style feedback
- MUST support every finding with concrete evidence (e.g., file, symbol, code path, test, or command result)
- MUST distinguish confirmed facts from inference when it affects confidence or conclusions
- MUST continue with static review when runtime validation (tests, lint, build) is unavailable
- MUST mark the review as partial and flag affected findings as unverified risks when validation is not executed
- MUST treat missing tests or validation as findings when behavior or risk is unverified
- MUST split large reviews by subsystem and prioritize highest-risk areas first
- MUST keep the review proportional to the size and risk of the change
- MUST present findings before any summary or verdict
- MUST report validation gaps explicitly and any uncertainty
- MUST label pre-existing issues clearly and MUST NOT block the change unless they materially affect it
- NEVER treat stylistic preference as a blocking issue
- NEVER lead with compliments, generic summaries, or stylistic commentary
- NEVER invent requirements, expected behavior, or design intent without evidence
- NEVER include speculative, low-confidence, or low-value findings


## Workflow

### Step 1. Frame the Review

- Identify the exact review target: PR, diff, commit range, files, or local changes
- Confirm the intended scope from requirements or context when available
- Infer the narrowest safe scope from repository state and user context when the target is ambiguous

### Step 2. Gather Context

- Read the changed files and the nearby code needed to understand execution paths
- Review related tests, fixtures, and build or validation commands relevant to the touched area
- Look for reference implementations or existing patterns that the change should match
- Use surrounding code to recover missing requirements when possible

### Step 3. Check Requirement Coverage

- Verify that the change satisfies the known requirements and acceptance criteria from requirements
- Flag missing behavior, partial implementations, and scope drift
- Report ambiguous behavior as a risk when evidence is insufficient
- Do not invent a requirement to make the review sound complete

### Step 4. Check Correctness and Regression Risk

- Trace the main execution paths affected by the change
- Check validation, error handling, boundary conditions, state transitions, side effects, retries, cleanup, and failure behavior
- Check for these common regression classes:
  - incorrect branching or missing guards
  - stale assumptions about inputs, nullability, or data shape
  - broken compatibility with existing callers or contracts
  - race conditions, duplicate work, ordering bugs, or idempotency gaps
  - security, authorization, or secrets-handling mistakes
  - performance regressions: algorithmic complexity changes, N+1 queries, hot-path inefficiencies, or unnecessary allocations
  - observability or rollback gaps for risky changes

### Step 5. Check Tests and Validation

- Inspect whether tests cover the happy path, important edge cases, and failure modes introduced by the change
- Prefer meaningful assertions over superficial execution
- Run focused validation commands when practical and allowed
- Confirm lint status in addition to tests and build checks when the project has a lint path
- Report what remains unverified when lint, tests, or build validation are absent, weak, or not run
- Do not imply that a change is fully validated when lint, tests, or build checks did not run

### Step 6. Check Design Alignment and Maintainability

- Compare the implementation against requirements and existing architectural patterns
- Flag unnecessary complexity, hidden coupling, ownership drift, and misplaced responsibilities
- Check whether the change requires documentation updates when it modifies APIs, configuration, schemas, or observable behavior
- Distinguish maintainability risks from subjective style preferences
- Do not present personal style preferences as blocking findings.

### Step 7. Produce the Review

- Report findings in severity order using this priority:
  - `💥Critical`: bugs, regressions, security issues, risks of data loss or sensitive data exposure (e.g., secret keys, passwords), or missing core requirements
  - `⚠️Major`: meaningful test gap, design drift, reliability risk, dead code, or important maintainability issue
  - `ℹ️Minor`: small readability, naming, unused, or consistency issue that does not materially affect correctness
- Include the following for each finding:
  - the impact
  - the concrete evidence
  - why it matters in practice
  - whether it is confirmed or inferred when that distinction matters
- Include the following after findings:
  - validation status
  - open questions or assumptions
  - a brief overall verdict: `pass`, `pass with notes`, or `re-review required`

### Step 8. Re-review After Changes

- Re-check every previously reported `💥Critical` and `⚠️Major` finding after fixes land.
- Confirm whether each finding is resolved, partially resolved, or still open.
- Avoid re-expanding scope unless the fix introduced new behavior worth reviewing.

## Output

Produce a concise review with this structure:

1. Findings, ordered by severity, with file references and concrete evidence
2. Open questions or assumptions, only if they affect confidence in the review
3. Validation status, including lint, tests, build, commands run, and what was not run
4. Verdict: `pass`, `pass with notes`, or `re-review required`

**IMPORTANT:** If no findings are discovered, MUST state this explicitly and note any remaining validation gaps or residual risk.
