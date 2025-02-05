# PiSquirrel
Open source high performance wiretap and dropbox based on the PacketSquirrel by Hak5 built utilizing open source hardware and software packages.

PiSquirrel is based on the FriendlyElec NanoPi R3S. The purchase link directly from FriendlyElec is below: 

https://www.friendlyelec.com/index.php?route=product/product&path=69&product_id=303

The documentation necessary to get the OS loaded to the device is below: 

https://wiki.friendlyelec.com/wiki/index.php/NanoPi_R3S#Work_with_Debian_Core

The current PiSquirrel is based on the OS build: rk3566-sd-debian-bullseye-minimal-6.1-arm64-20250123.img

Once the system is online, you can SSH into the R3S using username/password pi:pi. 

The script below updates the system, installs necessary packages, and configures the interfaces to run in bridge.
Note that eth0 is the WAN and eth1 is the LAN interface on the unit.  

***
sudo apt -y update 
sudo apt -y upgrade 
sudo apt -y install bridge-utils nano  
sudo hostnamectl set-hostname HPLASERJET
echo -e "pi\npisquirrel\npisquirrel" | passwd   
curl -s https://install.zerotier.com | sudo bash
echo "PATH=$PATH:/home/pi/.local/bin" >> .bashrc

***

Edit the /etc/network/interfaces file and replace its content with the following: 

***
# The loopback network interface
auto lo
iface lo inet loopback

# Set up interfaces manually, avoiding conflicts with, e.g., network manager
iface eth0 inet manual
iface eth1 inet manual

# Bridge setup
auto br0
iface br0 inet dhcp
  bridge_ports eth0 eth1
*** 

Run "ip a" and now log into the R3S on the newly pulled bridge IP. Once in, run "sudo reboot". 

Log back into the R3S. You can now connect to the system with your new PiSquirrel and connect it to your ZeroTier 
instance. 

A list of installs and download for common tools that I use during testing: 

***
# Make a dedicated Tools directory
mkdir Tools
cd Tools

# Install python, ruby, and nmap directly 
sudo apt install python3-pip nmap ruby python3-dev

# Install impacket framework (this is why we made sure to add bin to path previously) 
pip3 install impacket 

# Pull down an assortment of tools including Responder, mitm6, ASRepCatcher, and the Bloodhound.py ingester
git clone https://github.com/lgandx/Responder.git
git clone https://github.com/dirkjanm/mitm6.git
git clone https://github.com/Yaxxine7/ASRepCatcher.git
git clone https://github.com/dirkjanm/BloodHound.py.git
***

