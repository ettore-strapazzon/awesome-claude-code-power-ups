# Awesome Claude Code Power-Ups

> A vetted, opinionated list of the Claude Code **skills, plugins, MCP servers and hooks** that are actually worth installing — with star counts verified against the GitHub API, licence and security notes, install commands, and the hype-vs-reality verdict for each.

[![Awesome](https://awesome.re/badge.svg)](https://awesome.re)
![Tools reviewed](https://img.shields.io/badge/tools%20reviewed-76-blue)
![Recommended](https://img.shields.io/badge/recommended-27-brightgreen)
![Last review](https://img.shields.io/badge/last%20review-Oct%202026-informational)
![License: CC0](https://img.shields.io/badge/license-CC0--1.0-lightgrey)

Every entry here was pulled from the firehose of "10 Claude Code plugins you NEED" posts, then checked the boring way: README read in full, hooks and scripts inspected, stars and last-push date pulled from the GitHub API, licence confirmed, and the marketing claim compared with independent measurements where any exist. Tools that failed the check are listed too — in the **Hype check** section — because knowing what *not* to install is half the value.

**Scope:** things that plug into [Claude Code](https://docs.anthropic.com/en/docs/claude-code) (and usually Codex, Cursor and Gemini CLI via the same `SKILL.md` format). Not a list of every AI repo on GitHub.

---

## Contents

- [How to read this list](#how-to-read-this-list)
- [Quick start: the 20-minute install](#quick-start-the-20-minute-install)
- [Engineering workflow](#engineering-workflow)
- [Front-end & design](#front-end--design)
- [Browser, testing & integrations](#browser-testing--integrations)
- [Memory, context & token cost](#memory-context--token-cost)
- [Decision-making & research](#decision-making--research)
- [Marketing & SEO](#marketing--seo)
- [Diagrams, video & media](#diagrams-video--media)
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

If you only do one thing, install these in this order. All are MIT/Apache, from accountable authors, and five of the seven are plain markdown.

```bash
# skills (markdown only, no hooks)
npx skills@latest add addyosmani/agent-skills -g -a claude-code -y --skill '*'
npx skills@latest add vercel-labs/agent-skills -g -a claude-code -y --skill web-design-guidelines react-best-practices
npx skills@latest add emilkowalski/skills -g -a claude-code -y --skill '*'
npx skills@latest add pbakaus/impeccable -g -a claude-code -y --skill '*'
npx skills@latest add shadcn/improve -g -a claude-code -y

# official browser automation
claude mcp add playwright -s user -- npx -y @playwright/mcp@latest      # Windows: prefix the command with  cmd /c
npx playwright install chromium

# diagrams
claude plugin marketplace add cathrynlavery/diagram-design && claude plugin install diagram-design@diagram-design
```

Then open a fresh `claude` session and type `/` to see what arrived.

---

## Engineering workflow

| Tool | Type · Trigger | What it does | ★ | Rating |
| --- | --- | --- | --- | --- |
| [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) | skill · auto + `/spec` `/plan` `/build` `/test` `/review` `/ship` | 24 senior-engineer workflow skills by Addy Osmani with a router that picks the right one per task. Ships a controlled comparison against competing packs. MIT. | 98k | **5** |
| [shadcn/improve](https://github.com/shadcn/improve) | skill · `/improve quick\|deep\|security\|execute` | Your strongest model audits the repo across nine categories and writes self-contained plans to `plans/`; a cheaper model executes them in a git worktree. Never edits source. MIT. | 9k | **4.5** |
| [DietrichGebert/ponytail](https://github.com/DietrichGebert/ponytail) | plugin · auto (SessionStart hook) + `/ponytail-review` | "Write less code" decision ladder: reuse → stdlib → native → dependency → build. The only token-saver here with an [independent JetBrains benchmark](https://blog.jetbrains.com/ai/2026/07/ponytail-skill-claude-tested/): −10% cost, −15% code, not the marketed −50%. MIT. | 144k | **4** |
| [HKUDS/CLI-Anything](https://github.com/HKUDS/CLI-Anything) | plugin · `/cli-anything <repo>` | HKU Data Science lab tool that generates a CLI + SKILL.md for any software with source or an API, so agents drive Blender, OBS, n8n without an MCP. Review generated CLIs before running. Apache-2.0. | 50k | **4** |
| [rebelytics/one-skill-to-rule-them-all](https://github.com/rebelytics/one-skill-to-rule-them-all) | skill · auto (CLAUDE.md line) | `task-observer` watches sessions and *proposes* skill improvements for you to approve — never edits on its own. CC BY 4.0. | 3k | **4** |
| [Onome-AJ/security-sweep-plugin](https://github.com/Onome-AJ/security-sweep-plugin) | plugin · `/security-sweep` | Pattern-based OWASP sweep. Tiny, no hooks, unusually honest README ("read patterns.md before trusting this"). Not a SAST replacement. MIT. | <100 | 3 |

## Front-end & design

| Tool | Type · Trigger | What it does | ★ | Rating |
| --- | --- | --- | --- | --- |
| [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills) | skill · auto ("review my UI") | `web-design-guidelines` audits UI against Vercel's published Web Interface Guidelines; `react-best-practices` has 40 severity-ranked rules. Official. | 31k | **5** |
| [pbakaus/impeccable](https://github.com/pbakaus/impeccable) | skill + hook · `/impeccable craft\|critique\|audit\|polish` | Paul Bakaus' anti-slop front-end rules plus a zero-API-cost detector that flags 61 generic-UI patterns after every edit. Run `/impeccable init` per project. Apache-2.0. | 70k | **4** |
| [emilkowalski/skills](https://github.com/emilkowalski/skills) | skill · auto | Animation, Apple-style UI and library-selection taste from the animations.dev author. MIT. | 40k | **4** |
| [VoltAgent/awesome-design-md](https://github.com/VoltAgent/awesome-design-md) | reference · manual | Drop-in `DESIGN.md` files distilled from Stripe, Airbnb, Revolut, Kraken etc. Copy one into a project root. Plain text, zero risk. MIT. | 117k | **4** |
| [MengTo/threeui](https://github.com/MengTo/threeui) · [threeui.com](https://threeui.com) | reference · copy prompt | 160+ free three.js hero sections and shaders, each with a copy-paste agent prompt. Pro tier exists; free tier is real. | — | **4** |
| [Leonxlnx/taste-skill](https://github.com/Leonxlnx/taste-skill) | skill · auto | Design references for less generic UI. Largely a remix of the two above; several forks share the name — install this exact repo. MIT. | 92k | 3.5 |
| [beautifului.dev](https://www.beautifului.dev) | shadcn registry · per component | 20 MIT React/Tailwind v4 primitives for agent UIs (streaming text, approval cards, tool chips). Studio lead magnet; one component pulls a commercial icon set. | <300 | 3 |

## Browser, testing & integrations

| Tool | Type · Trigger | What it does | ★ | Rating |
| --- | --- | --- | --- | --- |
| [microsoft/playwright-mcp](https://github.com/microsoft/playwright-mcp) · [playwright-cli](https://github.com/microsoft/playwright-cli) | mcp / cli · auto | Official. Claude opens the site it built, screenshots, clicks through flows. Microsoft now points coding agents at the CLI as the token-cheap path. Apache-2.0. | 37k / 13k | **5** |
| [Figma Dev Mode MCP](https://developers.figma.com/docs/figma-mcp-server) | mcp · auto | Official Figma server; needs the desktop app in Dev Mode. | official | **5** |
| [tester-army/e2e](https://github.com/tester-army/e2e) | cli · `npx e2e init` | Describe a test in English; an agent drives it once through Playwright, then recorded steps replay with no model calls until the UI changes. Pre-1.0, hosted upsell. Apache-2.0. | 9k | 3 |
| [heygen-com/hyperframes](https://github.com/heygen-com/hyperframes) | skill · auto | "Write HTML, render video": deterministic MP4 from HTML timelines, built for agents. Expect HeyGen hosted upsell. Apache-2.0. | 52k | **4** |
| [cloudflare/agentic-inbox](https://github.com/cloudflare/agentic-inbox) | app · self-host | Cloudflare's own Workers-based AI mail client. Apache-2.0. Check activity before adopting. | 8k | **4** |

## Memory, context & token cost

| Tool | Type · Trigger | What it does | ★ | Rating |
| --- | --- | --- | --- | --- |
| [thedotmack/claude-mem](https://github.com/thedotmack/claude-mem) | plugin · auto | Persistent cross-session memory; injects a ~100-token index at start and pulls detail on demand. Keep optional cloud sync off (`CLAUDE_MEM_ONLINE_OPTIN=false`). Apache-2.0. | 99k | **4** |
| [headroomlabs-ai/headroom](https://github.com/headroomlabs-ai/headroom) | cli / proxy | Compresses tool output locally; publishes per-task benchmarks (21–57%) instead of one headline. For Claude Code it runs as a local proxy — opt in knowingly. Apache-2.0. | 73k | **4** |
| [Graphify-Labs/graphify](https://github.com/Graphify-Labs/graphify) | skill + cli · `/graphify .` | Tree-sitter knowledge graph of a repo (local, deterministic). Install only from the Graphify-Labs org — dozens of identical forks exist. Apache-2.0/MIT. | 120k | 3 |
| [Manavarya09/cost-guardian](https://github.com/Manavarya09/cost-guardian) | plugin · auto | Local per-session cost dashboard, no telemetry. Small and unaudited. MIT. | <100 | 3 |
| [JuliusBrussee/caveman](https://github.com/juliusbrussee/caveman) | skill (+ optional proxy) | Terse-output skill is harmless and free. The proxy mode is a local MITM on agent traffic under BSL-1.1 with telemetry on by default — skill only. | 107k | 3 |

## Decision-making & research

| Tool | Type · Trigger | What it does | ★ | Rating |
| --- | --- | --- | --- | --- |
| [aiwithremy/claude-skills-llm-council](https://github.com/aiwithremy/claude-skills-llm-council) | skill · phrase "council this" | Karpathy-style LLM Council: five advisor personas, blind peer review, chairman verdict that keeps dissent. 5–10× tokens — for real decisions only. MIT. | 2k | **4** |
| [0xNyk/council-of-high-intelligence](https://github.com/0xNyk/council-of-high-intelligence) | skill · slash | The other credible "council" implementation; the name is shared by a dozen one-star clones. | 4k | 3.5 |
| [K-Dense-AI/scientific-agent-skills](https://github.com/K-Dense-AI/scientific-agent-skills) | skill · auto | 177 science skills; the ~18 data/stats ones (EDA, statsmodels, scikit-learn, PyMC, Polars) are worth cherry-picking. Soft funnel to the company's hosted platform. MIT. | 48k | 3 |
| [ai-boost/awesome-harness-engineering](https://github.com/ai-boost/awesome-harness-engineering) | reading list | CC0 curated sources on the scaffolding around agents (OpenAI, Anthropic, Fowler). | 5k | 3 |

## Marketing & SEO

| Tool | Type · Trigger | What it does | ★ | Rating |
| --- | --- | --- | --- | --- |
| [AgriciDaniel/claude-seo](https://github.com/AgriciDaniel/claude-seo) | plugin · `/seo page\|technical\|schema\|geo\|audit` | 25 sub-skills + 18 agents; most commands need no API keys; free Google key unlocks Core Web Vitals; drift monitoring baselines a site and diffs after deploys. 410 tests, no telemetry. MIT. | 18k | **4** |
| [coreyhaines31/marketingskills](https://github.com/coreyhaines31/marketingskills) | skill · auto + `/cro` `/seo-audit` `/pricing-strategy` | ~40 marketing playbooks from a CRO agency founder. Advisory, well-structured; README funnels to his agency and two paid sponsors. Install with `-a claude-code`. MIT. | 53k | 3.5 |

## Diagrams, video & media

| Tool | Type · Trigger | What it does | ★ | Rating |
| --- | --- | --- | --- | --- |
| [cathrynlavery/diagram-design](https://github.com/cathrynlavery/diagram-design) | plugin · auto + slash | 42 editorial diagram types as self-contained HTML with SVG/PNG export and Mermaid/draw.io re-render. No hooks, no paid tier. MIT. | 50k | **4** |
| [bradautomates/claude-video](https://github.com/bradautomates/claude-video) | plugin · `/watch <url>` | Downloads, extracts frames and transcribes a video so Claude can answer questions about it. Captions free; Whisper optional. MIT. | 18k | 3.5 |

## Reference repos worth bookmarking

Nothing to install; clone patterns from them.

- [Shubhamsaboo/awesome-llm-apps](https://github.com/Shubhamsaboo/awesome-llm-apps) — 100+ agent/RAG/MCP example apps by a Google Cloud AI PM. Tutorials, not "production-ready". 139k ★
- [awesomedata/awesome-public-datasets](https://github.com/awesomedata/awesome-public-datasets) — topic-sorted open datasets, maintained since 2014. 79k ★
- [danny-avila/LibreChat](https://github.com/danny-avila/LibreChat) — the mature self-hosted multi-model chat UI with MCP support. 45k ★
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
