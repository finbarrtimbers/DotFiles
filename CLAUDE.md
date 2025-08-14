Follow the Google Python style guide.

Follow the guidelines from the Google SWE book. 

Don't import functions: `from library import function`. Instead, import the library: `import library`.

When writing unittests, make them runnable via `uv run pytest`, and use Python's `unittest` module.

Use the `parameterize` library to parameterize Python tests.

Keep tests simple. Prefer logging over print statements.

If I ask you to fix a bug, please always write a test first, verify it raises the same issue, and then write the fix. If this isn't possible, please tell me. 

If I ask you to reproduce a bug with a test, then you should write a test that fails, because it is testing that we see the correct behaviour. 

Please keep comments to a minimum, and only add comments when they are needed.

Please only use try/except clauses when absolutely necessary. Prefer to not use them.
