#!/bin/bash
# Fresh Mac → Jeff's Mac. Gets just enough on the box to run the playbook, then runs it.
#   1. Homebrew   2. Ansible   3. everything in the Brewfile   4. ansible/site.yml
# Assumes limbo is already cloned to ~/work/projects/infra/limbo (HTTPS works before any keys).
# Safe to re-run: each step skips if it's already done.
set -euo pipefail
LIMBO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v brew >/dev/null; then
  echo "== Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if ! command -v ansible-playbook >/dev/null; then
  echo "== Ansible"
  brew install ansible
fi

# Installs happen here, in Jeff's terminal, where a sudo prompt can reach him.
# The playbook only checks them.
echo "== Brewfile"
brew bundle install --file="$LIMBO/Brewfile"

echo "== playbook"
cd "$LIMBO/ansible"
ansible-playbook site.yml "$@"
