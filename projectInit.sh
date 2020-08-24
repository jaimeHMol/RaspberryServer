#!/bin/bash

echo "*** Executing project initialization"

# Constants
PROJECTNAME=BusClassifier
PROJECTDIRECTORY=~/Projects/Python/${PROJECTNAME}Workspace/
VIRTUALENVIRONMENTNAME=venv

echo "***   Creating directory structure"
mkdir $PROJECTDIRECTORY
cd $PROJECTDIRECTORY
mkdir $PROJECTNAME
cd $PROJECTNAME
mkdir data data/raw data/prepared data/prepared/train data/prepared/test data/prepared/validation \
metrics model src


echo "***   Creating and activating virtual environment"
cd $PROJECTDIRECTORY
virtualenv $VIRTUALENVIRONMENTNAME
source $VIRTUALENVIRONMENTNAME/bin/activate

echo "***   Installing modules"
pip3 install jupyter



echo "***   Generating requirements.txt"
cd $PROJECTDIRECTORY/$PROJECTNAME
pip3 freeze > requirements.txt




echo "*** Finishing project initialization"
# sudo reboot
