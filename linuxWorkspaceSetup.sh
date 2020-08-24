#!/bin/bash

echo "*** Executing linuxWorkspaceSetup script"

# Constants
NEWUSER=jaimehmol


echo "*** Updating existing tools"
sudo apt-get update
sudo apt-get upgrade

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
