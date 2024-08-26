#!/bin/bash
set -e

# Install
wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg|sudo -A gpg --dearmor -o /etc/apt/trusted.gpg.d/githubcli-archive-keyring.gpg>/dev/null
echo 'deb [arch=amd64] https://cli.github.com/packages stable main'|sudo tee /etc/apt/sources.list.d/github-cli.list>/dev/null
sudo apt update
sudo apt install -y gh

# Actions cleanup
PROJECT='rauldipeas/dekuve'
KEEP=5
gh api repos/"$PROJECT"/actions/runs --paginate -q '.workflow_runs[]|select(.head_branch != "any")|"\(.id)"'|tail -n+$((KEEP+1))|xargs -n1 -I % gh api repos/"$PROJECT"/actions/runs/% -X DELETE