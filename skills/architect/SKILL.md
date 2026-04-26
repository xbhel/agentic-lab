---
name: architect
description: Design a clear, extensible, and maintainable architecture proposal with explicit boundaries, responsibilities, integration points, and scalability considerations. Use this before implementation, integration, refactoring, system design, estimation, or review when architectural decisions or boundary definitions are required.
argument-hint: feature or component to architect
metadata:
  version: 1.0.1
  author: xbhel
---

# Architect

## Goal

Turn requirements into one concrete, implementation-ready architecture proposal grounded in the available context, with clear structure, ownership boundaries, integration points, and validation considerations.

## Core Principles

- Must understand requirements and relevant context deeply before designing.
- Must ground every design decision in requirements, constraints, or available context evidence.
- Must design with the existing architecture, environment, and constraints in mind when they exist.
- Prefer reusing existing components, seams, and conventions before introducing new abstractions.
- Must identify conflicting existing patterns or constraints explicitly when present.
- Must recommend the least risky path when patterns or constraints conflict.
- Must define scope before proposing abstractions.
- Must keep the design proportional to the change.
- Must make ownership boundaries, contracts, and integration points explicit.
- Must define where validation, orchestration, state changes, and side effects happen.
- Must state assumptions, trade-offs, and unresolved decisions explicitly.
- Must say directly when the requested architecture is over-engineered for its scope.
- Must propose a smaller design when the requested architecture is too heavy for the change.
- Never invent components or services without a clear responsibility and integration need.
- Never silently absorb unresolved product or technical decisions.

## Workflow

### Step 1. Validate Readiness

- Confirm requirements are sufficiently clear for architectural design.
- Confirm the available context is enough to anchor the proposal.
- List any missing information that would materially affect the design.

### Step 2. Define Scope and Boundaries

- Define in-scope and out-of-scope work.
- Identify affected components, modules, services, layers, workflows, and external systems.
- Mark stable boundaries that should not change.
- Mark interfaces or contracts that may change and the cost of changing them.
- Capture relevant runtime, deployment, performance, security, and ownership constraints.

### Step 3. Design the Architecture

- Define the high-level architecture and major abstractions.
- Select the design patterns that fit the context and explain why.
- Define components, services, modules, handlers, adapters, and APIs to add or change.
- Map integration points with existing components, code, storage, events, config, and external systems.
- Define interfaces and contracts between participating parts.
- Trace the data flow and execution path from entry to completion.
- Describe interaction and ownership handoffs where coordination matters.

### Step 4. Stress the Design

- Identify edge cases: invalid input, missing state, duplicates, ordering, retries, idempotency, concurrency, and partial failure.
- Define error handling at each important boundary.
- Identify operational, performance, maintainability, and migration risks.
- Compare alternatives only when a meaningful design choice exists.

### Step 5. Define Verification and Delivery

1. Define validation steps and success criteria.
2. Produce a workflow diagram that matches the written design.

## Architecture Checklist

Use the following checklist to ensure all important aspects of the architecture are covered:

- **Scope:** Problem definition, in-scope and out-of-scope work, and affected boundaries
- **Architecture**: Proposed structure, key responsibilities, ownership boundaries, and rationale
- **Design Patterns:** Patterns used or introduced, why they fit, and their trade-offs
- **Components:** Functions, modules, services, or adapters to add or modify, with clear responsibilities
- **Interfaces and Contracts:** Input/output schemas, validation rules, invariants, and interaction contracts across components
- **Integration Points:** Impacted code paths, services, storage, events, config, and external systems, including reuse and compatibility considerations
- **Data Flow:** End-to-end execution path, including validation, orchestration, side effects, async processing, retries, and decision points
- **Interaction:** Key coordination flows, interaction sequences, and ownership handoffs
- **Edge Cases and Error Handling:** Invalid input, missing state, duplication, concurrency, ordering, backward compatibility, and boundary-specific failures
- **Risks and Trade-offs:** Technical risks, complexity, migration concerns, open questions, and design trade-offs
- **Validation Approach:** How to confirm the architecture is correct, complete, and safe to implement
- **Diagram:** Provide a Mermaid diagram that accurately reflects the proposed architecture, using clear labels, flow markers, and colors to distinguish components where helpful

## Output

Produce a single architecture proposal. Every section MUST be concrete and context-specific, naming actual modules, files, APIs, boundaries, systems, or constraints where known. Focus on explicit decisions, not generic advice.

**IMPORTANT:** ensuring all items in the Architecture Checklist are explicitly covered as separate sections.
