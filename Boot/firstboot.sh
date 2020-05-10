# -----------------------
#  Initial status on boot
# -----------------------
# Shell script to be run on the Raspberry boot to get the general status
# of the relevant application install on the Raspberry and the network status
# IP Address, internet connection etc. Making easier to work with the Raspberry 
# as a headless server.
#
# Requirements:
# * This script should be included on the booteable micro SD card in which you 
#   have flashed the operative system. Be mindfull you need an special version 
#   of the raspberry operative system (Raspbian) that allow you to run shell 
#   scripts since the very first boot. You can download the last version and 
#   get more info about it here: https://github.com/nmcclain/raspberian-firstboot
# * Manually add the wpa_supplicant.conf to the /mnt/boot/ directory on the flashed
#   micro SD card, to get the raspberry connected to wifi in headless mode (neither 
#   monitor nor keyboard).


echo "*** Executing Raspberry status script on boot"

# Constants
PUSHBULLETKEY="o.NMEh6dZhlsNQX4IwH0EYQaeXZzmWSeUI"
HOSTNAME="jaimehmol"


echo "*** Getting tool current versions"
aptVersion=apt --version
pythonVersion=python --version
python3Version=python3 --version

virtualenvVersion=virtualenv --version
screenVersion=screen --version
avahiVersion=avahi-daemon --version
rmateVersion=rmate --version


echo "*** Getting ip address"
ipAddress=hostname -I
# ifconfig (Wlan0)


echo "*** Sending a Pushbullet message reporting the original Raspberry status"
curl -u o.NMEh6dZhlsNQX4IwH0EYQaeXZzmWSeUI: -X POST https://api.pushbullet.com/v2/pushes --header 'Content-Type: application/json' --data-binary '{"type": "note", "title": "Raspberry server original status", "body": "ipAddress=$ipAddress, hostName=raspberrypi.local, aptVersion=$aptVersion, pythonVersion=$pythonVersion, python3Version=$python3Version, virtualenvVersion=$virtualenvVersion, screenVersion=$screenVersion, avahiVersion=$avahiVersion, rmateVersion=$rmateVersion."'




echo "*** Applying custom Raspberry setups to work as a server"

echo "*** Creating new user (qb user)"
sudo adduser qb

echo "*** Updating existing tools"
sudo apt-get update
sudo apt-get upgrade


echo "*** Specific Rapsberry configs"
# sed 's+<Word to find>+<Word use to replace>+g' input.txt
echo "***   Changing SSH port"
cd /etc/ssh/
sed 's+Port 22+Port 722+g' sshd_config
service ssh restart

echo "***   Changing hostname"
echo $HOSTNAME > /etc/hostname
sed -i "s/raspberrypi/$HOSTNAME/g" /etc/hosts
hostname $HOSTNAME

echo "***   Install required tools (to work as qb server mode)"
apt-get install screen
apt-get install avahi-daemon
pip3 install virtualenv
#   rmate
curl -o /usr/local/bin/rmate https://raw.githubusercontent.com/aurora/rmate/master/rmate
chmod +x /usr/local/bin/rmate

echo "***   Building user working directories"
mkdir ~/Projects/Python
mkdir ~/Projects/Common
mkdir ~/Projects/Web

echo "***   Setting up splash screen"





echo "*** Getting tool current versions"
aptVersion=apt --version
pythonVersion=python --version
python3Version=python3 --version

virtualenvVersion=virtualenv --version
screenVersion=screen --version
avahiVersion=avahi-daemon --version
rmateVersion=rmate --version


echo "*** Getting ip address"
ipAddress=hostname -I
# ifconfig (Wlan0)


echo "*** Sending a Pushbullet message reporting the original Raspberry status"
curl -u o.NMEh6dZhlsNQX4IwH0EYQaeXZzmWSeUI: -X POST https://api.pushbullet.com/v2/pushes --header 'Content-Type: application/json' --data-binary '{"type": "note", "title": "Raspberry server original status", "body": "ipAddress=$ipAddress, hostName=raspberrypi.local, aptVersion=$aptVersion, pythonVersion=$pythonVersion, python3Version=$python3Version, virtualenvVersion=$virtualenvVersion, screenVersion=$screenVersion, avahiVersion=$avahiVersion, rmateVersion=$rmateVersion."'




echo "*** Finishing and rebooting Raspberry to apply all the changes"
sudo reboot