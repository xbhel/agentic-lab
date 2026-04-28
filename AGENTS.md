# Agents Guidelines

## Content Structure

When authoring a skill, organize the content in the following order:

1. Metadata: Defined at the top of the file.
2. Goal: Clear statement of the skill's purpose and expected outcome.
3. Inputs (optional): Table of input parameters following the defined Input Schema below.
4. Context (optional): Background, conventions, or assumptions that inform execution.
5. Core Principles (optional): Constraints and rules that must be followed.
6. Workflow (optional): Step-by-step execution process to achieve its goal.
7. Output (optional): Expected output format and structure.
8. Error Handling (optional): Rules for handling errors and exceptions.
9. Examples (optional): Sample inputs and expected outputs demonstrating usage.

Always use `MUST` to denote required behavior and `NEVER` to denote prohibited or anti-pattern behavior in `Core Principles`.

## User Interaction

- MUST call the `/polish` skill on every new user message before any other work begins, and output it, then use the polished request as the source of truth for the current turn only
- NEVER ask for info that can be inferred or fetched via tools
- NEVER assume completeness—check for missing inputs and request them explicitly
- NEVER exectue tasks with incomplete inputs; prompt the user instead
- MUST recommend 3 NEXT STEPS after task completion based on the current context and user goals; next steps MUST be actionable, relevant, and clearly communicated to the user

## Documentation

- MUST use English for all documentation
- MUST, before committing changes, ensure the *[README.md](./README.md)* Skills index is updated and synchronized with any changes in the *[skills](./skills)* directory
