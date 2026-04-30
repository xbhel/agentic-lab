# ADR Reference

Describe the content that an effective architecture decision record should contain.

Before writing an ADR, you MUST know:

- the decision that needs a durable record
- the realistic alternatives that were considered
- the consequences or follow-up work the decision creates

## Core Principles

- MUST keep each ADR focused on one primary decision
- MUST explain both the chosen option and the reasoning behind it
- MUST record the important consequences so future readers understand the trade-offs
- NEVER turn the ADR into a full specification or design document
- NEVER hide downsides or rejected options when they matter to the decision

## ADR Structure

Cover the following sections, including optional sections when relevant.

- Title: the decision being recorded
- Audience `[Optional]`: who should care about this decision and why
- Status: proposed, accepted, superseded, or deprecated
- Date: when the ADR was created or accepted
- Context: the forces, constraints, and background driving the decision
- Decision: the chosen option stated plainly
- Options Considered: the realistic alternatives reviewed
- Rationale: why the selected option won
- Consequences: positive, negative, and neutral outcomes of the decision
- Follow-Up Actions: implementation or migration work required afterward
- Related Documents: links to specs, designs, issues, or superseding ADRs
- Decision Drivers `[Optional]`: the highest-priority forces behind the decision
- Validation Signals `[Optional]`: how the team will know the decision is working well
- Rollback Notes `[Optional]`: what to do if the decision must be reversed later
- Ownership `[Optional]`: who owns follow-up work or future review of the decision

## Next Steps

After an ADR is accepted, link it from the relevant spec, design, or README so future readers can find the decision in context.
