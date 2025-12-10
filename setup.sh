#!/bin/bash
# Enhanced setup script for Raspberry Pi or similar Linux device

set -euo pipefail

# Function for error reporting
die() { echo "[ERROR] $1" >&2; exit 1; }

echo "[INFO] Updating package lists..."
sudo apt -y update || die "Failed to update package lists."

echo "[INFO] Upgrading packages..."
sudo apt -y upgrade || die "Failed to upgrade packages."

echo "[INFO] Installing required packages..."
sudo apt -y install bridge-utils nano || die "Failed to install bridge-utils or nano."

echo "[INFO] Installing ZeroTier..."
curl -fsSL https://install.zerotier.com | sudo bash || die "Failed to install ZeroTier."

echo "[INFO] Adding /home/pi/.local/bin to PATH in .bashrc..."
echo "PATH=\$PATH:/home/pi/.local/bin" >> /home/pi/.bashrc

echo "[INFO] Downloading interface configuration..."
sudo curl -fsSL https://raw.githubusercontent.com/Hann1bl3L3ct3r/PiSquirrel/refs/heads/main/interfaces -o /etc/network/interfaces || die "Failed to fetch interfaces file."

echo "[INFO] Restarting networking service..."
sudo systemctl restart networking || die "Failed to restart networking service."

echo "[INFO] Setup complete. Please reboot the system."

