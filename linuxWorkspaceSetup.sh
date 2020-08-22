#!/bin/bash

echo "*** Executing linuxWorkspaceSetup script"

# Constants
PUSHBULLETKEY="PUT_YOUR_PUSHBULLET_API_ACCESS_TOKEN_HERE"
HOSTNAME="YOUR_CUSTOM_HOST_NAME"
SSHPORT=22
NEWUSER=adminUser


# echo "*** Creating new user (qb user) forcing them to change their passwod in next login"
# sudo useradd -m "$NEWUSER"
# sudo adduser "$NEWUSER" sudo
# echo "$NEWUSER:raspberry" | sudo chpasswd
# sudo passwd -e $NEWUSER

echo "*** Updating existing tools"
sudo apt-get update
sudo apt-get upgrade


# echo "*** Specific Rapsberry configs"
# # sed 's+<Word to find>+<Word use to replace>+g' input.txt
# echo "***   Changing SSH port"
# sudo sed -i "s/#Port 22/Port "$SSHPORT"/g" /etc/ssh/sshd_config
# # sudo service ssh restart

# echo "***   Changing hostname"
# echo $HOSTNAME > /etc/hostname
# sed -i "s/raspberrypi/$HOSTNAME/g" /etc/hosts
# hostname $HOSTNAME

echo "***   Install workspace tools "
sudo apt-get -y install python-pip
sudo apt-get -y install python3-pip

sudo apt-get -y install git
sudo apt-get -y install default-jdk
# TODO: Setup the JAVA_HOME environment variable
sudo apt-get -y install screen
sudo apt-get -y install avahi-daemonF
sudo pip3 install virtualenv
sudo curl -o /usr/local/bin/rmate https://raw.githubusercontent.com/aurora/rmate/master/rmate
sudo chmod +x /usr/local/bin/rmate
sudo apt-get clean

echo "***   Building user working directories for qb user"
mkdir -p /home/"$NEWUSER"/Projects/Python
mkdir -p /home/"$NEWUSER"/Projects/Common
mkdir -p /home/"$NEWUSER"/Projects/Web
sudo chown -R $NEWUSER: Projects

echo "***   Setting global git config"
git config --global user.name "JaimeHMol"
git config --global user.email "jaimehmol@yahoo.com"
echo "*.vscode*" >> ~/.gitignore
echo "*no-commit.*" >> ~/.gitignore
git config --global core.excludesFile ~/.gitignore

# TODO: Config the cron jobs
# echo "***   Setting up cron jobs"

# TODO: Config Aliases
# echo "***   Setting up custom alliases"

echo "*** Finishing linuxWorkspaceSetup script"
# sudo reboot
