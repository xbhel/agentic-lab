---
name: decompose
description: Break requirements, features, or work into small, independently executable and verifiable tasks,and construct an execution-ready plan by modeling the work as a task DAG, where vertices represent tasks and edges represent dependencies, explicitly capturing sequencing and parallelism. Same-wave (non-dependent) tasks can be executed in parallel via subagents based on the DAG structure. Use this when asked to break down or plan work, create to-do lists, or when the work involves multi-step execution requiring decomposition, coordination, dependency management, ordering, or parallel execution.
argument-hint: "work to decompose and plan for execution"
metadata:
  version: 1.0.0
  author: xbhel
  depends-on:
    - clarify
---

# Decompose

## Goal

Decompose work into small, independently executable and verifiable units, and produce an execution-ready plan structured as a task DAG with explicit dependencies, sequencing, and parallelism to enable efficient concurrent execution.

## Core Principles

- MUST perform thorough analysis before drafting a task DAG execution plan
- MUST keep each task small enough to be implemented and verified independently
- MUST explicitly model dependencies, sequencing, and parallelism to enable efficient execution
- MUST ensure the task graph forms a valid DAG (no cycles allowed)
- MUST assign each task a clear verification method and at least one checkpoint
- MUST define clear input/output boundaries for each task to avoid ambiguity in execution
- MUST produce an execution-ready plan suitable for direct implementation by agents or humans
- MUST clarify requirements and constraints rather than relying on inference
- MUST use explicit task definitions and dependencies over implicit assumptions.
- MUST mark uncertainty when dependencies, sequencing, or verification paths are unclear
- NEVER merge multiple unrelated behaviors into a single task
- NEVER create tasks that are too large to implement or verify independently
- NEVER assume tasks are parallel if they contend for shared resources (e.g., files, state) without explicit coordination

## Workflow

### Step 1. Clarify Work

Clarify the work to be decomposed, including requirements, constraints, goals, and outcomes. If the work is insufficiently specified or ambiguous such that decomposition would be unreliable, use `/clarify` skill to resolve missing or unclear information before proceeding.

### Step 2. Decompose into Tasks

Break the clarified work into the smallest useful units that still have a clear goal and a clear verification path. For each task, define:

- A short, action-oriented name that captures the essence of the task
- A clear description of the task's purpose and expected outcome
- Explicit input and output specifications to define the task's boundaries
- A clear verification method to confirm successful completion
- At least one checkpoint to allow for intermediate verification and error handling
- A meaningful type or category such as "doc", "analysis", "config", "testing", etc.


