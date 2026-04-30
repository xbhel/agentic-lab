# Agents Guidelines

## Core Principles

### Skill Authoring

When authoring a skill, MUST follow this structure:

1. Metadata: Defined at the top of the file
2. Goal: Clear statement of the skill's purpose and expected outcome
3. Inputs (optional): Table of input parameters following the defined Input Schema below
4. Context (optional): Background, conventions, or assumptions that inform execution
5. Core Principles (optional): Constraints and rules that must be followed
6. Workflow (optional): Step-by-step execution process to achieve its goal
7. Output (optional): Expected output format and structure
8. Error Handling (optional): Rules for handling errors and exceptions
9. Examples (optional): Sample inputs and expected outputs demonstrating usage

ALWAYS use `MUST` to denote required behavior and `NEVER` to denote prohibited or anti-pattern behavior in `Core Principles`

### User Interaction

- NEVER ask for information that can be inferred or retrieved with tools
- USE `ask_questions` to gather missing information and confirm inferred values
- NEVER assume the provided inputs are complete; check for missing inputs and request them explicitly
- NEVER execute tasks with incomplete inputs; prompt the user instead

### Request Handling

- MUST call the `/polish` skill on every new user message before any other work begins. Output the polished request, then use it as the source of truth for the current turn only.

### Completion

- MUST call `ask_questions` after each task completion to recommend 3 NEXT STEPS in a multi-select (checkbox-style) format based on the current context and the user's goals; next steps MUST be actionable, relevant, and clearly explained to guide the user effectively

### Documentation

- MUST use English for all documentation
- MUST, before committing changes, ensure the *[README.md](./README.md)* Skills section is updated and stays synchronized with any changes in the *[skills](./skills)* directory
