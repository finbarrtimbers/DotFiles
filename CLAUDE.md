Follow the Google Python style guide.

Follow the guidelines from the Google SWE book.

Don't import functions: `from library import function`. Instead, import the library: `import library`.

When writing unittests, make them runnable via `uv run pytest`, and use Python's `unittest` module.

Use the `parameterize` library to parameterize Python tests.

Keep tests simple. Prefer logging over print statements.

If I ask you to reproduce a bug with a test, then you should write a test that fails, because it is testing that we see the correct behaviour.

Please keep comments to a minimum, and only add comments when they are needed.

If you want to use a try/except clause, you have to explicitly ask me for permission.

Always try to use `uv run python` instead of `python ...` (same for `uv run pytest`).
- vllm is not installed locally. Don't try to import or inspect it on this machine. Read the source code directly instead.
- imports belong at the top of the file
- Imports go at the top of the file
- Always use single-line git commit messages (no newlines). Put the Co-Authored-By on the same line separated by a space, not on a new line.
- Never chain bash commands with `&&` or `;` in a single Bash call. Use separate Bash tool calls instead.
- Never use `find`, `grep`, or `cat` as Bash commands. Use the Glob, Grep, and Read tools instead.
- Never pipe Bash command output through other commands (e.g. `| head`, `| grep`, `| tail`). Run commands directly and let the tool handle output.
- Never use `2>/dev/null` or other stderr redirects in Bash commands. Let errors show naturally.
- Never put `#` comments inside multi-line quoted strings in Bash commands (e.g. `python3 -c "..."` or heredocs). This triggers a security permission check. Write the code without comments or as a single line instead.

For every task I ask you to accomplish, do the following:

1. If you launch an experiment, monitor it and fix any issues that arise.
2. When you have finished the task, if there's a PR associated with it, /fix-pr-comments.
3. Run /simplify.

Never run `python` or `python3` directly. Always use `uv run` instead to keep the interpreter/dependencies consistent. Similarly, never use `pip` or `pip3`; use `uv add/remove` or `uv run --with`.
