Sync the current branch with origin/main.

Steps:
1. Check for uncommitted changes. If any exist, stash them before proceeding.
2. Fetch origin to ensure we have the latest main.
3. Rebase the current branch onto origin/main. If conflicts are too complex for a clean rebase, use a merge instead.
4. For merge conflicts, carefully examine both sides. Preserve the intent of our branch's changes while incorporating main's updates. When in doubt about a conflict, ask me.
5. If the branch tracks a remote, ask me before force-pushing.
6. If changes were stashed in step 1, pop the stash.
7. Run `make style` and `make quality` to verify nothing broke.
