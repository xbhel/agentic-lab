---
name: document
description: Produce clear, structured, and maintainable engineering documentation (e.g., draft, spec, design, ADR, guide, quickstart, best practices) for a given topic or context. Use this whenever creating or updating documentation.
argument-hint: topic or context to document
metadata:
  version: 1.0.0
  author: xbhel
  depends-on:
    - clarify
---

# Document

Create English documentation with clear structure, appropriate depth, and actionable content, aligned with the user's intent and the engineering context.

## RULES

- MUST use the `/clarify` skill when the user's intent, scope, or purpose is ambiguous or incomplete
- MUST select and follow the most relevant reference below based on the user's intent
- MUST use clear naming and organization for easy access and future reference
- MUST keep the content concise and beginner-friendly
- MUST use clear, simple language and avoid unnecessary jargon
- MUST maintain a warm and encouraging tone throughout, never cold and clinical
- MUST use emojis sparingly to improve readability and visual clarity, without overusing them
- MUST add colored Mermaid diagrams or other visual aids when they help explain complex concepts more clearly
- MUST use numbered steps or sequence markers in diagrams to make flows easier to understand
- MUST avoid Markdown-sensitive syntax in Mermaid diagrams; use plain text labels such as `1: run task` instead of `1. run task`

## REFERENCES

ONLY READ the most relevant reference to create/update documentation:

- [draft.md](./references/draft.md): Outline key points and structure
- [spec.md](./references/spec.md): Define requirements, behavior, and constraints
- [design.md](./references/design.md): Describe the architecture and implementation details
- [adr.md](./references/adr.md): Capture decisions, rationale, and consequences
- [guide.md](./references/guide.md): Provide step-by-step instructions and usage guidance
- [quickstart.md](./references/quickstart.md): Provide a minimal setup and getting-started flow
- [best-practices.md](./references/best-practices.md): Summarize recommended patterns and approaches
