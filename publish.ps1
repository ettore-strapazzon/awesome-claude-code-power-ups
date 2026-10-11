# Publishes this folder as a new public GitHub repo. Needs the GitHub CLI (winget install GitHub.cli) and `gh auth login` once.
# Run from inside this folder:  powershell -ExecutionPolicy Bypass -File .\publish.ps1
$name = "awesome-claude-code-power-ups"
$desc = "Vetted Claude Code skills, plugins, MCP servers and hooks: star counts verified, licences and hooks checked, hype vs reality for each. Includes the ones to skip."
git init -b main
git add .
git commit -m "Initial vetted list: 76 tools reviewed, 27 recommended"
gh repo create $name --public --source . --description $desc --push
gh repo edit --add-topic claude-code --add-topic claude --add-topic anthropic --add-topic ai-agents --add-topic agent-skills --add-topic mcp --add-topic mcp-server --add-topic claude-code-plugins --add-topic claude-code-skills --add-topic awesome --add-topic awesome-list --add-topic developer-tools --add-topic ai-coding --add-topic llm --add-topic codex --add-topic cursor --add-topic vibe-coding --add-topic prompt-engineering --add-topic agentic-ai --add-topic skills
gh repo edit --enable-discussions
Write-Host "Published: https://github.com/$(gh api user -q .login)/$name"
