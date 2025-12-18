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
- imports belong at the top of the file
- Imports go at the top of the file