#!/bin/bash
# Enhanced with error checks and clearer feedback
set -euo pipefail

die() { echo "[ERROR] $1" >&2; exit 1; }

# Create Python symlink for backwards compatibility if not exist
test -e /usr/bin/python || sudo ln -s /usr/bin/python3 /usr/bin/python

# Install main apt dependencies
sudo apt update || die "Failed to update packages."
echo "macchanger macchanger/automatically_run boolean true" | sudo debconf-set-selections
echo "macchanger macchanger/restore_original_on_dhcp boolean true" | sudo debconf-set-selections
sleep 2
sudo DEBIAN_FRONTEND=noninteractive apt install -y python3-pip nmap python3-dev tcpdump pipx bettercap macchanger netcat-traditional || die "Failed to install core tools."
# Install impacket and certipy-ad as root
sudo -H pip install impacket certipy-ad pyrdp-mitm hekatomb evil-winrm-py --break-system-packages || die "Failed to install impacket/certipy-ad/pyrdp-mitm/hekatomb/hekatomb evil-winrm-py as root."

# Install as user pi if possible
if id pi &>/dev/null; then
    sudo -u pi -H pip install impacket certipy-ad pyrdp-mitm hekatomb hekatomb evil-winrm-py --break-system-packages || die "Failed to install impacket/certipy-ad/pyrdp-mitm/hekatomb/hekatomb evil-winrm-py as pi."
else
    echo "[WARN] User 'pi' not found, skipping user-level Python install."
fi

# Make a dedicated Tools directory as pi if possible
if id pi &>/dev/null; then
    sudo -u pi mkdir -p /home/pi/Tools
    cd /home/pi/Tools || die "Failed to enter Tools directory."
else
    mkdir -p Tools
    cd Tools || die "Failed to enter Tools directory."
fi

# Clone tool repos (skip on error but report)
function git_clone_or_skip() {
    local repo=$1
    git clone $repo || echo "[WARN] Failed to clone $repo, skipping."
}

git_clone_or_skip https://github.com/lgandx/Responder.git
git_clone_or_skip https://github.com/dirkjanm/mitm6.git
git_clone_or_skip https://github.com/Yaxxine7/ASRepCatcher.git
git_clone_or_skip https://github.com/dirkjanm/BloodHound.py.git
git_clone_or_skip https://github.com/p0dalirius/Coercer.git
git_clone_or_skip https://github.com/Greenwolf/ntlm_theft.git
git_clone_or_skip https://github.com/SySS-Research/Seth.git
git_clone_or_skip https://github.com/Hann1bl3L3ct3r/CredBomb.git

echo "[INFO] Useful tools installed. Check the Tools folder for details."

