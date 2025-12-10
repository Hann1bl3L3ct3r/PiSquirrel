#!/bin/bash
# Fake being a printer for stealth on the network 
# ONLY RUN THIS POST TOOL SETUP

# Change system hostname to that of a Brother 
echo "[INFO] Setting hostname..."
sudo hostnamectl set-hostname BROTHERHL-L2315D || die "Failed to change hostname."

echo "[INFO] Downloading hosts configuration..."
sudo curl -fsSL https://raw.githubusercontent.com/Hann1bl3L3ct3r/PiSquirrel/refs/heads/main/hosts -o /etc/hosts || die "Failed to fetch hosts file."

# Installing and configuring 
echo "[INFO] Installing lighttpd for fake web interface on TCP 8080"
sudo apt -y install lighttpd
sudo curl https://raw.githubusercontent.com/Hann1bl3L3ct3r/PiSquirrel/refs/heads/main/FakePrinterFiles/lighttpd.conf > /etc/lighttpd/lighttpd.conf 
sudo curl https://raw.githubusercontent.com/Hann1bl3L3ct3r/PiSquirrel/refs/heads/main/FakePrinterFiles/index.html > /var/www/html/index.html 
sudo systemctl restart lighttpd

# Install SNMP sim tool to fake replies using real recorded SNMP data 
echo "[INFO] Setting up fake SNMP server..."
sudo pip install snmpsim --break-system-packages
mkdir /home/pi/Tools/FakePrinter
curl https://raw.githubusercontent.com/Hann1bl3L3ct3r/PiSquirrel/refs/heads/main/FakePrinterFiles/brother.snmprec > /home/pi/Tools/FakePrinter/brother.snmprec
sudo setcap 'cap_net_bind_service=+ep' $(which python3.11)

# Install FTP server and start server process 
echo "[INFO] Setting up fake FTP server..."
sudo apt -y install vsftpd
mkdir /home/pi/Tools/FakePrinter/FakeFTP
curl https://raw.githubusercontent.com/Hann1bl3L3ct3r/PiSquirrel/refs/heads/main/FakePrinterFiles/CFG-PAGE.TXT > /home/pi/Tools/FakePrinter/FakeFTP/CFG-PAGE.TXT
sudo curl https://raw.githubusercontent.com/Hann1bl3L3ct3r/PiSquirrel/refs/heads/main/FakePrinterFiles/vsftpd.conf > /etc/vsftpd.conf
sudo systemctl enable --now vsftpd

# Pull down and save python scripts to fake specific open printer ports
echo "[INFO] Pulling down scripts to fake print ports..."
curl https://raw.githubusercontent.com/Hann1bl3L3ct3r/PiSquirrel/refs/heads/main/FakePrinterFiles/fake_9100.py > /home/pi/Tools/FakePrinter/fake_9100.py
curl https://raw.githubusercontent.com/Hann1bl3L3ct3r/PiSquirrel/refs/heads/main/FakePrinterFiles/fake_515.py > /home/pi/Tools/FakePrinter/fake_515.py
curl https://raw.githubusercontent.com/Hann1bl3L3ct3r/PiSquirrel/refs/heads/main/FakePrinterFiles/fake_631.py > /home/pi/Tools/FakePrinter/fake_631.py

# Setup crontab to automate fake port scripts starting on reboot 
echo "[INFO] Setting up fake print ports cronjobs ..."
sudo curl https://raw.githubusercontent.com/Hann1bl3L3ct3r/PiSquirrel/refs/heads/main/FakePrinterFiles/cronjobs > /home/pi/Tools/FakePrinter/cronjobs
sudo crontab /home/pi/Tools/FakePrinter/cronjobs 

# Change users
echo "[INFO] Setting up fake SNMP server cronjobs..."
su pi

# Setup crontab to automate fake port scripts starting on reboot for pi  
curl https://raw.githubusercontent.com/Hann1bl3L3ct3r/PiSquirrel/refs/heads/main/FakePrinterFiles/pi_cronjobs > /home/pi/Tools/FakePrinter/pi_cronjobs
crontab /home/pi/Tools/FakePrinter/pi_cronjobs


