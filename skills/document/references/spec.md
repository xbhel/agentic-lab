# Spec Reference

Describe the content that an effective specification should contain.

Before writing a spec, you MUST know:

- the problem being solved and the intended scope
- the main stakeholders or consumers of the behavior
- the key constraints that may shape the requirements

## Core Principles

- MUST describe what the system must do, not how the code should be written
- MUST write requirements in a way that can be reviewed, tested, or otherwise verified
- MUST keep scope boundaries explicit so the document does not drift
- NEVER mix implementation design into the requirements
- NEVER leave edge cases or acceptance checks implied when they affect correctness

## Spec Structure

Cover the following sections, including optional sections when relevant.

- Overview: short summary of the capability or change being specified
- Audience `[Optional]`: who will use, review, or rely on this specification
- Scope: in-scope and out-of-scope boundaries
- Goals: measurable or reviewable outcomes
- Functional Requirements: required system behaviors and rules
- Non-Functional Requirements: performance, reliability, security, compatibility, or policy constraints
- Inputs and Outputs: interfaces, formats, and data expectations
- Validation Rules: checks, invariants, and rules that must hold true
- Edge Cases and Failure Modes: boundary conditions and expected handling
- Acceptance Criteria: conditions that confirm the spec is satisfied
- Definitions `[Optional]`: terms that need shared meaning before review starts
- Dependencies `[Optional]`: upstream systems, contracts, or assumptions this spec relies on
- Rollout Constraints `[Optional]`: delivery or migration limits that affect implementation
- Related References `[Optional]`: links to drafts, designs, ADRs, or adjacent specs
- Open Questions `[Optional]`: unresolved items that still need confirmation

## Next Steps

After the spec is accepted, the usual follow-up is a design document, implementation plan, or test plan built from the confirmed requirements.
