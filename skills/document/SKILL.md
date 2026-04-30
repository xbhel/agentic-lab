---
name: document
description: Produce clear, structured, and maintainable engineering documentation (e.g., draft, spec, design, ADR, guide, quickstart, best practices) for a given topic or context. Use this whenever creating or updating documentation.
argument-hint: topic or context to document
metadata:
  version: 1.0.0
  author: xbhel
  depends-on:
    - clarify
    - analyze
---

# Document

Create documentation with clear structure, actionable content, and appropriate depth, aligned with user intent and engineering context.

## IRON RULES

- MUST use the `/clarify` skill when the user's intent, scope, or purpose is ambiguous or incomplete
- MUST use the `/analyze` skill to gather relevant context before writing, especially for code or technical topics
- MUST use English for all documentation, unless the user explicitly requests another language
- MUST select and follow the most relevant reference below based on the user's intent
- MUST treat each reference as an independent document type with its own required sections and success criteria
- MUST choose one primary document type when the request could fit multiple references, and explain the choice briefly when it is not obvious
- MUST complete multi-document requests one document type at a time unless the user explicitly asks for a combined artifact
- MUST use clear naming and organization for easy access and future reference
- MUST keep the content concise and beginner-friendly
- MUST use clear, simple language and avoid unnecessary jargon
- MUST maintain a warm and encouraging tone throughout, never cold and clinical
- MUST use emojis when they improve readability or visual clarity, but avoid overuse
- MUST add colored Mermaid diagrams or other visual aids when they help explain complex concepts more clearly
- MUST use numbered steps or sequence markers in diagrams to make flows easier to understand
- MUST avoid Markdown-sensitive syntax in Mermaid diagrams; use plain text labels such as `1: run task` instead of `1. run task`

## References

ONLY READ the most relevant reference to create/update documentation:

| Reference | Best for | Never for | Content focus |
| --- | --- | --- | --- |
| [draft.md](./references/draft.md) | early thinking, shaping a problem, comparing possible directions | final requirements, build plans, final decisions | background, problem, options, open questions, next steps |
| [spec.md](./references/spec.md) | defining what the system must do and how to check success | build details, onboarding, early brainstorming | scope, requirements, behavior rules, edge cases, acceptance checks |
| [design.md](./references/design.md) | explaining how the solution should be built | unclear requirements, decision history, tutorials | system shape, responsibilities, flows, implementation approach, architecture, interfaces, trade-offs, validation |
| [adr.md](./references/adr.md) | recording one important decision and why it was chosen | open exploration, full requirements, full implementation design | context, decision, options, reasoning, consequences |
| [guide.md](./references/guide.md) | teaching a topic with explanation and practical help | fastest first run, project front page, formal spec or design | learning path, concepts, real usage, pitfalls, next steps |
| [quickstart.md](./references/quickstart.md) | getting someone to a first success as fast as possible | deep learning, broad overview, formal requirements or design | minimum setup, first run, success check, where to go next |
| [best-practices.md](./references/best-practices.md) | shared advice, strong defaults, and mistakes to avoid | tutorials, hard requirements, one-time decisions | principles, recommended patterns, anti-patterns, simple heuristics |
| [readme.md](./references/readme.md) | introducing a project, package, module, or skill | focused tutorials, formal spec, formal design, ADR | overview, setup, usage, structure, helpful links |

When a request spans multiple references, choose the document that resolves the user's immediate need first, complete it, then repeat the same selection process for the remaining needs until all requested document types are handled.

## Output

Save the document as a Markdown file with a clear, descriptive name in the appropriate directory based on topic and document type (e.g., `<feature>-spec.md`, `<feature>-design.md`), using a well-structured format with clear headings and sections for each relevant point.