# PiSquirrel

![PiSquirrelSmall](https://github.com/user-attachments/assets/e83b6431-64e6-4f7e-ac4f-eb03e133e1d5)

The PiSquirrel was created to fill a similar space to the Hak5 PacketSquirrel. A small, easy to conceal, dropbox that can act as an inline wiretap on servers, workstations, and networking equipment. Using cheap ARM systems and open source tools, the PiSquirrel allows for red teams and offensive security professional to have an easily accessible and low cost option.  

PiSquirrel is based on the FriendlyElec NanoPi R3S. The purchase link directly from FriendlyElec is below: 

https://www.friendlyelec.com/index.php?route=product/product&path=69&product_id=303

The documentation necessary to get the OS loaded to the device is below: 

https://wiki.friendlyelec.com/wiki/index.php/NanoPi_R3S#Work_with_Debian_Core

The current PiSquirrel is based on the OS build: rk3566-sd-debian-bullseye-minimal-6.1-arm64-20250123.img

Once the system is online, you can SSH into the R3S using username/password pi:pi. 

You can pull in the setup.sh script to automatically configure the unit for red team operations. It makes the following changes: 

 - Updates and upgrades the system
 - Installs bridge-utils to bridge interfaces and nano for easier file editing
 - Modifies the hostname to appear to be a printer to devices on the network
 - Installs ZeroTier for remote access
 - Modifies PATH for future tool installation
 - Modifies the /etc/network/interfaces file to bridge interfaces
 - Restarts networking service

`curl -K "https://raw.githubusercontent.com/Hann1bl3L3ct3r/PiSquirrel/refs/heads/main/setup.sh" | sudo bash`

Once the script completes, simply reboot the PiSquirrel and it should be ready for tool installation and ZeroTier network connection. The ZeroTier command is as follows: 

`sudo zerotier-cli join <YOU RNETWORK ID>`

The useful tools script is some standard tools that are useful for network manipulation, password hash gathering, enumeration, AD interaction, etc. I have used most of these in nearly every engagement. 

The usefultools.sh script will do the following: 

 - Makes a dedicated Tools directory
 - Install python3-pip nmap python3-dev from apt
 - Installs Impacket from pip
 - Pulls down Responder, MITM6, ASRepCatcher, and Bloodhound.py from their respective Github repos

Simply run pull and run the script from the home directory: 

`curl https://raw.githubusercontent.com/Hann1bl3L3ct3r/PiSquirrel/refs/heads/main/usefultools.sh | sudo bash `

