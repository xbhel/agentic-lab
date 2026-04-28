---
name: clarify
description: Analyze the user’s requirements, resolve ambiguities, and align intent with existing codebase context when necessary. Produce a clear, structured specification for downstream design and implementation. Use this before design or implementation when requirements are incomplete, unclear, or require validation against the existing codebase.
argument-hint: "feature description or requirements"
metadata:
  version: 1.0.0
  author: xbhel
  depends-on: 
    - analyze
---

# Clarify

## Goal

Transform raw, incomplete, or ambiguous requirements into a clear, evidence-based, codebase-informed specification that is ready for design and implementation.

## Core Principles

- MUST ask clarifying questions until the requirements are unambiguous
- ALWAYS batch clarifying questions into a single prompt; never ask one at a time
- MUST use codebase evidence to resolve ambiguities before escalating to the user
- MUST produce a requirements specification, not an architecture proposal
- MUST surface assumptions and risks explicitly; do not absorb them silently
- NEVER implement or design; focus on clarifying and refining requirements only

## Workflow

### Step 1. Clarify Requirements

Ask follow-up questions as needed until the requirements are clear and unambiguous. Infer what you can, and clarify only what is genuinely unclear or affects implementation. Cover these areas when relevant:

- **Problem and scope:** the problem to solve, affected users, context, and what is in or out of scope.
- **Expected behavior:** desired behavior, success criteria, and concrete examples when helpful.
- **Inputs and outputs:** required inputs, expected outputs, formats, validation rules, and interface or contract details.
- **Constraints:** performance, compatibility, security, policy requirements.
- **Edge cases and failure modes:** invalid inputs, boundary conditions, graceful degradation.
- **Examples and usage:** representative scenarios, use cases, or reference behavior when they help remove ambiguity.

Example:

```text
User: Implement a Python calculator.

You: Before proceeding, I have a few clarifying questions:
  1. Should this be a CLI tool or a GUI application?
  2. Which operations should it support: basic math (+, -, *, /) only, or also powers and roots?
  3. How should it handle division by zero and invalid input?
```

Once the requirements are clarified, summarize them concisely and **confirm the summary with the user** before moving on.

### Step 2. Analyze the Codebase

Use the `/analyze` skill to explore only the codebase areas affected by the clarified requirements and gather relevant evidence. Keep the analysis targeted; avoid broad or exhaustive reviews. Launch 2–3 `/analyze` subagents in parallel, each focusing on a different aspect (e.g., similar features, architecture, UI patterns).

### Step 3. Validate and Refine Requirements

Cross-reference the clarified requirements against the codebase analysis. Use code evidence first, and ask follow-up questions only when the evidence is insufficient.

Follow these steps:

1. Validate alignment with the existing architecture, data flow, and ownership boundaries.
2. Identify gaps, conflicts, and missing behaviors.
3. Refine edge cases and failure modes based on system constraints.
4. Surface assumptions, risks, and any remaining open questions.
5. Propose simpler, better-aligned alternatives when requirements conflict with the codebase or the approach is overly complex.
6. Consolidate the refined spec, list all items needing user feedback, including open questions, assumptions, trade-offs, and alternative approaches, and wait for the user’s answers before proceeding.

Example:

```text
You: Pending Clarifications:
1. Parser: `src/utils/parser.py` only handles space-separated tokens. Should `2+2` be supported, or rejected with a clear error?
2. Division by zero: should it be handled and shown as a user-facing error, or allowed to propagate as an exception?

User:
1. Yes, support compact expressions like `2+2`.
2. Handle division by zero and show a clear user-facing error message.
```

After this phase, the requirements should be fully clarified, evidence-backed, and grounded in the relevant codebase context, ready for design and implementation.

### Step 4. Produce Requirements Specification

Produce the final requirements specification, not an architecture proposal. Consolidate clarified requirements, validation results, and codebase findings from previous phases into one structured output, ensuring all items in the below Checklist are explicitly covered as separate sections.

## Requirements Specification Checklist

- **Scope:** Problem definition, scope, and affected boundaries
- **Goals:** Desired outcomes and success criteria
- **Functional Requirements:** System behaviors, inputs, outputs, rules, and validation logic
- **Non-Functional Requirements:** Performance, compatibility, security, and policy requirements
- **Constraints:** limitations imposed by the system, codebase, business rules, or external factors
- **Interactions:** User interactions, system responses,  and communication patterns
- **Edge Cases:** Edge cases and failure modes
- **Use Cases and Examples:** Representative scenarios, use cases, or reference behavior that clarify requirements and edge cases
- **Assumptions and Risks:** Assumptions, risks, trade-offs, and remaining open questions
- **Integration Points:** Affected code paths, files, services, components, dependencies, as well as reuse opportunities and compatibility considerations
- **Codebase Context:** Relevant codebase findings that shape the requirements, including conventions, patterns, commands, runtime behavior, data flow, tests, and ownership boundaries
- **Validation Criteria:** Conditions that must be met to confirm the requirements are satisfied

## Output

A structured requirements specification.
