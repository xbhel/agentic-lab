---
name: test
description: Add, fix, run, and report tests to ensure correctness and reliability of software components. User can control iterative execution via max_iterations (number of iterations) and coverage_target (minimum coverage threshold). Use this when you need to add new tests, fix existing tests, or verify and improve code correctness through tests.
argument-hint: what needs to be tested, how many iterations to run, and the minimum coverage required
context: fork
metadata:
  version: 1.0.0
  author: xbhel
---

# Test

## Goal

Generate, run, and iteratively improve tests to ensure that software components function correctly and reliably according to their specifications.

## Test Disciplines

When adding or fixing tests, follow these principles to ensure tests are effective, maintainable, and valuable:

- **First-class tests:** treat tests as production code, with the same care, review standards, and maintenance discipline
- **AAA Design:** follow the Arrange–Act–Assert pattern to ensure each test has a clear setup, execution, and verification phase
- **Black-box testing:** verify externally observable behavior rather than internal implementation details so tests remain stable during refactoring
- **Focused scope:** keep each test focused on a specific behavior or requirement to ensure clarity and maintainability
- **Smallest unit:** keep tests at the smallest meaningful unit of behavior, typically a single method or function. Assume collaborators are correct and already tested, and only stub dependencies that cross system boundaries or introduce side effects
- **Readable tests:** keep tests small, focused, and intent-revealing; use clear names and add comments only when they clarify non-obvious setup or expectations
- **BDD-style test names:** Name test methods in a behavior-driven development style, describing the expected behavior under specific conditions, e.g., `method_should_return_error_when_input_is_invalid`
- **Artifact naming:** Use predictable, discoverable naming conventions for test files and classes; organize them so the test suite is easy to navigate and maintain
- **Clear structure:** keep source code, tests, fixtures, test data, and helpers in a consistent and navigable layout
- **Reproducible environment:** ensure the test environment is fully reproducible, with testing, assertion, mocking, and coverage tools explicitly declared
- **Single-command execution:** ensure all tests, individual test runs, and coverage reports can be executed via a single consistent command
- **Clear assertions:** use precise assertions that produce meaningful failure messages and clearly express expected behavior; prefer fluent assertion styles when supported
- **Explicit test data:** use fixtures, factories, or builders to make test data explicit, reusable, and easy to evolve
- **Data-driven tests:** use parameterized tests to avoid duplication when multiple inputs validate the same behavior
- **Edge case coverage:** cover boundary conditions, invalid inputs, exception paths, and expected failure scenarios
- **Isolated testing:** isolate units under test using appropriate test doubles (mocks, stubs, fakes, spies) without obscuring verified behavior
- **Deterministic tests:** ensure tests are repeatable and independent by controlling time, randomness, network, concurrency, and shared mutable state
- **Deterministic async testing:** test asynchronous and concurrent logic with explicit control over timing, retries, and completion signals
- **Testability-first refactoring:** prefer refactoring hard-to-test code such as static methods, private logic, legacy code, or other tightly coupled areas; if refactoring is not feasible, use seams, dependency injection, or advanced mocking only when necessary and justified, treating invasive testing approaches as a last resort
- **Coverage-driven insight:** use coverage reports to guide test investment toward untested paths and critical behavior, not as a vanity metric
- **Failure diagnosis:** ensure failing tests provide actionable output and clearly distinguish test defects from production defects
- **Flaky test control:** identify unstable, redundant, or low-signal tests and improve, quarantine, or remove them appropriately
- **Refactoring feedback loop:** use test friction and failures as signals to improve production code design, modularity, and testability
- **Defect reporting:** when tests reveal bugs, document minimal reproduction, expected vs actual behavior, impact, and relevant test evidence

## Iron Laws

- MUST document untestable code explaining why it is hard to test, suggesting minimal design improvements, and providing an alternative test strategy
- MUST document source defects by describing the bug, how to reproduce it, proposing a fix, and adding a regression test to prevent recurrence
- MUST consider testability refactoring by improving design so tests reflect behavior rather than implementation
- MUST report environment issues including the command, error output, and the fix or recommendation
- MUST handle convention mismatches by adapting to project conventions or explaining tradeoffs

## Workflow

### Step 1. Identify Scope

Identify the components, modules, functions, or features to be tested, along with the behaviors, requirements, and scenarios that must be verified. Define the boundaries of the test scope, including any dependencies, integrations, and external systems that may affect or be involved in testing.

### Step 2. Discover Test Environment

Identify and prepare the testing environment required to execute the tests, including the programming language, testing framework, libraries, tools, commands, and configuration settings. Ensure all dependencies, mocks, stubs, and external systems can be controlled, simulated, or isolated to support a reproducible and deterministic test environment.

**IMPORTANT:** Avoid superficial code scanning and environment assumptions. You MUST deeply understand the codebase before modifying it, and verify all commands, tools, configurations, and the actual runtime environment (e.g., the specific SDK or runtime version in use) to ensure tests run correctly.

Example:

```text
Project: Java monorepo

Environment discovery:
- Programming language: Java
- Build tool: Maven
- Testing framework: JUnit 5
- Mocking library: Mockito
- Linting tool: SonarLint
- Coverage tool: JaCoCo

Detected environment:
- Multiple JDK versions installed locally: JDK 8, JDK 11, and JDK 17
- Different modules in the monorepo may target different Java versions

Configuration verification:
- Inspect root and module pom.xml files
- Confirm current target module declares Java 11
- Verify test dependencies, plugins, and Maven profiles

Required commands:
- export JAVA_HOME=/path/to/jdk11
- export PATH=$JAVA_HOME/bin:$PATH
- mvn test -pl target-module

Reason:
- System default JDK may not match project requirements
- Tests must run against the runtime, dependencies, commands, and configuration actually declared by the target project, not local machine defaults
```

### Step 3. Review Existing Tests

Review existing tests to ensure they are correct, up to date, and meaningful. Identify untested behaviors, branches, and edge cases, and avoid duplicating existing coverage. Rewrite tests only when they are stale, brittle, duplicated, or assert incorrect behavior.

### Step 4. Add Tests

Develop and add new tests to cover the untested behaviors, branches, and edge cases identified in the previous steps.

- Ensure each test verifies a single behavior and follows the Test Discipline principles defined above, including edge case coverage, isolated testing, deterministic execution, and clear failure diagnostics
- Prioritize coverage in the following order: happy paths → boundary/edge cases → exception handling → business logic branches
- For external boundaries such as filesystem, HTTP, database, time/clock, randomness, process execution, and environment access, use mocks, stubs, or fakes instead of interacting with real systems

### Step 5. Test-and-fix Loop

Repeat test execution and fix any failing tests by addressing either test defects or production code defects. Use feedback from failing tests to improve code quality, test coverage, and test reliability, iterating until all tests pass deterministically and failures provide clear diagnostic information.

Repeat up to `<max_iterations>` times:

1. Run focused tests first when possible
2. Run the full test suite before finishing
3. Run lint and fix any violations
4. Fix any failing tests
5. Measure test coverage
6. Add or refine tests based on coverage gaps
7. Evaluate exit conditions and stop if all tests pass, lint is clean, and coverage ≥ `<coverage_target>`, or if `<max_iterations>` is reached, reporting any remaining coverage gaps


### Step 6. Report the Results

After completing the test-and-fix loop, report the final test results, lint status, and test coverage. Include any remaining coverage gaps if the maximum number of iterations was reached without achieving the coverage target. Ensure that all reports provide clear and actionable information for further improvement of code quality and test coverage.

## Output

- Modules tested: list of source modules covered
- Test files created or updated: paths of new or modified test files
- Tests added or changed: number of new and modified test methods
- Coverage: measured percentage or estimated coverage with justification
- Test status: pass or fail counts from the final run
- Lint status: clean state or list of remaining violations
- Remaining coverage gaps: untested paths or behaviors that still need coverage
- Code issues found: production bugs, design concerns, or testability improvements discovered
- Iterations used and exit reason: number of iterations consumed and the exit condition that was met
- Environment issues: problems in the test environment, including commands, errors, and fixes or recommendations
- Convention mismatches: differences from project conventions and how they were handled or their tradeoffs
