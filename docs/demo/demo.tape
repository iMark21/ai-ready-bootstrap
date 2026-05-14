# sdd-harness demo: install on a clean Android repo, then launch the first spec.
#
# Subject: marvel-android (Android Marvel client, last commit 2021), AI files stripped.
# Real content: the spec follows the sdd-harness PRD shape, the Kotlin stub follows
# the architecture the spec describes, and the pre-commit hook actually fires.
#
# Render: cd ~/Developer/sdd-harness && vhs docs/demo/demo.tape  -> docs/demo.gif

Output docs/demo.gif

Set Shell "bash"
Set FontSize 15
Set Width 1240
Set Height 760
Set PlaybackSpeed 1.0
Set Theme "Catppuccin Mocha"
Set TypingSpeed 22ms

# ---- silent setup ----
Hide
Type "cd ~/Desktop/Projects/marvel-android" Enter
Type "clear" Enter
Show
Sleep 600ms

# ---- 1. clean state ----
Type "# A real Android repo (Marvel client, last commit 2021). No AI layer." Enter
Sleep 800ms
Type "ls" Enter
Sleep 1500ms

# ---- 2. install ----
Type "" Enter
Type "# Install: lays down .ai/, root bootloaders, and the SDD pre-commit hook." Enter
Sleep 700ms
Type "sdd-harness init . --yes" Enter
Sleep 4500ms

Type "clear" Enter
Sleep 400ms
Type "# What sdd-harness laid down:" Enter
Sleep 500ms
Type "ls .ai/" Enter
Sleep 2000ms

# ---- 3. start a feature ----
Type "" Enter
Type "git checkout -b feat/marvel-login" Enter
Sleep 1500ms

# ---- 4. write code first (no spec yet) — the hook should refuse ----
Type "" Enter
Type "# Drop a real Kotlin stub for the feature. No spec yet. Try to commit." Enter
Sleep 700ms
Type "mkdir -p src" Enter
Sleep 300ms
Type "cat > src/LoginViewModel.kt <<'KT'" Enter
Type "package com.imark.marvel.auth" Enter
Type "" Enter
Type "class LoginViewModel(private val auth: AuthRepository) : ViewModel() {" Enter
Type "  fun login(email: String, password: String): Result<Session> = auth.login(email, password)" Enter
Type "}" Enter
Type "KT" Enter
Sleep 800ms
Type "git add src/LoginViewModel.kt && git commit -m 'feat: login view-model'" Enter
Sleep 5500ms

# ---- 5. write the real spec via heredoc ----
Type "" Enter
Type "# The hook blocked it. Spec first, then code." Enter
Sleep 800ms
Type "cat > .ai/specs/SH-001-marvel-login.md <<'MD'" Enter
Type "# SH-001 — Marvel login" Enter
Type "" Enter
Type "## 1. Problem" Enter
Type "Users see anonymous content. Favorites and last-read comics need a session" Enter
Type "tied to a Marvel API account." Enter
Type "" Enter
Type "## 2. Solution" Enter
Type "Email + password screen against the Marvel public API. Session token" Enter
Type "encrypted in EncryptedSharedPreferences, 24h expiry." Enter
Type "" Enter
Type "## 3. Acceptance" Enter
Type "- Empty email or password disables the Login button." Enter
Type "- HTTP 200 navigates to the comics list." Enter
Type "- HTTP 401 shows a clear error." Enter
Type "MD" Enter
Sleep 1500ms

# ---- 6. commit again, spec + code together ----
Type "" Enter
Type "git add .ai/specs/SH-001-marvel-login.md src/LoginViewModel.kt" Enter
Sleep 500ms
Type "git commit -m 'feat: login spec + view-model'" Enter
Sleep 4500ms

Type "" Enter
Type "# Spec and code shipped together. The SDD loop is live." Enter
Sleep 2500ms
