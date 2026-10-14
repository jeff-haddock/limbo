# limbo

The first circle: where Virgil lives. This repo is what makes a computer *Jeff's*, the
foundation everything else stands on. New Mac: `SETUP.md`.

## The map: what lives where
| What | Where | Notes |
|---|---|---|
| **This machine** | `limbo/` (here) | Shell, git, ssh, VS Code, Brewfile, OBS. Non-config files (images etc.) in `assets/<app>/`. |
| **Virgil** | `~/work/projects/infra/virgil` | How Claude thinks and remembers: CLAUDE.md, skills, memory, the nightly compiler, Claude's `settings.json`. Its own repo; `install.sh` here runs its installer. |
| **Virgil's data** | `~/work/projects/infra/virgil-data` | Transcripts and the context db. Not in git. |
| **Homelab** | `~/jeff/projects/homelab` | The HM50. Same idea as limbo, for a server: Ansible plays this role there. |

## How it works
An Ansible playbook (`ansible/`, same shape as homelab's) configures this Mac against itself:
`ansible-playbook site.yml --check --diff` to preview, then without `--check` to apply; a second
run says `changed=0`. Every path lives in `ansible/group_vars/all/paths.yml`: move something,
change it there, re-run. On a fresh Mac, `bootstrap.sh` installs Homebrew and Ansible first.

| Role | Does |
|---|---|
| `homebrew` | checks everything in `Brewfile` is installed (installs happen in `bootstrap.sh`, in your terminal) |
| `dotfiles` | the symlinks below (a real file in the way is moved to `*.pre-limbo`, never clobbered) |
| `macos` | `defaults` settings: Dock, tiling off |
| `ssh` | a fresh keypair per Mac if missing (keys are never copied between machines) |
| `obs` | seeds the profile and scenes, pins their paths |
| `virgil` | clones Virgil if missing, runs its installer |

Each config file lives here; the path the app reads is a symlink back to it. Edit either path,
it's the same file, and every change shows up as a git diff.

| In limbo | Linked from |
|---|---|
| `zsh/zshrc` | `~/.zshrc` (sources Virgil's `shell/virgil.zsh` at the end) |
| `git/gitconfig` | `~/.gitconfig` |
| `ssh/config` | `~/.ssh/config` (hosts only; keys never come here) |
| `vscode/settings.json`, `vscode/keybindings.json` | `~/Library/Application Support/Code/User/` |

Not symlinked: **OBS** (`obs/`) rewrites its own config, so the playbook seeds it and pins only
the paths.

**Bitwarden has one Ansible item.** It holds the vault master key and Virgil's privacy term
list (restored by hand to `virgil-data/privacy-terms.txt`; names never go in any repo, not even
encrypted). Secrets, when the first one arrives: `ansible/group_vars/all/vault.yml`, same as
homelab.

## What belongs here
Settings that would make a fresh Mac feel like Jeff's. **Every change to this Mac lands here:**
in the playbook or the Brewfile if it can be automated, as a step in SETUP.md if it can't. A
setting that's only clicked in an app is lost on the next laptop. When something grows into a product of its
own, it graduates to its own repo, the way Virgil did.
