# Fix Python references through symlink
ln -s /usr/bin/python3 /usr/bin/python

# Install python, nmap, tcpdump, etc from apt  
apt install -y python3-pip nmap python3-dev tcpdump pipx bettercap

# Install impacket framework, certipy-ad, etc as root
pip install impacket certipy-ad --break-system-packages

# Change users to install as individual user and 
su pi

# Install impacket framework, certipy-ad, etc as pi
pip install impacket certipy-ad --break-system-packages

# Make a dedicated Tools directory
mkdir Tools
cd Tools

# Pull down an assortment of tools including Responder, mitm6, ASRepCatcher, and the Bloodhound.py ingester
git clone https://github.com/lgandx/Responder.git
git clone https://github.com/dirkjanm/mitm6.git
git clone https://github.com/Yaxxine7/ASRepCatcher.git
git clone https://github.com/dirkjanm/BloodHound.py.git 
git clone https://github.com/p0dalirius/Coercer.git
git clone https://github.com/Greenwolf/ntlm_theft.git
git clone https://github.com/SySS-Research/Seth.git
