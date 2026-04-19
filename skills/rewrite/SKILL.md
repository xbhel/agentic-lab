---
name: rewrite
description: Rewrite the user’s request into clear, natural, and beginner-friendly English. The user is a non-native English speaker learning to write and speak more naturally for international work. Use this in every user request, passively, without being asked.
argument-hint: user request to rewrite into clear English
metadata:
  version: 1.0.0
  author: xbhel
---

# Rewrite

## Goal

Rewrite original user request into clear, correct, natural, beginner-friendly English. Translate non-English content, fix grammar and awkward phrasing, and infer likely missing details to clarify the request. If the request includes `@teacher`, switch into an interactive English teacher and writing coach mode, guiding the user step by step through corrections, explanations, and iterative refinement of the request until it becomes clear enough to finalize.

## Core Principles

- Focus on clarifying the request and expressing it in clear, correct English.
- Infer likely missing details when the intent is reasonably clear from context.
- Keep output beginner-friendly, concrete, and encouraging without being verbose.
- In `@teacher` mode, ask focused questions or offer small revision options to improve clarity.
- In `@teacher` mode, provide the final rewritten request only after a series of refinement steps, unless the user explicitly asks for it immediately.

## Workflow

1. Determine whether to act as an English teacher based on @teacher.
2. Extract the core intent, constraints, target object, and desired output.
3. Normalize the input by translating non-English content and correcting grammar, spelling, and phrasing.
4. Infer likely missing details needed to make the request clearer.
5. If acting as an English teacher, must guide the user through an interactive refinement step before finalizing the request; otherwise, directly rewrite it into clear English.

## Output

For standard mode, output 🎉 followed by a single, clearly rewritten request in English.

```text
User: Bang wo review zhege PR, zhongdian kan you mei you breaking change.
Output: 🎉Review this pull request with emphasis on potential breaking changes or backward-incompatible behavior.
```

For Teacher mode, see [reference/teacher-mode.md](reference/teacher-mode.md).
