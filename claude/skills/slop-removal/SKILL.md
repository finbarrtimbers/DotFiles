---
name: slop-removal
description: Remove AI-generated comment slop from a branch diff. Use when the user asks to clean up AI comments, remove slop, or strip unnecessary comments from a branch.
---

# Remove AI Slop from Branch Diff

## What counts as slop

Remove ONLY clearly AI-generated filler:
- Comments that restate what the code obviously does (e.g., `# Increment counter`, `# Return the result`)
- Phrases like "This is important because...", "Note that...", "We need to..."
- Overly verbose docstrings that describe trivial behavior
- Section headers that add no information (e.g., `# Main logic`, `# Helper function`)

## What to keep

Do NOT remove:
- Comments that explain non-obvious logic, edge cases, or algorithmic choices
- References to external specs, papers, or issues
- TODOs and FIXMEs
- Type annotations or parameter descriptions in docstrings

## Workflow

1. Run `git diff origin/main..HEAD` to see all changes on the branch
2. Identify slop comments introduced in this branch (not pre-existing)
3. Show me the list of proposed removals BEFORE making any edits
4. After confirmation, make the edits — only comment/docstring deletions, no code changes
5. Run the linter (`make style && make quality`) and confirm tests still pass
6. Commit with message "Remove AI-generated comment slop"
