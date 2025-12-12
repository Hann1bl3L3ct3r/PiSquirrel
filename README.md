![PiSquirrelSmall](https://github.com/user-attachments/assets/e83b6431-64e6-4f7e-ac4f-eb03e133e1d5)

The PiSquirrel was created to fill a similar space to the Hak5 PacketSquirrel. A small, easy to conceal, dropbox that can act as an inline wiretap on servers, workstations, and networking equipment. Using cheap ARM systems and open source tools, the PiSquirrel allows for red teams and offensive security professional to have an easily accessible and low cost option.  Newly added features allow the PiSquirrel to replicate the open ports and responses of a Brother printer, returning proper SNMP data, showing proper FTP files, and show proper open ports (with the exception of two that are still in progress). This allows for additional stealth on networks with consistent Nessus, OpenVAS, or other network scans monitoring devices on the network. 

PiSquirrel is based on the FriendlyElec NanoPi R3S. The purchase link directly from FriendlyElec is below: 

https://www.friendlyelec.com/index.php?route=product/product&path=69&product_id=303

The documentation necessary to get the OS loaded to the device is below: 

https://wiki.friendlyelec.com/wiki/index.php/NanoPi_R3S#Work_with_Debian_Core

The current PiSquirrel is based on the OS build: rk3566-XYZ-debian-bookworm-core-6.1-arm64-YYYYMMDD.img.gz	

Once the system is online, you can SSH into the R3S using username/password pi:pi. 

You can pull in the setup.sh script to automatically configure the unit for red team operations. It makes the following changes: 

 - Updates and upgrades the system
 - Installs bridge-utils to bridge interfaces and nano for easier file editing
 - Installs ZeroTier for remote access
 - Modifies PATH for future tool installation
 - Modifies the /etc/network/interfaces file to bridge interfaces
 - Restarts networking service

`curl "https://raw.githubusercontent.com/Hann1bl3L3ct3r/PiSquirrel/refs/heads/main/setup.sh" | sudo bash`

Once the script completes, simply reboot the PiSquirrel and it should be ready for tool installation and ZeroTier network connection. The ZeroTier command is as follows: 

`sudo zerotier-cli join <YOU RNETWORK ID>`

The useful tools script is some standard tools that are useful for network manipulation, password hash gathering, enumeration, AD interaction, etc. I have used most of these in nearly every engagement. 

The usefultools.sh script will do the following: 

 - Makes a dedicated Tools directory
 - Install python3-pip nmap python3-dev tcpdump and more from apt
 - Installs Impacket, Certipy, Hekatomb, PyRDP-MITM, and more from pip
 - Pulls down Responder, MITM6, ASRepCatcher, and more 

Simply run pull and run the script from the home directory: 

`curl https://raw.githubusercontent.com/Hann1bl3L3ct3r/PiSquirrel/refs/heads/main/usefultools.sh | sudo bash `

Once tools are installed, you can now run tools and remotely access the system: 

```
pi@HPLASERJET:~$ ls
Desktop  Tools
pi@HPLASERJET:~$ cd Tools
pi@HPLASERJET:~/Tools$ ls
ASRepCatcher  BloodHound.py  Responder  mitm6
pi@HPLASERJET:~/Tools$ cd Responder
pi@HPLASERJET:~/Tools/Responder$ sudo pip3 install -r requirements.txt 
sudo: unable to resolve host HPLASERJET: Name or service not known
Collecting netifaces>=0.10.4
  Downloading netifaces-0.11.0.tar.gz (30 kB)
Building wheels for collected packages: netifaces
  Building wheel for netifaces (setup.py) ... done
  Created wheel for netifaces: filename=netifaces-0.11.0-cp39-cp39-linux_aarch64.whl size=34908 sha256=dedb0f950d44882ba137c38df69e66a0cf5c860a81614d3fdafd8d98147b46dc
  Stored in directory: /root/.cache/pip/wheels/4f/77/60/d721ffbafc28e5021f94207ac09dbc23ecde96b4f74a324106
Successfully built netifaces
Installing collected packages: netifaces
Successfully installed netifaces-0.11.0
pi@HPLASERJET:~/Tools/Responder$ sudo python3 Responder.py -I br0
                                         __
  .----.-----.-----.-----.-----.-----.--|  |.-----.----.
  |   _|  -__|__ --|  _  |  _  |     |  _  ||  -__|   _|
  |__| |_____|_____|   __|_____|__|__|_____||_____|__|
                   |__|

           NBT-NS, LLMNR & MDNS Responder 3.1.5.0

  To support this project:
  Github -> https://github.com/sponsors/lgandx
  Paypal  -> https://paypal.me/PythonResponder

  Author: Laurent Gaffie (laurent.gaffie@gmail.com)
  To kill this script hit CTRL-C


[+] Poisoners:
    LLMNR                      [ON]
    NBT-NS                     [ON]
    MDNS                       [ON]
    DNS                        [ON]
    DHCP                       [OFF]
```

UPDATE - PiSquirrel now has a new install script for enhanced stealth within a network. The new script "secret_squirrel.sh" makes the PiSquirrel act like a Brother printer on the network. 

`curl https://raw.githubusercontent.com/Hann1bl3L3ct3r/PiSquirrel/refs/heads/main/secret_squirrel.sh | sed 's/\r$//' | sudo bash`

The script does the following: 
 - Modifies the hostname to appear to be a printer to devices on the network
 - Installs lighttpd, modifies its configuration, and host a fake Brother printer web interface on TCP 8080
 - Installs snmpsim to replicate SNMP data from a printer pulls down snmp data from a real Brother printer to display if scanned, and configures snmpsim to run on startup
 - Modifies the permissions on the python interpreter to allow it to run on the standard port UDP 161 without needing to be root 
 - Installs vsftpd and pulls down a configuration file that allows anonymous access to a restricted folder, pulls down and places in that folder a fake CFG-PAGE.TXT file like a normal printer
 - Pulls down three python scripts that open TCP 513, 631, and 9100 to replicate the open printer ports and configures them to run on startup
 - Updates crontab for all of the startup processes.

UPDATE: HTTP has been added with a false Brother printer stype web interface on TCP 8080. This move to 8080 instead of 80 allows for the use of tools such as Responder and Impacket's ntlmrelayx without the need to stop the web server first. 

System Reset: firstboot && reboot
