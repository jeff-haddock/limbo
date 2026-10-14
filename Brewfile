# Jeff's machine — curated Brewfile
#
# DRAFT 2026-10-02. Cut down from this machine's `brew leaves --installed-on-request`
# (48 explicit installs out of ~200 with dependencies). Run: `brew bundle --file=Brewfile`
#
# RULES THIS FILE ENFORCES:
#   1. Brew for CLI tools and apps. NEVER for anything with a data directory —
#      databases run in Docker, versioned and disposable. (Learned the hard way: brew
#      postgres + Postgres.app both claiming :5432, and `brew upgrade` breaking the
#      data dir format with no warning.)
#   2. ONE python. The old machine had five on PATH plus nine brew formulae.
#   3. If a tool's thread is dormant (Unity, Android, Java), install it when the thread
#      wakes up — not now. Current versions beat carried-over ones.

# ---- core shell ----
brew "bash"                 # Apple ships 3.2 from 2007; this is 5.x
brew "coreutils"            # GNU versions of ls/date/etc
brew "zoxide"               # `z <partial>` directory jumping; successor to autojump (needs one line in zshrc)
brew "direnv"               # per-directory env vars
brew "grc"                  # colorized command output
brew "tree"
brew "watch"
brew "pstree"

# ---- search / files (modern replacements) ----
brew "ripgrep"              # NEW — replaces the_silver_searcher; also what Claude Code uses
brew "fd"                   # NEW — saner `find`
brew "bat"                  # NEW — `cat` with syntax highlighting
brew "jq"
brew "wget"
brew "httpie"               # friendlier curl for API poking

# ---- git / github ----
brew "git"
brew "gh"

# ---- languages ----
brew "go"
# node: via nvm, which is NOT from brew (nvm doesn't support brew installs).
#   Install: the official curl script at github.com/nvm-sh/nvm
brew "python@3.13"          # THE one python (rule 2). Envs via built-in `python -m venv` + pip — same as students.

# ---- infra / homelab ----
brew "ansible"              # homelab is Ansible-managed
brew "nmap"                 # network scanning
brew "smartmontools"        # disk health — earned its keep during the 2026-05 SSD failure
brew "humanlog"             # log prettifier, used by `pbrun`
brew "actionlint"           # GitHub Actions linting — also relevant to CI/CD teaching

# ---- media ----
brew "ffmpeg"               # OBS / DaVinci adjacent
brew "graphicsmagick"
brew "shellcheck"           # NEW — lints bash scripts (Virgil's nightly.sh, homelab ops scripts)

# ================= CASKS =================
cask "visual-studio-code"
cask "iterm2"
cask "docker-desktop"       # also: every database lives here now
cask "firefox"
cask "maccy"                # clipboard history (built-in Spotlight one fell short); successor to flycut
cask "rectangle"            # window snapping; successor to Spectacle, same keybindings
cask "obs"
# cask "blackhole-16ch"     # ONLY IF OBS native audio capture doesn't cover it — test first
cask "vlc"                  # quick playback of OBS .mkv recordings
cask "losslesscut"          # NEW — clip segments out of long recordings without re-encoding (trial)

# ================= DELIBERATELY NOT HERE =================
#
# Pivotal / Cloud Foundry era — dead:
#   cf-cli, bosh-cli, bbl, dep, spring-boot, git-duet, git-pair, git-together,
#   gradle, maven, rbenv
#   taps: cloudfoundry/tap, spring-io/tap, broadcom/tap, git-duet/tap
#
# Superseded or abandoned:
#   atom (GitHub killed it 2022) · openssl@1.1 (EOL) · the_silver_searcher (→ ripgrep)
#   cscope, ctags (VS Code does this) · apktool (Android dormant)
#
# State — belongs in Docker, not brew:
#   redis, redis-stack*, postgresql, Postgres.app
#
# Six JetBrains IDEs (clion, goland, pycharm, rubymine, rider, intellij):
#   JetBrains Toolbox installs any of them in 2 minutes when Unity work resumes.
#
# Install when the thread wakes up:
#   wokwi (ESP32/IoT) · Unity + dotnet · rabbitmq/minio (wfh-inator)
#
# NOT from brew — needs its own step:
#   learn CLI — tap `gschool/learn`, BUT the binary actually in use is v0.10.14 while
#   the tap serves 0.10.8. Track down the real source before trusting it.
#   Config `~/.glearn-config.yaml` holds an api_token — manual copy, never committed.
#
# LATER:
#   postman — student-facing GUI for API collections, when a cohort needs it (httpie is Jeff's tool).
#   uv — only if multiple Python versions become a real need.
#   pinentry-mac — only if GPG-signed commits are needed (possibly Gravity deploys).
#   testdisk — install the day a disk needs recovering.
#   vim — macOS ships one; `vimtutor` is already on the machine.
#
# PENDING:
#   miniconda — only if DAI/geospatial work demands it, and WITHOUT `conda init`.
#   See MIGRATION.md "Open / undecided".
