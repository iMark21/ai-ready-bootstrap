# sdd-harness demo: integrating into a real Android project
#
# Subject: marvel-android (Android Marvel client, last commit 2021)
# Pre-condition: repo carries v0.5.0 agentlayer files (.ai/ + CLAUDE.md + AGENTS.md).
# Demo: `sdd-harness init` auto-detects, routes to `standardize`, backs up old AI files,
# installs the v1.0.0-alpha layout.
#
# Render: vhs docs/demo/demo.tape -> docs/demo.gif

Output docs/demo.gif

Set Shell "bash"
Set FontSize 16
Set Width 1100
Set Height 640
Set PlaybackSpeed 0.9
Set Theme "Catppuccin Mocha"
Set TypingSpeed 28ms

# ---- silent setup ----
Hide
Type "cd ~/Desktop/Projects/marvel-android" Enter
Type "clear" Enter
Show
Sleep 600ms

# ---- step 1: where we are ----
Type "# A real Android project, untouched since 2021, with old agentlayer v0.5.0 files." Enter
Sleep 1200ms
Type "ls" Enter
Sleep 1800ms

# ---- step 2: audit ----
Type "" Enter
Type "# Detect what AI layer the repo already has." Enter
Sleep 700ms
Type "sdd-harness audit ." Enter
Sleep 3500ms

# ---- step 3: init (auto-routes to standardize) ----
Type "" Enter
Type "# 'init' auto-routes: existing AI files -> standardize (backup + fresh install)." Enter
Sleep 700ms
Type "sdd-harness init . --yes --no-git-hook" Enter
Sleep 4500ms

# ---- step 4: result ----
Type "clear" Enter
Sleep 500ms
Type "# New v1.0.0-alpha layout:" Enter
Sleep 600ms
Type "ls .ai/" Enter
Sleep 2500ms
Type "" Enter
Type "# Old v0.5.0 files preserved in the backup directory:" Enter
Sleep 600ms
Type "ls .ai-backup-*/" Enter
Sleep 2500ms
Type "" Enter
Type "# Bootloaders are 5-line pointers, runtime-agnostic:" Enter
Sleep 600ms
Type "wc -l CLAUDE.md AGENTS.md" Enter
Sleep 2500ms

# tail
Type "" Enter
Type "# Done. Edit .ai/PRODUCT.md and start the SDD loop." Enter
Sleep 2500ms
