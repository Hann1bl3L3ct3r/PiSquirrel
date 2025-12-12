#!/bin/bash
# Fake being a printer for stealth on the network 
# ONLY RUN THIS POST TOOL SETUP

set -e  # Exit immediately on errors
set -u  # Treat unset variables as errors

die() {
    echo "[ERROR] $1" >&2
    exit 1
}

run_or_die() {
    "$@" || die "Command failed: $*"
}

if ! command -v sudo &> /dev/null; then
    die "This script requires sudo but it's not available."
fi

echo "[INFO] Setting hostname..."
run_or_die sudo hostnamectl set-hostname BROTHERHL-L2315D

echo "[INFO] Downloading hosts configuration..."
run_or_die sudo curl -fsSL https://raw.githubusercontent.com/Hann1bl3L3ct3r/PiSquirrel/refs/heads/main/hosts -o /etc/hosts

echo "[INFO] Installing lighttpd for fake web interface on TCP 8080"
run_or_die sudo apt -y install lighttpd
run_or_die sudo curl -fsSL https://raw.githubusercontent.com/Hann1bl3L3ct3r/PiSquirrel/refs/heads/main/FakePrinterFiles/lighttpd.conf -o /etc/lighttpd/lighttpd.conf
run_or_die sudo curl -fsSL https://raw.githubusercontent.com/Hann1bl3L3ct3r/PiSquirrel/refs/heads/main/FakePrinterFiles/index.html -o /var/www/html/index.html
run_or_die sudo systemctl restart lighttpd

echo "[INFO] Setting up fake SNMP server..."
run_or_die sudo pip install snmpsim --break-system-packages
run_or_die mkdir -p /home/pi/Tools/FakePrinter
run_or_die curl -fsSL https://raw.githubusercontent.com/Hann1bl3L3ct3r/PiSquirrel/refs/heads/main/FakePrinterFiles/brother.snmprec -o /home/pi/Tools/FakePrinter/brother.snmprec
run_or_die sudo setcap 'cap_net_bind_service=+ep' $(which python3.11)

echo "[INFO] Setting up fake FTP server..."
run_or_die sudo apt -y install vsftpd
run_or_die mkdir -p /home/pi/Tools/FakePrinter/FakeFTP
run_or_die curl -fsSL https://raw.githubusercontent.com/Hann1bl3L3ct3r/PiSquirrel/refs/heads/main/FakePrinterFiles/CFG-PAGE.TXT -o /home/pi/Tools/FakePrinter/FakeFTP/CFG-PAGE.TXT
run_or_die sudo curl -fsSL https://raw.githubusercontent.com/Hann1bl3L3ct3r/PiSquirrel/refs/heads/main/FakePrinterFiles/vsftpd.conf -o /etc/vsftpd.conf
run_or_die sudo systemctl enable --now vsftpd

echo "[INFO] Pulling down scripts to fake print ports..."
run_or_die curl -fsSL https://raw.githubusercontent.com/Hann1bl3L3ct3r/PiSquirrel/refs/heads/main/FakePrinterFiles/fake_9100.py -o /home/pi/Tools/FakePrinter/fake_9100.py
run_or_die curl -fsSL https://raw.githubusercontent.com/Hann1bl3L3ct3r/PiSquirrel/refs/heads/main/FakePrinterFiles/fake_515.py -o /home/pi/Tools/FakePrinter/fake_515.py
run_or_die curl -fsSL https://raw.githubusercontent.com/Hann1bl3L3ct3r/PiSquirrel/refs/heads/main/FakePrinterFiles/fake_631.py -o /home/pi/Tools/FakePrinter/fake_631.py

echo "[INFO] Setting up fake print ports cronjobs ..."
run_or_die sudo curl -fsSL https://raw.githubusercontent.com/Hann1bl3L3ct3r/PiSquirrel/refs/heads/main/FakePrinterFiles/cronjobs -o /home/pi/Tools/FakePrinter/cronjobs
run_or_die sudo crontab /home/pi/Tools/FakePrinter/cronjobs

echo "[INFO] Setting up fake SNMP server cronjobs..."
run_or_die sudo -u pi curl -fsSL https://raw.githubusercontent.com/Hann1bl3L3ct3r/PiSquirrel/refs/heads/main/FakePrinterFiles/pi_cronjobs -o /home/pi/Tools/FakePrinter/pi_cronjobs
run_or_die sudo -u pi crontab /home/pi/Tools/FakePrinter/pi_cronjobs

echo "[SUCCESS] PiSquirrel stealth printer setup completed!"

