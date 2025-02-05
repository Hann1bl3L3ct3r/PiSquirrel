# PiSquirrel

The PiSquirrel was created to fill a similar space to the Hak5 PacketSquirrel. A small, easy to conceal, dropbox that can act as an inline wiretap on servers, workstations, and networking equipment. Using cheap ARM systems and open source tools, the PiSquirrel allows for red teams and offensive security professional to have an easily accessible and low cost option.  

PiSquirrel is based on the FriendlyElec NanoPi R3S. The purchase link directly from FriendlyElec is below: 

https://www.friendlyelec.com/index.php?route=product/product&path=69&product_id=303

The documentation necessary to get the OS loaded to the device is below: 

https://wiki.friendlyelec.com/wiki/index.php/NanoPi_R3S#Work_with_Debian_Core

The current PiSquirrel is based on the OS build: rk3566-sd-debian-bullseye-minimal-6.1-arm64-20250123.img

Once the system is online, you can SSH into the R3S using username/password pi:pi. 

The script below updates the system, installs necessary packages, and configures the interfaces to run in bridge.
Note that eth0 is the WAN and eth1 is the LAN interface on the unit.  

Edit the /etc/network/interfaces file and replace its content with the following: 

Run "ip a" and now log into the R3S on the newly pulled bridge IP. Once in, run "sudo reboot". 

Log back into the R3S. You can now connect to the system with your new PiSquirrel and connect it to your ZeroTier 
instance. 

A list of installs and download for common tools that I use during testing: 


