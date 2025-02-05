# Make a dedicated Tools directory
mkdir Tools
cd Tools

# Install python, ruby, and nmap directly 
sudo apt install python3-pip nmap python3-dev

# Install impacket framework (this is why we made sure to add bin to path previously) 
pip3 install impacket 

# Pull down an assortment of tools including Responder, mitm6, ASRepCatcher, and the Bloodhound.py ingester
git clone https://github.com/lgandx/Responder.git
git clone https://github.com/dirkjanm/mitm6.git
git clone https://github.com/Yaxxine7/ASRepCatcher.git
git clone https://github.com/dirkjanm/BloodHound.py.git
