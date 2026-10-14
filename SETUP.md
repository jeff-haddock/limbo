# Machine setup — what Jeff's Mac should look like

The toolkit we carry. Order on a new Mac:

1. Clone limbo over HTTPS to `~/work/projects/infra/limbo`.
2. `bash ~/work/projects/infra/limbo/bootstrap.sh`: installs Homebrew and Ansible, then runs the
   playbook. The first run stops at the Virgil clone: the `ssh` role just made this Mac's keys
   and printed their public halves. Register them (GitHub, GitLab, the HM50), then re-run.
   It stops once more for Virgil's privacy term list: copy the privacy terms from the
   Ansible item in Bitwarden to `~/work/projects/infra/virgil-data/privacy-terms.txt`
   (`chmod 600`), then re-run.
3. The manual steps below: things no script can safely set.

If a step here can be scripted, move it into `install.sh` and delete it from this list.

## Manual steps

**Node, via nvm.** Not from brew (nvm doesn't support brew installs). Run the official
install script from github.com/nvm-sh/nvm, then `nvm install --lts`.

**Git remotes: GitHub over SSH, Galvanize GitLab over HTTPS.** GitHub: SSH key in `~/.ssh`,
registered on github.com. gitlab.galvanize.com: HTTPS with a personal access token
(`write_repository`), saved by the macOS keychain on first push. SSH to Galvanize GitLab times out
on port 22 from here, and HTTPS sidesteps it; that's how it was on the old Mac too.

**External keyboard (Windows layout) matches the Mac.** System Settings → Keyboard →
Keyboard Shortcuts… → Modifier Keys → select the external keyboard:
- Option (⌥) key → ⌘ Command  (physical Alt acts as Cmd, next to the spacebar like a Mac)
- Command (⌘) key → ⌥ Option  (physical Win acts as Option)
- Control → Control
Per keyboard, so the laptop's built-in keys are untouched. Goal: no thinking when undocking.

**Screenshots.** macOS defaults: ⌘⇧3 full screen, ⌘⇧4 selection, ⌘⇧5 toolbar; add Ctrl to
send to the clipboard instead of a file (Ctrl⌘⇧4 is the everyday one).
**Sharing them with Claude is mandatory:** in iTerm, paste images into Claude Code with **Ctrl+V**
(Cmd+V pastes text only). Ctrl⌘⇧4 → Ctrl+V. Fallback: drag the file in, which pastes its path.

**Dictation.** System Settings → Keyboard → Dictation: on, shortcut "Press Control Key Twice".
Dictate long thoughts into an editor tab, not straight into Claude: a permission prompt
mid-dictation swallows the text.

**Launch at login: Maccy and Rectangle only.** Docker Desktop: NOT at login (heavy) — open it
when the work needs it. Nightly digest needs nothing here; launchd runs it.

**Clipboard.** Maccy (from the Brewfile). Must be launched once by hand — brew doesn't start it,
and until it runs, ⇧⌘C falls through to apps (e.g. the Colors panel). Hotkey: Maccy's default
⇧⌘C (Jeff's old Flycut habit was ⇧⌘V; chose to retrain rather than remap). Launch once, enable "Launch at login", pick a hotkey.

**Window snapping.** Rectangle (from the Brewfile). Launch once, grant Accessibility, enable
"Launch at login", pick **Recommended** shortcuts (⌃⌥ + key; Spectacle's ⌥⌘ arrows clash with tab
switching in VS Code/browsers and pane moves in iTerm). Behavior tab: set repeated half-commands
to CYCLE SIZES (½ → ⅔ → ⅓), not "move to next display". Thirds/quarters hide under "› …" at the
bottom of the Shortcuts tab. macOS's own tiling is turned off by the playbook (`macos` role), so
only Rectangle snaps.

## Open — decide, then record here

- **Mic kill switch — not needed (2026-10-07).** The orange menu-bar dot shows when anything
  is using the mic. If ever wanted: input volume 0 is NOT a real mute; the device mute property is
  (`brew install switchaudio-osx`, then a Shortcuts hotkey running
  `SwitchAudioSource -t input -m toggle` — mute/unmute confirmed working, sound-blocking untested).
- **OBS audio.** Test native app-audio capture before installing `blackhole-16ch`.
- **OBS config lives in `limbo/obs/`** (scenes, profile, and the images the scenes use). The
  playbook's `obs` role seeds them and pins their paths from `paths.yml`. Plugins are
  reinstalled fresh as needed, never copied: `obs/README.md`.
- **Learn CLI.** Version trap (tap 0.10.8 vs the v0.10.14 actually used). Backlog #20.
- **iTerm2 colors / prompt.** Backlog #21.
