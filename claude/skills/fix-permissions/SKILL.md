---
name: fix-permissions
description: Suggest the minimal permission rule for the most recent denied tool call. Use when Claude was prompted for permission and you want to allow it permanently.
---

# Fix Permissions

## Instructions

When the user invokes this skill, they want to permanently allow a tool call that just prompted for permission. Your job is to suggest the most minimal, conservative permission rule.

1. Identify the most recent tool call that required user approval (the one that triggered the permission prompt).

2. Determine what type of tool it was:
   - `Bash(...)` — a shell command
   - `Read(...)` — reading a file outside the project
   - `WebFetch(domain:...)` — fetching from a URL
   - `WebSearch` — web search
   - `Skill(...)` — invoking a skill

3. Suggest the **most conservative** rule that covers the denied action:
   - For Bash: use the command prefix + `*` wildcard. Prefer the shortest prefix that covers only the intended command family. Example: `Bash(mkdir *)` not `Bash(*)`.
   - For Read: use the most specific directory glob. Example: `Read(//private/tmp/**)` not `Read(///**)`.
   - For WebFetch: use the exact domain. Example: `WebFetch(domain:docs.python.org)` not `WebFetch(domain:*)`.
   - IMPORTANT: Use spaces not colons as separators in Bash rules. `Bash(mkdir *)` NOT `Bash(mkdir:*)`.

4. Determine the right settings file:
   - `~/.claude/settings.json` — for general-purpose tools you'd want in any project (common CLI commands, commonly visited domains)
   - `.claude/settings.local.json` — for project-specific permissions (project scripts, project-specific domains)

5. Read the target settings file, check for duplicates or rules that already cover the new one, then add the rule if needed.

6. Present the suggested rule to the user and explain why it's minimal/conservative. Ask for confirmation before writing.

## Examples

**Bash command denied:**
> The command `mkdir -p /some/path` was just prompted.
> Suggested rule: `Bash(mkdir *)` in `~/.claude/settings.json`
> This covers all `mkdir` invocations. Already have `Bash(mkdir:*)` but the colon syntax doesn't match — need space syntax.

**Read outside project:**
> Reading `/tmp/test_output.log` was prompted.
> Suggested rule: `Read(//private/tmp/**)` in `~/.claude/settings.json`
> This covers reading any file under /tmp.

**WebFetch denied:**
> Fetching from `https://docs.python.org/3/library/re.html` was prompted.
> Suggested rule: `WebFetch(domain:docs.python.org)` in `~/.claude/settings.json`
> This allows fetching from Python docs only, not all domains.
