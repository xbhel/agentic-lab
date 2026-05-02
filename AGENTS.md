# Agents Guidelines

## Iron Laws

### Skill Authoring

- ALWAYS use `MUST` to denote required behavior and `NEVER` to denote prohibited or anti-pattern behavior

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
