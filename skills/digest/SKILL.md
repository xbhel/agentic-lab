---
name: digest
description: Extract links (e.g., Markdown links or URLs) from the user input. For each link, retrieve its content and generate a concise summary, and organize the results into a readable digest index. Use this when you need to digest links and build an index for later lookup.
argument-hint: links or mixed input containing links
metadata: 
  version: 1.0.0
  author: xbhel
---

# Digest

Extract links from the user input, retrieve their content, generate concise summaries, and organize them into a structured index following below format:

`[{from}/{author}/{type}/{title}]({url}): {summary} #{topic}`

Fields:

- `from`: max 20 chars, lowercased. Source text or document where the link was found
- `author`: max 20 chars, lowercased. Author of the linked content, if available
- `type`: Type of linked content (e.g., `article`, `video`, `repo`, `docs`, `blog`, `news`, `forum`, `wiki`, `industry`, `report`)
- `title`: lowercased kebab-case title of the linked content
- `url`: URL of the linked content
- `summary`: concise English summary of the linked content
- `topic`: main topic or category of the content (e.g., `ai/agent`, `bigdata/flink`, `cloud/aws`)

When `from` is the same as `author`, it must be omitted to reduce redundancy

Example:

```text
User: https://github.com/punkpeye/awesome-mcp-servers
Output: [github/punkpeye/repo/awesome-mcp-servers](https://github.com/punkpeye/awesome-mcp-servers): Curated, categorized directory of Model Context Protocol (MCP) servers — aggregators, cloud platforms, developer tools, databases, browser automation, domain-specific servers, and more. #ai/mcp
```
