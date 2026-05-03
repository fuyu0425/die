---
name: explore-reference
description: Use when exploring a reference project in agents-ref/, porting patterns or code from it, or documenting findings in agents-ref-docs/
---

# Explore Reference Project

Explore a reference project, document useful patterns, and port code to the current project.

## When to Use

- User wants to study a project in `agents-ref/`
- User wants to port patterns, utilities, or code from a reference project
- User wants to document a reference project's architecture or APIs

## Workflow

1. **Identify the project** — list `agents-ref/` if user didn't specify
2. **Check existing docs** — read `agents-ref-docs/<project-name>/` if it exists
   - Understand what's already documented to avoid duplication
   - If user specified a focus area, check if it's already covered
3. **Explore** — use Explore agent or direct reads to understand the target area
   - If focus area specified, scope exploration to that part (module, file, pattern)
   - Otherwise, explore broadly: structure, key files, patterns
4. **Document findings** — write or update notes in `agents-ref-docs/<project-name>/`
   - Create the subdirectory if it doesn't exist
   - Match directory name to the project name in `agents-ref/`
   - Update existing docs when new info complements them; don't duplicate
   - Use topic-specific files (e.g., `architecture.md`, `cli.md`, `sarif-utilities.md`)
5. **Port** — when user wants to bring code/patterns over, adapt to current project conventions

## Notes Format

Keep docs concise and actionable:
- Architecture overview (key modules, entry points)
- Useful patterns worth reusing
- API surface or utility functions
- Gotchas or design decisions

## Arguments

The skill accepts a project name and optional focus area.

```
/explore-reference CRSBench              # explore entire project
/explore-reference CRSBench cli          # focus on CLI module
/explore-reference CRSBench sarif utils  # focus on SARIF utilities
/explore-reference                       # list available projects
```
