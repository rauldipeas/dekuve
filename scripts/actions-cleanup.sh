#!/bin/bash
set -e
#if [ -f "$HOME"/sudo_askpass ];then
#	export SUDO_ASKPASS="$HOME/sudo_askpass"
#	echo askpass helper enabled
#	else
#	echo askpass helper skipped
#fi

# Install
#wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg|sudo -A gpg --dearmor -o /etc/apt/trusted.gpg.d/githubcli-archive-keyring.gpg>/dev/null
#echo 'deb [arch=amd64] https://cli.github.com/packages stable main'|sudo tee /etc/apt/sources.list.d/github-cli.list>/dev/null
#sudo -A apt update
#sudo -A apt install -y gh

# Actions cleanup
PROJECT='rauldipeas/dekuve'
KEEP=5
gh api repos/"$PROJECT"/actions/runs --paginate -q '.workflow_runs[]|select(.head_branch != "any")|"\(.id)"'|tail -n+$((KEEP+1))|xargs -n1 -I % gh api repos/"$PROJECT"/actions/runs/% -X DELETE