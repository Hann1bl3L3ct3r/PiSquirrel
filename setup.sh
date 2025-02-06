sudo apt -y update 
sudo apt -y upgrade 
sudo apt -y install bridge-utils nano  
sudo hostnamectl set-hostname HPLASERJET
curl -s https://install.zerotier.com | sudo bash
echo "PATH=$PATH:/home/pi/.local/bin" >> .bashrc
sudo curl https://raw.githubusercontent.com/Hann1bl3L3ct3r/PiSquirrel/refs/heads/main/interfaces > /etc/network/interfaces
sudo curl https://raw.githubusercontent.com/Hann1bl3L3ct3r/PiSquirrel/refs/heads/main/hosts > /etc/hosts
sudo systemctl restart networking 
