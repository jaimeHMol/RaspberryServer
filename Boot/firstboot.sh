#!/bin/bash

# ---------------------------------
#  Initial status and setup on boot
# ---------------------------------
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
#
# Inputs: (Fill the constants)
#   Pushbulletkey: Your pushbullet API access token to be notified
#   Hostname: The name you want give to the raspberry server
#   SSH port: The port to use in the ssh connections (The standar is 22)
#   New user: The name of the user to be created on the raspberry server (to keep pi user isolated)
#
# 9 May 2020 - @jaimeHMol


echo "*** Executing Raspberry status script on boot"

# Constants
PUSHBULLETKEY="PUT_YOUR_PUSHBULLET_API_ACCESS_TOKEN_HERE"
HOSTNAME="YOUR_CUSTOM_HOST_NAME"
SSHPORT=22
NEWUSER=adminUser

# Functions
generate_post_data()
{
  cat <<EOF
{
    "type": "note", 
    "title": "Raspberry server current status", 
    "body": "ipAddressPrivate=$ipAddress, \
    hostName=raspberrypi.local, \
    aptVersion=$aptVersion, \
    pythonVersion=$pythonVersion, \
    python3Version=$python3Version, \
    pipVersion=$pipVersion, \
    pip3Version=$pip3Version, \
    gitVersion=$gitVersion, \
    javaVersion=$javaVersion, \
    virtualenvVersion=$virtualenvVersion, \
    screenVersion=$screenVersion, \
    avahiVersion=$avahiVersion, \
    rmateVersion=$rmateVersion"
}
EOF
}


    # ------------------------------------------------------------------------
echo "*** Getting tool versions and status"
    # ------------------------------------------------------------------------

    aptVersion=`apt --version 2>&1 | awk '{print $2}'`
    if [[ "$aptVersion" == "line" || "$aptVersion" == "Java" ]]; then
        aptVersion="No apt"
    fi

    pythonVersion=`python --version 2>&1 | awk '{print $2}'`
    if [ "$pythonVersion" == "line" ]; then
        pythonVersion="No python"
    fi

    python3Version=`python3 --version 2>&1 | awk '{print $2}'`
    if [ "$python3Version" == "line" ]; then
        python3Version="No python3"
    fi

    pipVersion=`pip --version 2>&1 | awk '{print $2}'`
    if [ "$pipVersion" == "line" ]; then
        pipVersion="No pip"
    fi

    pip3Version=`pip3 --version 2>&1 | awk '{print $2}'`
    if [ "$pip3Version" == "line" ]; then
        pip3Version="No pip3"
    fi

    gitVersion=`git --version 2>&1 | awk '{print $3}'`
    if [[ "$gitVersion" == "line" || "$gitVersion" == *":"* ]]; then
        gitVersion="No git"
    fi

    javaVersion=`java --version 2>&1 | awk 'NR==1{print $2}'`
    if [ "$javaVersion" == "line" ]; then
        javaVersion="No java"
    fi


    virtualenvVersion=`virtualenv --version 2>&1 | awk '{print $2}'`
    if [ "$virtualenvVersion" == "line" ]; then
        virtualenvVersion="No virtualenv"
    fi

    screenVersion=`screen --version 2>&1 | awk '{print $3}'`
    if [[ "$screenVersion" == "line" || "$screenVersion" == *":"* ]]; then
        screenVersion="No screen"
    fi

    avahiVersion=`avahi-daemon --version 2>&1 | awk '{print $2}'`
    if [ "$avahiVersion" == "line" ]; then
        avahiVersion="No avahi-daemon"
    fi

    rmateVersion=`rmate --version 2>&1 | awk '{print $2}'`
    if [ "$rmateVersion" == "line" ]; then
        rmateVersion="No rmate"
    fi


    echo "*** Getting ip address"
    ipAddress=`hostname -I 2>&1 | awk 'NR==1{print $1}'`
    if [ "$ipAddress" == "hostname:" ]; then
        ipAddress="Ip error"
    fi

    # TODO: Get and inform public ip


echo "*** Sending a Pushbullet message reporting the Raspberry status"
    # echo "$(generate_post_data)"
    curl -u $PUSHBULLETKEY: -X POST https://api.pushbullet.com/v2/pushes --header "Content-Type: application/json" --data-binary "$(generate_post_data)"


# if ! [ -f ~/.firstboot.log ]; then
if ! [ -f /home/pi/.firstboot.log ]; then
    # ------------------------------------------------------------------------
    echo "*** Applying custom Raspberry setups to work as a server"
    # ------------------------------------------------------------------------

    echo "*** Creating new user (qb user) forcing them to change their passwod in next login"
    sudo useradd -m "$NEWUSER"
    sudo adduser "$NEWUSER" sudo
    echo "$NEWUSER:raspberry" | sudo chpasswd
    sudo passwd -e $NEWUSER

    echo "*** Updating existing tools"
    sudo apt-get update
    sudo apt-get upgrade


    echo "*** Specific Rapsberry configs"
    # sed 's+<Word to find>+<Word use to replace>+g' input.txt
    echo "***   Changing SSH port"
    sudo sed -i "s/#Port 22/Port "$SSHPORT"/g" /etc/ssh/sshd_config
    # sudo service ssh restart

    echo "***   Changing hostname"
    echo $HOSTNAME > /etc/hostname
    sed -i "s/raspberrypi/$HOSTNAME/g" /etc/hosts
    hostname $HOSTNAME

    echo "***   Install required tools (to work as qb server mode)"
    sudo apt-get -y install python-pip
    sudo apt-get -y install python3-pip
    sudo apt-get -y install git
    sudo apt-get -y install default-jdk
    # TODO: Setup the JAVA_HOME environment variable
    sudo apt-get -y install screen
    sudo apt-get -y install avahi-daemon
    pip3 install virtualenv
    sudo curl -o /usr/local/bin/rmate https://raw.githubusercontent.com/aurora/rmate/master/rmate
    sudo chmod +x /usr/local/bin/rmate
    sudo apt-get clean

    echo "***   Building user working directories for pi user"
    mkdir -p /home/pi/Projects/Python
    mkdir -p /home/pi/Projects/Common
    mkdir -p /home/pi/Projects/Web
    sudo chown -R pi: Projects

    echo "***   Building user working directories for qb user"
    mkdir -p /home/"$NEWUSER"/Projects/Python
    mkdir -p /home/"$NEWUSER"/Projects/Common
    mkdir -p /home/"$NEWUSER"/Projects/Web
    sudo chown -R $NEWUSER: Projects

    # TODO: Config the cron jobs
    # echo "***   Setting up cron jobs"

    # TODO: Config Aliases
    # echo "***   Setting up custom alliases"

    # TODO: Config the splash screen
    # echo "***   Setting up splash screen"


    # echo "Initial setup complete. After the final reboot the server will be ready" > ~/.firstboot.log
    echo "Initial setup complete. After the final reboot the server will be ready" > /home/pi/.firstboot.log
    echo "*** Rebooting Raspberry to apply all the changes"
    sudo reboot

else

    echo "*** Firstboot setup completed. Hasta la vista!"
fi