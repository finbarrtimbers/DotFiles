Sync the current branch with origin/main.

Steps:
1. Check for uncommitted changes. If any exist, stash them before proceeding.
2. Fetch origin to ensure we have the latest main.
3. Merge origin/main into the current branch. (We squash-merge PRs, so rebase's linear history has no benefit — merge is simpler and avoids force-pushing.)
4. For merge/rebase conflicts:
   - For `uv.lock` and `requirements.txt`: always take main's version (`git checkout origin/main -- uv.lock`), then run `uv lock` to re-resolve with our pyproject.toml deps. Do NOT manually resolve conflict markers in these files. The pre-commit hook will regenerate requirements.txt with the correct flags, so just `git add` both files.
   - For source files: carefully examine both sides. Preserve the intent of our branch's changes while incorporating main's updates.
   - When in doubt about a conflict, ask me.
5. If the branch tracks a remote, ask me before force-pushing.
6. If changes were stashed in step 1, pop the stash. Note: `git stash pop` restores ALL files that were dirty when stashed, not just the ones you were focused on. Check `git status` after popping and discard any unwanted changes.
7. Run `make style` and `make quality` to verify nothing broke.
