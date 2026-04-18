---
name: decompose
description: Break requirements, features, or work into small, independently executable and verifiable tasks,and construct an execution-ready plan by modeling the work as a task DAG, where nodes represent tasks and edges represent dependencies, explicitly capturing sequencing and parallelism. Same-wave (non-dependent) tasks can be executed in parallel via subagents based on the DAG structure. Use this when asked to break down or plan work, create to-do lists, or when the work involves multi-step execution requiring decomposition, coordination, dependency management, ordering, or parallel execution.
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
- MUST use explicit task definitions and dependencies over implicit assumptions
- MUST mark uncertainty when dependencies, sequencing, or verification paths are unclear
- NEVER merge multiple unrelated behaviors into a single task
- NEVER create tasks that are too large to implement or verify independently
- NEVER assume tasks are parallel if they contend for shared resources (e.g., files, state) without explicit coordination

## Workflow

### Step 1. Clarify Work

Clarify the work to be decomposed, including requirements, constraints, goals, and outcomes. If the work is insufficiently specified or ambiguous such that decomposition would be unreliable, must use `/clarify` skill first to resolve missing or unclear information before proceeding.

### Step 2. Decompose into Tasks

Break the clarified work into the smallest useful units that still have a clear goal and a clear verification path. For each task, define:

- id: A unique identifier
- label: A concise, action-oriented short description that captures the essence of the task
- type: A meaningful type or category (e.g., `doc`, `analysis`, `config`, `testing`)
- goal: A clear description of the task’s purpose and expected outcome
- inputs/outputs: Explicit input and output specifications defining the task’s boundaries
- verification: A defined verification method to confirm successful completion, such as tests, linting, observations, explicit checks, or other measurable criteria
- checkpoints: At least one checkpoint for intermediate validation and error handling
- steps: Clear, actionable steps sufficient to execute the task independently

If a task cannot be executed or validated independently, it must be further decomposed until it meets all of the criteria above.

### Step 3. Model Dependencies and Sequencing

Determine task dependencies and execution order, ensuring all prerequisites are satisfied before a task begins and identifying opportunities for parallel execution. For each task, specify:

- dependencies: Tasks that must be completed before this task starts
- sequential: Implicit when execution order is required due to dependencies; order MUST be expressed via `depends-on <task-id>` (comma-separated if multiple)
- parallel: Mark `parallel` only if the task can run concurrently with other tasks without shared resources, conflicting changes, or unresolved decisions
- wave: Assign a stage number to group tasks that can be executed together in the same phase

Ensure the overall dependency model forms a valid DAG (no cycles) and enables efficient, correctly ordered execution.

### Step 4. Shape Task DAG

Organize tasks into a directed acyclic graph (DAG) based on dependencies, sequencing, and parallelism from the previous step. Ensure that:

- all tasks are included as nodes
- all dependencies are represented as directed edges
- sequencing is expressed through dependency relationships
- parallel tasks have no blocking dependencies
- the resulting graph is a valid DAG with no cycles and supports deterministic execution ordering

The DAG MUST be deterministic and unambiguous for execution planning.

### Step 5. Build Execution Plan

Construct an execution plan derived from the task DAG, respecting dependencies and parallelism. The plan MUST follow the structure defined in [plan-template](./references/plan-template.md).

### Step 6. Validate Execution Plan

Validate the task DAG and execution plan to ensure:

- all tasks are independently executable and verifiable
- dependencies, sequencing, and parallelism are correctly represented
- the DAG is a valid directed acyclic graph (no cycles)
- execution order is deterministic and unambiguous

## Output

The complete execution plan.
