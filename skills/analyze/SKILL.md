---
name: analyze
description: Analyze an existing codebase, or a specific area within a codebase, to build a clear, evidence-based understanding of how it works, how its parts interact, and how it can be changed or extended safely. Use this before implementation, debugging, testing, refactoring, design, estimation, or review.
argument-hint: feature or module to analyze
metadata:
  version: 1.0.0
  author: xbhel
---

# Analyze Code

## Goal

Produce a structured, evidence-based analysis of a target codebase area, including how it works, how it interacts with surrounding code, and what constraints, extension points, gaps, or risks are relevant, with sufficient detail to support design, implementation, debugging, refactoring, estimation, and review.

## Core Principles

- **Evidence first:** Every finding should point to concrete evidence (file, symbol, test, or command)
- **Stay in scope:** Analyze only what the task needs, not more. Avoid unnecessary deep dives or tangents
- **Observe before prescribing:** Describe current behavior before suggesting changes
- **Treat gaps as findings:** Missing tests, unclear seams, and undocumented constraints matter
- **Mark findings clearly:** Use ✅ for confirmed facts, 🔍 for inferred insights, ⚠️ for risks, and ❌ for gaps or missing elements

## Workflow

1. Locate relevant files, modules, entry points, components, and tests within the target scope.
2. Trace control flow, data flow, state changes, and side effects through the implementation.
3. Identify architectural patterns, abstractions, interfaces, dependencies, and runtime assumptions.
4. Review similar implementations for consistency, divergence, and reuse opportunities.
5. Examine tests, build scripts, and run commands to infer expected behavior and edge cases.
6. Summarize findings, inferences, ambiguities, and gaps using the checklist below.

### Analysis Checklist

- **Scope**: Relevant files, modules, entry points, boundaries, and what is context only.
- **Responsibilities**: Primary responsibilities and ownership boundaries of relevant modules and components.
- **Behavior**: Key execution paths, control flow, data flow, state changes, side effects, and failure behavior.
- **Architecture**: Dominant patterns, abstractions, module relationships, and separation of concerns.
- **Conventions**: Naming, organization, validation, error handling, and local standards.
- **Interfaces**: Public APIs, internal contracts, extension points, and integrations.
- **Dependencies**: Libraries, shared modules, services, data stores, config, and runtime assumptions.
- **Reference Implementations**: Similar implementations worth reusing or using as behavioral references.
- **Tests and Validation**: Test layout, frameworks, key commands, expected behavior, and coverage signals.
- **Build and Run Context**: Build scripts and runtime commands relevant to the target area.
- **Gaps and Constraints**: Missing tests, unclear ownership, ambiguity, hidden coupling, and limitations.

## Output

Output a comprehensive analysis that captures the relevant checklist areas with concrete evidence. 

**IMPORTANT:** ensuring all items in the Analysis Checklist are explicitly covered as separate sections.
