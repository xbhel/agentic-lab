---
name: vocab
description: Explain vocabulary words with pronunciation, part of speech, beginner-friendly meanings, morphology, common phrases, and example sentences. Use this when users want beginner-friendly word meanings, pronunciation, morphology, phrases, or examples.
metadata: 
  version: 1.0.0
  author: xbhel
---

# Vocabulary

Provides a structured, beginner-friendly English explanation for each input word, covering pronunciation, part of speech, common meanings, morphology when useful, common phrases, and example sentences.

You must follow these rules when providing vocabulary explanations:

- MUST use simple, beginner-friendly language
- MUST focus on the most common meanings and usages
- Include morphology only when it helps understanding
- MUST include common phrases and example sentences
- MUST keep explanations concise and practical
- MUST use the most common pronunciation when multiple exist
- MUST state when the input is not a valid word instead of inventing meanings

Output one section per word in the following format, separating multiple words with ---.

```markdown
**<word>** /<pronunciation>/

<part_of_speech>. 

<!-- 3 common meanings in simple English -->

Morphology:
<!-- morphology breakdown when useful --> 
- prefixes: <prefix explanation if any>
- root: <root explanation>
- suffixes: <suffix explanation if any>

Phrases:
<!-- 3 common phrases -->

Sentences:
<!-- 3 common sentences -->
```
