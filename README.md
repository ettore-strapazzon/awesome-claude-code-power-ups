# Awesome Claude Code Power-Ups

> A vetted, opinionated list of the Claude Code **skills, plugins, MCP servers and hooks** that are actually worth installing — with star counts verified against the GitHub API, licence and security notes, install commands, and the hype-vs-reality verdict for each.

[![Awesome](https://awesome.re/badge.svg)](https://awesome.re)
![Tools reviewed](https://img.shields.io/badge/tools%20reviewed-142-blue)
![Recommended](https://img.shields.io/badge/recommended-47-brightgreen)
![Last review](https://img.shields.io/badge/last%20review-Nov%202026-informational)
![License: CC0](https://img.shields.io/badge/license-CC0--1.0-lightgrey)

Every entry here was pulled from the firehose of "10 Claude Code plugins you NEED" posts, then checked the boring way: README read in full, hooks and scripts inspected, stars and last-push date pulled from the GitHub API, licence confirmed, and the marketing claim compared with independent measurements where any exist. Tools that failed the check are listed too — in the **Hype check** section — because knowing what *not* to install is half the value.

**Scope:** things that plug into [Claude Code](https://docs.anthropic.com/en/docs/claude-code) (and usually Codex, Cursor and Gemini CLI via the same `SKILL.md` format). Not a list of every AI repo on GitHub.

---

## Contents

- [How to read this list](#how-to-read-this-list)
- [Quick start: the 20-minute install](#quick-start-the-20-minute-install)
- [Official Anthropic](#official-anthropic)
- [Engineering workflow](#engineering-workflow)
- [Front-end & design](#front-end--design)
- [Browser, testing & integrations](#browser-testing--integrations)
- [Security](#security)
- [Memory, context & token cost](#memory-context--token-cost)
- [Decision-making & research](#decision-making--research)
- [Marketing & SEO](#marketing--seo)
- [Diagrams, video & media](#diagrams-video--media)
- [Finance, trading & on-chain](#finance-trading--on-chain)
- [Reference repos worth bookmarking](#reference-repos-worth-bookmarking)
- [Try with caveats](#try-with-caveats)
- [Hype check: popular but not worth installing](#hype-check-popular-but-not-worth-installing)
- [How installs work](#how-installs-work)
- [Safety checklist before installing anything](#safety-checklist-before-installing-anything)
- [Contributing](#contributing)

---

## How to read this list

| Field | Meaning |
| --- | --- |
| ★ | GitHub stars from the API at review time, rounded. A big number means viral, not good — several 100k+ repos are in **Hype check**. |
| Rating | 1–5 for usefulness in a real Claude Code workflow, discounted for licence, security and terms-of-service risk. |
| Type | `skill` = markdown instructions (zero execution surface) · `plugin` = skills + commands + possibly **hooks** that run code · `mcp` = a server process · `cli` = a tool Claude calls |
| Trigger | **auto** (Claude picks it when your prompt matches) · **slash** (`/command`) · **phrase** (a trigger sentence) |

Ratings are one reviewer's judgment. Open an issue if you disagree — with evidence.

---

## Quick start: the 20-minute install

If you only do one thing, install these in this order. All are MIT/Apache, from accountable authors, and most are plain markdown.

```bash
# skills (markdown only, no hooks)
npx skills@latest add addyosmani/agent-skills -g -a claude-code -y --skill '*'
npx skills@latest add vercel-labs/agent-skills -g -a claude-code -y --skill web-design-guidelines react-best-practices
npx skills@latest add emilkowalski/skills -g -a claude-code -y --skill '*'
npx skills@latest add pbakaus/impeccable -g -a claude-code -y --skill '*'
npx skills@latest add shadcn/improve -g -a claude-code -y
npx skills@latest add nutlope/hallmark -g -a claude-code -y --skill '*'
npx skills@latest add blader/humanizer -g -a claude-code -y --skill '*'

# official plugins (the claude-plugins-official marketplace is pre-registered)
claude plugin install claude-code-setup@claude-plugins-official     # scans a repo, recommends MCPs/skills/hooks, changes nothing
claude plugin install superpowers@claude-plugins-official           # export SUPERPOWERS_DISABLE_TELEMETRY=1 first
claude plugin install mattpocock-skills@claude-plugins-official

# official browser automation
claude mcp add playwright -s user -- npx -y @playwright/mcp@latest      # Windows: prefix the command with  cmd /c
npx playwright install chromium

# diagrams
claude plugin marketplace add cathrynlavery/diagram-design && claude plugin install diagram-design@diagram-design

# guard rail: blocks rm -rf, git reset --hard, .env/SSH reads before they run (Node 22+)
npx -y cc-safety-net@latest install
```

Then open a fresh `claude` session and type `/` to see what arrived.

---

## Official Anthropic

Anthropic ships more of its own plugins than most "top 10" videos realise. These are the ones that matter for a solo setup.

| Tool | Type · Trigger | What it does | ★ | Rating |
| --- | --- | --- | --- | --- |
| [Claude Code Setup](https://github.com/anthropics/claude-plugins-official) | plugin · `/claude-code-setup` | Reads a repo and recommends which MCP servers, skills, hooks and subagents fit it. Writes nothing until you approve. Run once per project. Apache-2.0. | 48k (repo) | **5** |
| [anthropics/skills → skill-creator](https://github.com/anthropics/skills) | skill · phrase "make a skill that…" | The official way to write your own `SKILL.md`. Take only this skill from the repo (`--skill skill-creator`); the docx/pptx/xlsx ones are already in Claude.ai. | 197k | **4** |
| [anthropics/knowledge-work-plugins](https://github.com/anthropics/knowledge-work-plugins) | plugin · `/data:*` `/marketing:*` `/sales:*` … | Eleven job-function plugins (data, marketing, sales, finance, legal, product, support…). Markdown + MCP connector JSON, no code, no hooks. `claude plugin marketplace add anthropics/knowledge-work-plugins && claude plugin install data@knowledge-work-plugins`. Apache-2.0. | 37k | **4** |
| [anthropics/defending-code-reference-harness](https://github.com/anthropics/defending-code-reference-harness) | skill + harness | Threat-modelling, scanning, triage and patching skills plus an autonomous scanning harness. Research-grade; read before running on a real repo. | 8k | 3 |

## Engineering workflow

| Tool | Type · Trigger | What it does | ★ | Rating |
| --- | --- | --- | --- | --- |
| [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) | skill · auto + `/spec` `/plan` `/build` `/test` `/review` `/ship` | 24 senior-engineer workflow skills by Addy Osmani with a router that picks the right one per task. Ships a controlled comparison against competing packs. MIT. | 98k | **5** |
| [obra/superpowers](https://github.com/obra/superpowers) | plugin · auto + `/superpowers:brainstorm` `write-plan` `execute-plan` | Jesse Vincent's brainstorm → spec → plan → TDD-with-subagents framework; the most-starred Claude Code plugin and the most opinionated — it will interview you before a one-line fix unless told not to. Fetches a logo from primeradiant.com with its version string; set `SUPERPOWERS_DISABLE_TELEMETRY=1`. MIT. | 321k | **4** |
| [mattpocock/skills](https://github.com/mattpocock/skills) | plugin · `/grill-me` `/to-spec` `/tdd` `/diagnosing-bugs` `/code-review` | Matt Pocock's à-la-carte engineering skills; `/grill-me` interviews you about a plan until the gaps show. On the official marketplace, self-updating. Run `/setup-matt-pocock-skills` once per repo. MIT. | 327k | **4** |
| [kenryu42/cc-safety-net](https://github.com/kenryu42/cc-safety-net) | hook · auto | Pre-execution guard: blocks `rm -rf` on dangerous paths, `git reset --hard`, force-pushes and reads of `.env`/`~/.ssh`/`~/.aws`, and tells the agent why. Not a sandbox, but the cheapest insurance on this list. Node 22+. MIT. | 2k | **4** |
| [vercel-labs/skills → find-skills](https://github.com/vercel-labs/skills) | skill · phrase "find a skill for…" | Lets Claude search skills.sh and install what a task needs. Useful, and the one entry here that installs other code on your say-so — read what it proposes. MIT. | 40k | **4** |
| [shadcn/improve](https://github.com/shadcn/improve) | skill · `/improve quick\|deep\|security\|execute` | Your strongest model audits the repo across nine categories and writes self-contained plans to `plans/`; a cheaper model executes them in a git worktree. Never edits source. MIT. | 9k | **4.5** |
| [DietrichGebert/ponytail](https://github.com/DietrichGebert/ponytail) | plugin · auto (SessionStart hook) + `/ponytail-review` | "Write less code" decision ladder: reuse → stdlib → native → dependency → build. The only token-saver here with an [independent JetBrains benchmark](https://blog.jetbrains.com/ai/2026/07/ponytail-skill-claude-tested/): −10% cost, −15% code, not the marketed −50%. MIT. | 144k | **4** |
| [HKUDS/CLI-Anything](https://github.com/HKUDS/CLI-Anything) | plugin · `/cli-anything <repo>` | HKU Data Science lab tool that generates a CLI + SKILL.md for any software with source or an API, so agents drive Blender, OBS, n8n without an MCP. Review generated CLIs before running. Apache-2.0. | 50k | **4** |
| [rebelytics/one-skill-to-rule-them-all](https://github.com/rebelytics/one-skill-to-rule-them-all) | skill · auto (CLAUDE.md line) | `task-observer` watches sessions and *proposes* skill improvements for you to approve — never edits on its own. CC BY 4.0. | 3k | **4** |
| [Onome-AJ/security-sweep-plugin](https://github.com/Onome-AJ/security-sweep-plugin) | plugin · `/security-sweep` | Pattern-based OWASP sweep. Tiny, no hooks, unusually honest README ("read patterns.md before trusting this"). Not a SAST replacement. MIT. | <100 | 3 |

## Front-end & design

| Tool | Type · Trigger | What it does | ★ | Rating |
| --- | --- | --- | --- | --- |
| [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills) | skill · auto ("review my UI") | `web-design-guidelines` audits UI against Vercel's published Web Interface Guidelines; `react-best-practices` has 40 severity-ranked rules. Official. | 31k | **5** |
| [Nutlope/hallmark](https://github.com/Nutlope/hallmark) | skill · phrase "use hallmark" + `sloplint` | Hassan El Mghari's anti-AI-slop design skill: 50 themes, hard rules against the beige-gradient look, and a `sloplint` checker that scores a page for generic-UI tells. v2 rebuilt from scratch. Reach for it first on a new page, Impeccable to fix an old one. MIT. | 57k | **5** |
| [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) | skill + cli · `/ui-ux-pro-max` | The most-starred design skill: style, palette, typography and UX-rule recommendations from an offline CSV searched by a stdlib-only Python script (no network). `npm i -g ui-ux-pro-max-cli && uipro init --ai claude --global`. MIT. | 151k | **4** |
| [pbakaus/impeccable](https://github.com/pbakaus/impeccable) | skill + hook · `/impeccable craft\|critique\|audit\|polish` | Paul Bakaus' anti-slop front-end rules plus a zero-API-cost detector that flags 61 generic-UI patterns after every edit. Run `/impeccable init` per project. Apache-2.0. | 70k | **4** |
| [emilkowalski/skills](https://github.com/emilkowalski/skills) | skill · auto | Animation, Apple-style UI and library-selection taste from the animations.dev author. MIT. | 40k | **4** |
| [VoltAgent/awesome-design-md](https://github.com/VoltAgent/awesome-design-md) | reference · manual | Drop-in `DESIGN.md` files distilled from Stripe, Airbnb, Revolut, Kraken etc. Copy one into a project root. Plain text, zero risk. MIT. | 117k | **4** |
| [MengTo/threeui](https://github.com/MengTo/threeui) · [threeui.com](https://threeui.com) | reference · copy prompt | 160+ free three.js hero sections and shaders, each with a copy-paste agent prompt. Pro tier exists; free tier is real. | — | **4** |
| [greensock/gsap-skills](https://github.com/greensock/gsap-skills) | skill · auto | GSAP's official skills (core, ScrollTrigger, timelines). Only fires when you ask for animation. MIT. | 19k | **4** |
| [jakubkrehel/skills](https://github.com/jakubkrehel/skills) · [make-interfaces-feel-better](https://github.com/jakubkrehel/make-interfaces-feel-better) | skill · auto | Interface-craft skills; MIFB polishes spacing, shadows, hover and focus states. Overlaps Emil's, narrower and newer. MIT. | 12k / 4k | **4** |
| [zarazhangrui/frontend-slides](https://github.com/zarazhangrui/frontend-slides) | skill · phrase "make a slide deck" | Slide decks as web pages using the agent's front-end skills. MIT. | 33k | **4** |
| [Leonxlnx/taste-skill](https://github.com/Leonxlnx/taste-skill) | skill · auto | Design references for less generic UI. Largely a remix of the two above; several forks share the name — install this exact repo. MIT. | 92k | 3.5 |
| [beautifului.dev](https://www.beautifului.dev) | shadcn registry · per component | 20 MIT React/Tailwind v4 primitives for agent UIs (streaming text, approval cards, tool chips). Studio lead magnet; one component pulls a commercial icon set. | <300 | 3 |

## Browser, testing & integrations

| Tool | Type · Trigger | What it does | ★ | Rating |
| --- | --- | --- | --- | --- |
| [microsoft/playwright-mcp](https://github.com/microsoft/playwright-mcp) · [playwright-cli](https://github.com/microsoft/playwright-cli) | mcp / cli · auto | Official. Claude opens the site it built, screenshots, clicks through flows. Microsoft now points coding agents at the CLI as the token-cheap path. Apache-2.0. | 37k / 13k | **5** |
| [ChromeDevTools/chrome-devtools-mcp](https://github.com/ChromeDevTools/chrome-devtools-mcp) | mcp · auto | Google's official DevTools server: console errors, network waterfalls, performance traces, screenshots. Complements Playwright MCP; keep one enabled per project or the agent dithers. Apache-2.0. | 58k | **4** |
| [Figma Dev Mode MCP](https://developers.figma.com/docs/figma-mcp-server) | mcp · auto | Official Figma server; needs the desktop app in Dev Mode. | official | **5** |
| [tester-army/e2e](https://github.com/tester-army/e2e) | cli · `npx e2e init` | Describe a test in English; an agent drives it once through Playwright, then recorded steps replay with no model calls until the UI changes. Pre-1.0, hosted upsell. Apache-2.0. | 9k | 3 |
| [heygen-com/hyperframes](https://github.com/heygen-com/hyperframes) | skill · auto | "Write HTML, render video": deterministic MP4 from HTML timelines, built for agents. Expect HeyGen hosted upsell. Apache-2.0. | 52k | **4** |
| [cloudflare/agentic-inbox](https://github.com/cloudflare/agentic-inbox) | app · self-host | Cloudflare's own Workers-based AI mail client. Apache-2.0. Check activity before adopting. | 8k | **4** |

## Security

| Tool | Type · Trigger | What it does | ★ | Rating |
| --- | --- | --- | --- | --- |
| [cloudflare/security-audit-skill](https://github.com/cloudflare/security-audit-skill) | skill · `/security-audit` | Cloudflare's multi-phase audit — recon, hunting by attack class, independent validation — with zero-dependency Node validators that refuse unverified findings. `npx skills add https://github.com/cloudflare/security-audit-skill --skill security-audit --global`. MIT. | 75k | **5** |
| [trailofbits/skills](https://github.com/trailofbits/skills) | skill · auto | Trail of Bits' vulnerability-research and audit skills (semgrep, CodeQL, fuzzing workflows). For auditing other people's code. CC BY-SA 4.0. | 8k | **4** |
| [kenryu42/cc-safety-net](https://github.com/kenryu42/cc-safety-net) | hook · auto | See Engineering workflow — listed twice because it is the one thing to install before anything else. | 2k | **4** |

Not listed: the half-dozen 200–600-star "OWASP skill" repos that circulate in ranked videos. Everything they do, the two above do with validators.

## Memory, context & token cost

| Tool | Type · Trigger | What it does | ★ | Rating |
| --- | --- | --- | --- | --- |
| [thedotmack/claude-mem](https://github.com/thedotmack/claude-mem) | plugin · auto | Persistent cross-session memory; injects a ~100-token index at start and pulls detail on demand. Keep optional cloud sync off (`CLAUDE_MEM_ONLINE_OPTIN=false`). Apache-2.0. | 99k | **4** |
| [headroomlabs-ai/headroom](https://github.com/headroomlabs-ai/headroom) | cli / proxy | Compresses tool output locally; publishes per-task benchmarks (21–57%) instead of one headline. For Claude Code it runs as a local proxy — opt in knowingly. Apache-2.0. | 73k | **4** |
| [Graphify-Labs/graphify](https://github.com/Graphify-Labs/graphify) | skill + cli · `/graphify .` | Tree-sitter knowledge graph of a repo (local, deterministic). Install only from the Graphify-Labs org — dozens of identical forks exist. Apache-2.0/MIT. | 120k | 3 |
| [Egonex-AI/Understand-Anything](https://github.com/Egonex-AI/Understand-Anything) | plugin · `/understand` `/understand-dashboard` | Interactive knowledge graph of a repo with a local dashboard and Q&A. Better teaching output than graphify, but the first run is token-heavy — try it on a small repo. MIT. | 93k | **4** |
| [Manavarya09/cost-guardian](https://github.com/Manavarya09/cost-guardian) | plugin · auto | Local per-session cost dashboard, no telemetry. Small and unaudited. MIT. | <100 | 3 |
| [JuliusBrussee/caveman](https://github.com/juliusbrussee/caveman) | skill (+ optional proxy) | Terse-output skill is harmless and free. The proxy mode is a local MITM on agent traffic under BSL-1.1 with telemetry on by default — skill only. | 107k | 3 |

## Decision-making & research

| Tool | Type · Trigger | What it does | ★ | Rating |
| --- | --- | --- | --- | --- |
| [aiwithremy/claude-skills-llm-council](https://github.com/aiwithremy/claude-skills-llm-council) | skill · phrase "council this" | Karpathy-style LLM Council: five advisor personas, blind peer review, chairman verdict that keeps dissent. 5–10× tokens — for real decisions only. MIT. | 2k | **4** |
| [mvanhorn/last30days-skill](https://github.com/mvanhorn/last30days-skill) | skill · `/last30days <topic>` | Searches Reddit, HN, GitHub and Polymarket with no keys (X, YouTube with optional keys) over the last 30 days and returns a sourced, engagement-ranked summary. No tracking. Python 3.12+. MIT. | 70k | **4** |
| [0xNyk/council-of-high-intelligence](https://github.com/0xNyk/council-of-high-intelligence) | skill · slash | The other credible "council" implementation; the name is shared by a dozen one-star clones. | 4k | 3.5 |
| [K-Dense-AI/scientific-agent-skills](https://github.com/K-Dense-AI/scientific-agent-skills) | skill · auto | 177 science skills; the ~18 data/stats ones (EDA, statsmodels, scikit-learn, PyMC, Polars) are worth cherry-picking. Soft funnel to the company's hosted platform. MIT. | 48k | 3 |
| [ai-boost/awesome-harness-engineering](https://github.com/ai-boost/awesome-harness-engineering) | reading list | CC0 curated sources on the scaffolding around agents (OpenAI, Anthropic, Fowler). | 5k | 3 |

## Marketing & SEO

| Tool | Type · Trigger | What it does | ★ | Rating |
| --- | --- | --- | --- | --- |
| [AgriciDaniel/claude-seo](https://github.com/AgriciDaniel/claude-seo) | plugin · `/seo page\|technical\|schema\|geo\|audit` | 25 sub-skills + 18 agents; most commands need no API keys; free Google key unlocks Core Web Vitals; drift monitoring baselines a site and diffs after deploys. 410 tests, no telemetry. MIT. | 18k | **4** |
| [blader/humanizer](https://github.com/blader/humanizer) | skill · phrase "humanize this" | Strips the tells of AI-written prose (em-dash chains, triads, mirrored sentences). Single markdown file. MIT. | 71k | **4** |
| [sergebulaev/linkedin-skills](https://github.com/sergebulaev/linkedin-skills) | skill · `/linkedin-post` `/linkedin-comment` `/linkedin-profile` `/linkedin-week` | Twelve LinkedIn skills with a built-in humanizer pass. Drafts only; it never posts. MIT. | 6k | **4** |
| [coreyhaines31/marketingskills](https://github.com/coreyhaines31/marketingskills) | skill · auto + `/cro` `/seo-audit` `/pricing-strategy` | ~40 marketing playbooks from a CRO agency founder. Advisory, well-structured; README funnels to his agency and two paid sponsors. Install with `-a claude-code`. MIT. | 53k | 3.5 |

## Diagrams, video & media

| Tool | Type · Trigger | What it does | ★ | Rating |
| --- | --- | --- | --- | --- |
| [cathrynlavery/diagram-design](https://github.com/cathrynlavery/diagram-design) | plugin · auto + slash | 42 editorial diagram types as self-contained HTML with SVG/PNG export and Mermaid/draw.io re-render. No hooks, no paid tier. MIT. | 50k | **4** |
| [bradautomates/claude-video](https://github.com/bradautomates/claude-video) | plugin · `/watch <url>` | Downloads, extracts frames and transcribes a video so Claude can answer questions about it. Captions free; Whisper optional. MIT. | 18k | 3.5 |

## Finance, trading & on-chain

The rule for this section is different from the rest of the list: **read-only first, paper by default, and nothing that wants a wallet private key in a config file.** Every entry below is either first-party or cannot place an order without a typed confirmation.

| Tool | Type · Trigger | What it does | ★ | Rating |
| --- | --- | --- | --- | --- |
| [CoinGecko MCP](https://docs.coingecko.com/docs/mcp-server) | mcp · auto | Official, hosted, keyless: prices, market caps, volumes, trending, exchange and DEX-pool data. `claude mcp add --transport http coingecko https://mcp.api.coingecko.com/mcp`. Read-only. | official | **5** |
| [Jakeschincariol/day-trader-skill](https://github.com/Jakeschincariol/day-trader-skill) | plugin · `/trader-scanner` `/trader-entry` `/trader-timemachine` `/trader-pelosi` … | The viral 11-skill pack is better than its hype: ten skills run on Yahoo and SEC data with no key, the "time machine" replays a plan over thousands of past setups, and the only order path (`trader-broker`) goes through Alpaca's MCP with paper on and a typed yes per trade. Leave Alpaca unconfigured and it is pure analysis. MIT. | 9k | **4** |
| [tradermonty/claude-trading-skills](https://github.com/tradermonty/claude-trading-skills) | skill · auto | Market regime, screeners, portfolio review, risk and a trade journal for equity investors. Human decision gates, no execution; optional FMP/FINVIZ data. MIT. | 7k | **4** |
| [staskh/trading_skills → technical-analysis](https://github.com/staskh/trading_skills) | skill · `uv run technicals.py SYMBOL` | RSI, MACD, Bollinger, ATR, ADX and correlation from pandas-ta on delayed Yahoo data, JSON out. The clean TA primitive. MIT. | 400 | **4** |
| [anthropics/financial-services](https://github.com/anthropics/financial-services) | plugin · auto | Anthropic's own finance agents: equity research, 3-statement models, memos, earnings reviews; every output staged for sign-off. `claude plugin marketplace add anthropics/financial-services && claude plugin install financial-analysis@claude-for-financial-services`. Apache-2.0. | 41k | **4** |
| [Blockscout MCP](https://github.com/blockscout/mcp-server) | mcp · auto | Official hosted explorer data for EVM chains: balances, transactions, tokens, ABIs, view calls. Free PRO key, credit-metered, read-only. | official | **4** |
| [Dune MCP](https://dune.com/blog/dune-mcp) | mcp · auto | Natural-language DuneSQL over 100+ chains with tables and charts back. Needs a Dune API key and bills its credits; read-only. | official | **4** |
| [agiprolabs/claude-trading-skills](https://github.com/agiprolabs/claude-trading-skills) | skill · auto | 68 skills: DexScreener, DeFiLlama, Birdeye, Helius data; pandas-ta, vectorbt, backtrader, walk-forward, Kelly, whale-tracking. Also ships `dex-execution` and `jito-bundles` — copy the data and quant folders and leave those out. MIT. | 600 | 3.5 |
| [alpacahq/alpaca-mcp-server](https://github.com/alpacahq/alpaca-mcp-server) | mcp · auto | Alpaca's official broker MCP for US stocks, crypto and options. `ALPACA_PAPER_TRADE` defaults to true and `ALPACA_TOOLSETS` can hide the order tools. The right first broker connector. MIT. | 1k | **4** (paper) |
| [krakenfx/kraken-cli](https://github.com/krakenfx/kraken-cli) · [okx/agent-trade-kit](https://github.com/okx/agent-trade-kit) | cli + mcp | Exchange-built connectors. Kraken's `market` and `paper` toolsets need no account (`-s market,paper`); OKX has `--read-only`. Live is one flag away in both, so set the safe one on purpose. MIT. | 800 / 500 | 3.5 |
| [Nansen MCP](https://docs.nansen.ai/mcp/overview) · [Helius MCP](https://www.helius.dev/blog/helius-for-agents) | mcp · auto | Official. Nansen: Smart Money labels, flows, wallet PnL, cannot trade by design, paid credits. Helius: 60+ Solana tools including transaction sending — give it a key with nothing behind it. | official | **4** / 3.5 |
| [LLMQuant/awesome-trading-agents](https://github.com/LLMQuant/awesome-trading-agents) | reading list | The best map of LLM trading agents, MCP servers and skills. CC0. Vets nothing about safety defaults; this section does. | 1k | 3 |

## Reference repos worth bookmarking

Nothing to install; clone patterns from them.

- [Shubhamsaboo/awesome-llm-apps](https://github.com/Shubhamsaboo/awesome-llm-apps) — 100+ agent/RAG/MCP example apps by a Google Cloud AI PM. Tutorials, not "production-ready". 139k ★
- [awesomedata/awesome-public-datasets](https://github.com/awesomedata/awesome-public-datasets) — topic-sorted open datasets, maintained since 2014. 79k ★
- [danny-avila/LibreChat](https://github.com/danny-avila/LibreChat) — the mature self-hosted multi-model chat UI with MCP support. 45k ★
- [aidesign.guide/design-systems](https://www.aidesign.guide/design-systems) — 180+ design systems and component libraries tagged by which expose MCP, skills or `llms.txt`. Browse-only.
- [AI Parabellum Claude Code Skills Directory](https://www.aiparabellum.com) — 500+ skills and plugins with install commands and "we tested it" badges. Browse-only.
- [skills.sh](https://skills.sh) — Vercel's "npm for agent skills"; the `npx skills add` installer used throughout this list. Like npm, anyone can publish: read a SKILL.md before adding it.

---

## Try with caveats

Real projects, each with one thing the hype left out.

| Tool | The catch | Rating |
| --- | --- | --- |
| [mksglu/context-mode](https://github.com/mksglu/context-mode) | "98% less context" is a best case; Elastic Licence v2; passes through `gh`/`aws`/`kubectl` credentials. | 3 |
| [vectorize-io/hindsight](https://github.com/vectorize-io/hindsight) | Serious memory system, but the LongMemEval score is vendor-run, it needs Postgres + an LLM call per capture, and the "use your Claude login" provider is a terms-of-service grey area. | 3.5 |
| [trycua/cua](https://github.com/trycua/cua) | Excellent cross-OS computer-use infra (YC). An agent with your mouse acts in every logged-in session — VM or spare account only. Install script is `irm … | iex`. | 3.5 |
| [affaan-m/ECC](https://github.com/affaan-m/ECC) | 277k ★, 68 agents, 293 skills, and hooks that run Prettier + `tsc` on every edit plus a cost tracker that "emits telemetry markers". Duplicates everything above; $19/seat Pro. Try `--profile minimal` if curious. | 3 |
| [garrytan/gstack](https://github.com/garrytan/gstack) | 142k ★ and genuinely good role tools, but it ships compiled unsigned binaries, builds a bundled Chromium, can copy your browser cookies, and sends code to Codex for "outside reviews" **by default** (`gstack-config set codex_reviews disabled`). README calls Windows support minimal. WSL or Mac, read `setup` first. | 3 |
| [tt-a1i/archify](https://github.com/tt-a1i/archify) | Excellent idea-to-diagram skill (98k ★) that duplicates diagram-design; its update checker sends your IP (`ARCHIFY_UPDATE_CHECK_DISABLED=1`). | 3 |
| [Jakubantalik/transitions.dev](https://github.com/Jakubantalik/transitions.dev) | 43 crafted UI transitions as a skill; no SPDX licence declared, so check before shipping. | 3 |
| [PleasePrompto/notebooklm-skill](https://github.com/PleasePrompto/notebooklm-skill) | Drives NotebookLM through browser automation with your Google login — convenient, and exactly the pattern to be careful with. | 3 |
| [kalil0321/reverse-api-engineer](https://github.com/kalil0321/reverse-api-engineer) | Records browser traffic and writes a typed API client. Works; the target site's terms may not agree. | 3 |
| [img2threejs/img2threejs](https://github.com/img2threejs/img2threejs) · [NiazMorshed2007/reanimate](https://github.com/NiazMorshed2007/reanimate) · [juliobsz/skills](https://github.com/juliobsz/skills) | Photo → Three.js code, animation reverse-engineering, and an "award-site from one line" skill. All real, all niche, the last two weeks old. | 3 |
| [bybit-exchange/trading-mcp](https://github.com/bybit-exchange/trading-mcp) | 396 Bybit V5 tools in Bybit's own GitHub org, but 44 ★, maintainer status unstated and `BYBIT_TESTNET` defaults to **false**. Testnet plus a read-only key, or use ccxt. | 3 |
| [TraderAlice/OpenAlice](https://github.com/TraderAlice/OpenAlice) | The most careful of the "AI trades for you" apps: research, scheduled tasks and trades staged like git commits that you approve. Experimental, AGPL; paper accounts only. | 3.5 |
| [tigerless-labs/autoharness](https://github.com/tigerless-labs/autoharness) | Turns sessions into skills automatically — task-observer without the approval step. Scratch repo first. | 3 |
| [NangoHQ/nango](https://github.com/NangoHQ/nango) | 1,000+ OAuth connectors; "open source" is Elastic Licence and self-host feature parity is unclear. | 3.5 |
| [nexu-io/open-design](https://github.com/nexu-io/open-design) | Big "Claude Design alternative" with an image-to-code skill; its third-party listing pages are ad/affiliate-laden — get it from GitHub only. | 3 |
| [katipally/openlive](https://github.com/katipally/openlive) | On-device voice that drives Claude Code and approves permissions aloud. Young; read the code before giving it your session. | 2 |

## Hype check: popular but not worth installing

The section the "10 plugins you NEED" posts never include. Nothing here is malware; each one fails on terms-of-service risk, a funnel dressed as a tool, a dishonest claim, or being redundant with a better option above. Several have more stars than anything in the recommended tables.

| Tool | Why | ★ |
| --- | --- | --- |
| [diegosouzapw/OmniRoute](https://github.com/diegosouzapw/OmniRoute) | Pools 300 providers' free tiers behind one endpoint; every key routes through it; "1.6B free tokens/month" is the sum of everyone's free tiers; proxying subscription access breaks provider terms; a CVE was referenced in independent coverage. | 69k |
| [Panniantong/Agent-Reach](https://github.com/Panniantong/Agent-Reach) | Reads X/Reddit/LinkedIn "without API keys" because it scrapes with your exported login cookies — a documented account-ban pattern. Installs by having the agent fetch and execute a remote script. | 96k |
| [multica-ai/andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills) | 219k ★ for one CLAUDE.md with four generic principles; no Karpathy endorsement; promotes the author's product. Ponytail + agent-skills already enforce the same. | 219k |
| [mukul975/Anthropic-Cybersecurity-Skills](https://github.com/mukul975/Anthropic-Cybersecurity-Skills) | Not by Anthropic — the README says so. 817 skills including offensive ones; brand-borrowing plus context noise. | 34k |
| [volcengine/OpenViking](https://github.com/volcengine/OpenViking) | ByteDance context DB; AGPL, licence key for self-managed, needs an embedding model + VLM. claude-mem covers the use case. | 40k |
| [browser-use/browser-use](https://github.com/browser-use/browser-use) | Fine library, but an LLM-in-the-loop browser is slower and dearer than Playwright MCP for the same jobs; cloud browsers are the product. | 118k |
| [midudev/autoskills](https://github.com/midudev/autoskills) | Bulk-installs 200+ skills you have not read; CC BY-NC licence; inactive. | 7k |
| [lharries/whatsapp-mcp](https://github.com/lharries/whatsapp-mcp) · [GOWA](https://github.com/aldinokemal/go-whatsapp-web-multidevice) | Both use the unofficial whatsmeow library that WhatsApp bans accounts for; the MCP one is stale and its README warns about prompt-injection exfiltration of your chats. | 6k / 5k |
| [JCodesMore/ai-website-cloner-template](https://github.com/JCodesMore/ai-website-cloner-template) | "Clone any website with one command." 39k ★ for a copyright problem with a README. | 39k |
| [oso95/scroll-world](https://github.com/oso95/scroll-world) | Brand → 3D scroll landing page. One trick, idle since July. | 11k |
| "Top 10 Claude/Codex skills ranked by stars" videos | The same 15 repos recycled across creators with on-screen star counts that are weeks stale. Every repo they show is already rated here. | — |
| [edkdev/defi-trading-mcp](https://github.com/edkdev/defi-trading-mcp) | Wants `USER_PRIVATE_KEY` in the MCP env, runs an unpinned `npx …@latest`, and executes swaps with no confirmation step. Three disqualifiers in one README. | <100 |
| "Non-toxic order" skills for arbitrage accounts | Nine skills whose stated purpose is to pad an account with decoy trades so a broker reviews your flow less. The README says whether your broker allows it is your problem. | <10 |
| OpenClaw crypto / trading skill directories, paid "trading skill" marketplaces | A different agent runtime with x402 pay-per-call, 125x-leverage bots and self-ratings around 2/5; marketplaces selling $3–$28 skills with "autonomous 24/7 signal daemons" and zero evidence scores on their own top picks. Install from GitHub, never from a directory. | — |
| [Polymarket/agents](https://github.com/Polymarket/agents) | Archived May 2026 with the wallet private key in `.env`. | 4k |
| [durchnull/observe](https://github.com/durchnull/observe) | Safe but 0 ★, one author; task-observer does the job with a community. | 0 |
| [ChatGPTNextWeb/NextChat](https://github.com/ChatGPTNextWeb/NextChat) | Self-hostable client is fine; the "no API key" pitch is the hosted credits reseller. | 89k |
| [NVIDIA/Personal-AI-Router](https://github.com/NVIDIA/Personal-AI-Router) | Routes requests between Ollama/LM Studio boxes on a LAN; no GPU pooling; nothing for Claude Code. | 2k |
| "Nemotron Ultra + Ollama = Claude Code free forever" | The model is 550B params (~275 GB VRAM); what runs is Ollama Cloud on starter credits, then per-token billing. Real technique, false framing. | — |
| [mcpmarket.com](https://mcpmarket.com) · [VoltAgent/official-mcp-servers](https://github.com/VoltAgent/official-mcp-servers) | Directories with one-click deploys and paid listings, no vetting. Browse if you like; install from the upstream repo with `claude mcp add`. | — |
| [originkit.dev](https://www.originkit.dev) | Animated components behind a paywall (10 copies/day free), maker unnamed, code fetched from their server. ThreeUI covers it in the open. | — |
| Apify "2,000 production APIs" catalogs, "top 10 MCP connectors" Google Docs, "comment X for the link" DMs | Affiliate catalogs and lead magnets. The tools they gate are all searchable in a minute. | — |

---

## How installs work

Four mechanisms, from safest to most invasive:

1. **Skills** — markdown files Claude reads. `npx skills@latest add owner/repo -g -a claude-code -y`. Zero execution surface; inspect with `cat ~/.claude/skills/<name>/SKILL.md`.
2. **Plugins** — skills plus commands and sometimes **hooks** (scripts that run on session start, before/after tool calls). `claude plugin marketplace add owner/repo` then `claude plugin install name@marketplace`. Hooks are the thing to read before enabling.
3. **MCP servers** — separate processes Claude talks to. `claude mcp add name -s user -- <command>`. On Windows wrap npx commands with `cmd /c`.
4. **Proxies** — sit between Claude Code and the API (Headroom, Caveman proxy mode, OmniRoute). Highest trust requirement; only two on this list are worth it, and both are opt-in.

Inside a Claude Code session the same actions are slash commands (`/plugin marketplace add …`); in a terminal use the `claude plugin …` form. Open a new session after installing so hooks load.

**Windows notes** (hard-won): put `~\.local\bin`, `%APPDATA%\npm` and `C:\Program Files\Git\bin` on PATH; MCP servers launched via npx need `cmd /c`; if `claude plugin marketplace add` fails with `EBUSY` on `~\.claude\plugins\marketplaces`, antivirus is scanning the fresh clone — `git clone` elsewhere and `claude plugin marketplace add <local path>`.

## Safety checklist before installing anything

- [ ] Read the SKILL.md. It is instructions your agent will follow with your permissions.
- [ ] Does it ship **hooks**? Read them. Does it ship an **MCP server**? What credentials can it see?
- [ ] Does it **proxy** your traffic or hold your API keys? Treat as a separate trust decision.
- [ ] Does it need you to export **login cookies** or reuse your subscription login? That is a terms-of-service risk on *your* account.
- [ ] Licence: MIT/Apache are safe; BSL, Elastic, AGPL and CC BY-NC have strings.
- [ ] Telemetry default: is there an off switch, and is it documented?
- [ ] Stars vs substance: check last push date and open-issue count, not the star count. Several 100k+ repos are in Hype check.
- [ ] Install from the upstream repo, never from a directory's "deploy" button.

## Contributing

PRs welcome — one tool per PR, using the [issue template](.github/ISSUE_TEMPLATE/new-tool.md) fields: repo, licence, what it does, how it triggers, any hooks/proxy/credential needs, and evidence for the claim (benchmarks, independent reviews). Ratings are argued, not voted. See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

[CC0 1.0](LICENSE) — do whatever you want with this list. The tools linked keep their own licences.
