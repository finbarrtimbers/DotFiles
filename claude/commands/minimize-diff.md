Description: Minimize the diff vs origin/main
argument-hint:
────

Review the current branch's diff against origin/main. Identify changes that can be removed to minimize the diff size while preserving the intended functionality.

Steps:
1. Run `git diff origin/main...HEAD` to see all changes on this branch.
2. For each changed file, categorize every hunk as either **essential** (directly implements the PR's goal) or **removable** (unrelated refactors, cosmetic changes, unnecessary reformatting, extra imports, gratuitous reordering, etc.).
3. Propose the list of removable changes, grouped by file, with a one-line explanation for each.
4. After I confirm, revert the removable hunks.

Guidelines:
- Preserve all functional changes that serve the PR's purpose.
- Remove drive-by refactors, style-only changes, and whitespace/import reordering that aren't required by the PR.
- If a file has only removable changes, `git checkout origin/main -- <file>` to fully revert it.
- For files with a mix, surgically revert only the removable hunks.
