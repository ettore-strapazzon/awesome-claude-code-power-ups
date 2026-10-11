# Contributing

This list is curated, not crowdsourced. Every entry has been checked against the same bar; new entries must clear it too.

## Adding a tool

Open a PR that adds one row to the right section of `README.md` and fill in:

- **Repo URL** and licence (SPDX id).
- **What it does** in one line, and **how it triggers** (auto / slash / phrase).
- **Stars and last push date** from the GitHub API, not from the README badge.
- **Execution surface**: does it ship hooks, scripts, an MCP server, a proxy? Does it need credentials, cookies, or a subscription login?
- **Evidence**: an independent benchmark, review, or your own measured result. "It feels faster" is not evidence.
- **Proposed rating** (1–5) and the one thing a user should know before installing.

## Moving a tool between sections

Open an issue first. Changes between *Recommended*, *Try with caveats* and *Hype check* need a reason that would convince a sceptic: a licence change, a security finding, a new independent benchmark, a maintainer change, or the project going quiet for six months.

## What gets rejected

- Lead magnets, affiliate catalogs, "comment for the link" funnels.
- Tools that require exporting login cookies or reusing a Claude/OpenAI subscription login for automation.
- Directories and marketplaces as install sources (link the upstream repo instead).
- Entries without a licence.
- Your own project without a disclosure line.

## Style

One row per tool. Verdict before praise. No emoji in the tables. Star counts rounded to the nearest thousand.
