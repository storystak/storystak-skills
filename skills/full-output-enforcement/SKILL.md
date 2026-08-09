---
name: full-output-enforcement
description: Force Claude to output complete, unabridged code and content with no truncation, no placeholders, and no lazy shortcuts. Use when the user says "give me the full code," "no placeholders," "complete file," "don't skip anything," "full implementation," "no TODO comments," "write everything out," "don't abbreviate," or when the user is frustrated by partial output, skeleton code, or '// rest of code here' patterns. Also activate when the task involves generating a large file, multiple components, or any deliverable where completeness matters. This skill works alongside any other skill — it enforces output discipline regardless of the design or content being generated.
metadata:
  version: 1.0.0
---

# Full-Output Enforcement

## Baseline

Treat every task as production-critical. A partial output is a broken output. Do not optimize for brevity — optimize for completeness. If the user asks for a full file, deliver the full file. If the user asks for 5 components, deliver 5 components. No exceptions.

## Banned Output Patterns

The following patterns are hard failures. Never produce them:

**In code blocks:** `// ...`, `// rest of code`, `// implement here`, `// TODO`, `/* ... */`, `// similar to above`, `// continue pattern`, `// add more as needed`, bare `...` standing in for omitted code

**In prose:** "Let me know if you want me to continue", "I can provide more details if needed", "for brevity", "the rest follows the same pattern", "similarly for the remaining", "and so on" (when replacing actual content), "I'll leave that as an exercise"

**Structural shortcuts:** Outputting a skeleton when the request was for a full implementation. Showing the first and last section while skipping the middle. Replacing repeated logic with one example and a description. Describing what code should do instead of writing it.

## Execution Process

1. **Scope** — Read the full request. Count how many distinct deliverables are expected (files, functions, sections, answers). Lock that number.
2. **Build** — Generate every deliverable completely. No partial drafts, no "you can extend this later."
3. **Cross-check** — Before output, re-read the original request. Compare your deliverable count against the scope count. If anything is missing, add it before responding.

## Handling Long Outputs

When a response approaches the token limit:

- Do not compress remaining sections to squeeze them in.
- Do not skip ahead to a conclusion.
- Write at full quality up to a clean breakpoint (end of a function, end of a file, end of a section).
- End with:

```
[PAUSED — X of Y complete. Send "continue" to resume from: next section name]
```

On "continue", pick up exactly where you stopped. No recap, no repetition.

## Quick Check

Before finalizing any response, verify:
- No banned patterns from the list above appear anywhere in the output
- Every item the user requested is present and finished
- Code blocks contain actual runnable code, not descriptions of what code would do
- Nothing was shortened to save space
