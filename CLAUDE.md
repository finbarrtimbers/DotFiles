Prefer simplicity above all else. 

Follow the Google Python style guide unless otherwise instructed.

Follow the guidelines from the Google SWE book. 

Don't import functions: `from library import function`. Instead, import the library: `import library`.

When writing unittests, make them runnable via `uv run pytest`, and use Python's `unittest` module.

Use the `parameterize` library to parameterize Python tests.

Keep tests simple. Prefer logging over print statements.
