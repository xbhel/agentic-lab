---
name: summarize
description: Synthesize information from various sources into a concise and coherent summary that captures the essential points, insights, or decisions. Use this when you need to distill complex information, extract key takeaways, or provide a high-level overview of a topic, document, or discussion. Do not use this when a detailed analysis, step-by-step explanation, or comprehensive report is required.
argument-hint: "description of the information to summarize"
metadata:
  version: 1.0.0
  author: xbhel
---

# Summarize

Provide a clear, comprehensive, beginner-friendly summary of a topic the user wants to understand better.

The summary should cover:

- Overview: title, source, author, date, target audience, purpose
- Objective: the main objective or core thesis
- Context: relevant background, motivation, or circumstances
- Key points: main arguments, findings, and insights that support the objective
- Decisions: key choices, architectural patterns, trade-offs, and explicit recommendations or actions
- Constraints: limitations, assumptions, dependencies, and risks
- Examples: optional illustrative cases or scenarios that clarify key points or decisions
- Open questions: unresolved issues, uncertainties, or gaps
- Next steps: recommended follow-up actions, research, or implementation steps

Also add additional relevant sections when they meaningfully improve understanding.

You MUST:

- keep the content concise and beginner-friendly
- use clear, simple language and avoid unnecessary jargon
- maintain a warm and encouraging tone throughout, never cold and clinical
- use emojis when they improve readability or visual clarity, but avoid overuse
- add colored Mermaid diagrams or other visual aids when they help explain complex concepts more clearly
- use numbered steps or sequence markers in diagrams to make flows easier to understand
- avoid Markdown-sensitive syntax in Mermaid diagrams; use plain text labels such as `1: label` instead of `1. label`
