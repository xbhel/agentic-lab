# Design Reference

Describe the content that an effective design document should contain.

Before writing a design, you MUST know:

- the relevant requirements or scope boundaries
- the systems, interfaces, or components involved
- the main technical constraints and review concerns

## Core Principles

- MUST explain the structure of the solution before diving into lower-level detail
- MUST make component ownership, boundaries, and interfaces easy to trace
- MUST show the important trade-offs and why the chosen approach is reasonable
- NEVER restate the specification without explaining the implementation approach
- NEVER leave validation strategy or rollout concerns unclear when they matter to delivery

## Design Structure

Cover the following sections, including optional sections when relevant.

- Overview: short statement of what the design covers
- Audience `[Optional]`: who needs to review, implement, or integrate with this design
- Background: relevant system context and assumptions
- Design Goals: the outcomes the solution must optimize for
- Constraints: technical, operational, or compatibility constraints
- Proposed Architecture: the main solution shape and boundaries
- Components and Responsibilities: the moving parts and what each owns
- Data Flow or Control Flow: how information or execution moves through the system
- Interfaces and Contracts: APIs, schemas, events, or integration points
- Alternatives Considered: credible options and why they were not selected
- Risks and Trade-Offs: known costs, compromises, and failure risks
- Validation Strategy: how the design will be verified during implementation
- Rollout Considerations: migration, compatibility, or release notes if relevant
- Sequence Diagrams `[Optional]`: diagrams when they clarify a complex interaction or flow
- Capacity or Performance Notes `[Optional]`: performance considerations that shape the design
- Operational Playbooks `[Optional]`: operating notes for rollout, maintenance, or incident handling
- Security Considerations `[Optional]`: trust, access, abuse, or data-protection concerns

## Next Steps

After design review, the next step is usually implementation, testing, and possibly an ADR if one decision from the design needs a durable standalone record.
