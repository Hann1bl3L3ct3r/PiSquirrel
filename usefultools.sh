# Make a dedicated Tools directory
mkdir Tools
cd Tools

# Fix Python references through symlink
sudo ln -s /usr/bin/python3 /usr/bin/python

# Install python, nmap, tcpdump, etc from apt  
sudo apt install -y python3-pip nmap python3-dev tcpdump pipx bettercap

# Install impacket framework, certipy-ad, etc from apt instead of pip (this is why we made sure to add bin to path previously) 
pip install impacket certipy-ad --break-system-packages

# Pull down an assortment of tools including Responder, mitm6, ASRepCatcher, and the Bloodhound.py ingester
git clone https://github.com/lgandx/Responder.git
git clone https://github.com/dirkjanm/mitm6.git
git clone https://github.com/Yaxxine7/ASRepCatcher.git
git clone https://github.com/dirkjanm/BloodHound.py.git 
