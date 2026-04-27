---
name: develop
description: Orchestrate end-to-end feature delivery by composing requirement analysis, architecture design, execution planning, TDD implementation, code review, and final handoff. Use this when delivering a end-to-end feature from raw or partially defined requirements through implementation, validation, and final completion, especially when the work benefits from a single coordinated workflow across multiple stages. Do not use this when a single specialist skill is sufficient for the task.
argument-hint: "description of the feature, change, or problem to solve"
metadata:
  version: 1.1.1
  author: xbhel
  depends-on:
    - clarify
    - architect
    - decompose
    - tdd
    - test
    - review
---

# Develop

## Goal

Provide a structured approach to developing new features. Instead of jumping straight into coding, this process emphasizes clarifying user requirements, understanding the codebase, designing the solution, implementing the code, testing, and validating quality, resulting in well-designed features that integrate seamlessly with the existing codebase, meet user needs, and are maintainable in the long term.

## Context

- This skill is an orchestrator. Delegate each phase to the appropriate specialist skill instead of repeating that skill's full workflow here
- Outputs from earlier phases become required inputs for later phases
- Keep the workflow proportional to the change. If a single specialized skill is enough, say so directly
- Consider using different subagents across phases when supported, each bound to an appropriate model; prefer Claude for design, planning, and implementation, and GPT for clarification, verification, and review, always favoring the latest available models

## Core Principles

- MUST confirm requirements specification, design, and implementation plan with the user before proceeding to the next phase
- MUST document these artifacts and read or update them on demand for progress tracking, recovery, continuation, or restoration after context compression
- MUST ground design and implementation in the existing codebase, patterns, constraints, and confirmed requirements
- MUST create a TDD-first implementation plan before coding begins
- MUST implement in small validated slices, using parallel implementation agents only for independent items that do not contend on the same unstable seam
- MUST review the code for quality, readability, and maintainability
- MUST keep the scope tight to the approved feature and carry forward confirmed assumptions, risks, and constraints across phases
- NEVER silently absorb unresolved decisions that materially affect design or implementation
- NEVER restate an entire delegated skill inline when a concise handoff to that skill is enough
- NEVER mark the development as complete until all tests pass and lint checks pass

## Workflow

### Phase 1: Clarify Requirements

Use the `/clarify` skill to clarify, validate, and refine requirements until they are ready for design, producing a clear and structured requirements specification.

Before moving forward:

- resolve or explicitly carry forward any open questions
- capture the affected files, patterns, tests, and constraints that later phases must respect
- identify the build and runtime context, including the relevant scripts, commands, test execution steps, and test suites that subsequent phases should use for validation

**MUST** confirm the refined requirements with the user

### Phase 2: Design the Solution

Once the refined requirements are confirmed, use the `/architect` skill to produce the implementation-ready design.

Launch three parallel design subagents with different focuses:

- Minimal Changes: minimal changes, maximum reuse, lowest migration cost
- Clean Architecture: clean boundaries, maintainability, and stronger architecture
- Pragmatic Balance: pragmatic balance between delivery speed, safety, and future flexibility

Then compare the three approaches, evaluate the trade-offs, recommend one option, and **MUST** confirm the chosen approach with the user.

### Phase 3: Plan the Implementation

After the design is approved, use the `/decompose` skill to transform the confirmed scope into a structured execution plan—comprising decomposed, sequenced, and parallelizable tasks with explicit dependencies, defined checkpoints, and a trackable to-do list. This serves as the execution-ready plan.

The plan should stay TDD-first and include the execution slices, dependencies, checkpoints, trackable to-do list, and task graph needed to drive implementation safely.

**MUST** confirm the execution-ready implementation plan with the user before proceeding to implementation.

### Phase 4: Implement with TDD

Execute the plan using a test-first approach via the `/tdd` skill, following its **failing-test-first** workflow for each implementation slice.

Strictly apply the **Test Discipline** principles defined in the `/test` skill when designing and writing tests(e.g. AAA Design, First-class tests, and BDD-style test names).

When waves are marked as parallel in the plan, they may be executed concurrently using separate subagents; MUST attempt to run different tasks in the same wave using multiple subagents, with a maximum of five.

During implementation, you MUST:

- assign each subagent a stable slice boundary from the approved plan
- keep parallel subagents off the same unstable file, contract, migration, or shared seam unless the plan explicitly calls for coordination
- require each subagent to complete its own red-green-refactor loop before merging results
- synchronize at the end of each wave, resolve conflicts, and run shared validation before starting the next dependent wave
- keep execution aligned with the approved requirements, design, plan, and existing patterns
- run broader validation at meaningful checkpoints, not only the most recent test
- update code comments or docs only when they clarify non-obvious behavior

### Phase 5: Quality Review and Iteration

Once all implementation slices are completed, the feature must undergo a thorough quality review using the `/review` skill to ensure it meets the confirmed requirements, approved design, and expected validation criteria.

Scope the review to:

- the implemented diff
- the confirmed requirements
- the approved design pattern and constraints
- the expected tests, lint checks, and validation steps
- the desired behavior, success criteria, and edge cases

Treat `Critical` and `Major` review findings as blocking issues that must be resolved before considering the feature complete; address `Minor` issues if they can be fixed quickly.

If review findings require changes, return to the TDD implementation loop for the affected slice, re-run the relevant validation, and repeat review until the blocking findings are resolved.

Report out-of-scope issues only when confidence is high enough that they materially matter.

### Phase 6: Final Delivery Summary

After the review loop is complete, ask the user whether to document the specification and design as a guide in the codebase. If yes, create the documentation following these guidelines:

- Use clear naming and organization for easy access and future reference
- Prefer a single file with separate sections unless clarity requires splitting into multiple files
- Keep the content concise and beginner-friendly
- Use clear, simple language and avoid unnecessary jargon
- Maintain a warm and encouraging tone throughout, never cold and clinical
- Use emojis sparingly to improve readability and visual clarity, without overusing them
- Add colored Mermaid diagrams or other visual aids when they help explain complex concepts more clearly
- Use numbered steps or sequence markers in diagrams to make flows easier to understand
- Avoid Markdown-sensitive syntax in Mermaid diagrams; use plain text labels such as `1: run task` instead of `1. run task`

Always produce the final delivery summary using the output structure below.

## Output

A structured final delivery summary that synthesizes the outputs of the delegated skills and includes:

- current status of the feature
- refined requirements baseline
- approved design summary
- implementation outcome and changed surfaces
- validation results, including tests, lint, and review verdict
- remaining risks, follow-up items, or open decisions
- documentation and usage notes relevant to users or maintainers

## Error Handling

- Stop before design when requirement-critical questions remain unresolved
- Present the lower-risk option and wait for approval when the design conflicts with the codebase or is over-engineered for the task
- Refine or rescope the plan before coding when `/decompose` cannot produce independently verifiable tasks
- Create the smallest safe test seam first, or get explicit approval, when `/tdd` cannot start cleanly
- Reslice the work or serialize that seam when parallel implementation slices begin to conflict
- Do not present the feature as complete while blocking `/review` findings remain unresolved, unless the user explicitly accepts them
- Split long-running delegated phases into subagents where appropriate, then recombine their outputs before continuing
