#!/bin/bash
set -e
# Google Chrome
wget -qO- https://dl.google.com/linux/linux_signing_key.pub|sudo -A gpg --dearmor -o /usr/share/keyrings/google-chrome.gpg>/dev/null
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main'|sudo -A tee /etc/apt/sources.list.d/google-chrome.list>/dev/null
# Mozilla Firefox
wget -qO- https://packages.mozilla.org/apt/repo-signing-key.gpg|sudo -A gpg --dearmor -o /usr/share/keyrings/packages.mozilla.org.gpg>/dev/null
echo 'deb [signed-by=/usr/share/keyrings/packages.mozilla.org.gpg] https://packages.mozilla.org/apt mozilla main'|sudo -A tee /etc/apt/sources.list.d/mozilla.list>/dev/null
cat <<EOF |sudo -A tee /etc/apt/preferences.d/mozilla
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
EOF