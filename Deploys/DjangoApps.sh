#!/bin/sh

# -----------------------
# Django automated deploy
# -----------------------
# 1. Stop Django active servers
# 2. Create paths
# 3. Clone or pull the repository
# 4. Create and activate virtual environments
# 5. Install dependencies on virtual environment
# 6. Run Django migrations
# 7. Run Django server
#
# 24 April 2020 - @jaimeHMol


# Constants (eventually inputs)
# -----------------------------
PORT=8000
REPOSRC=https://github.com/jaimeHMol/QB.git
LOCALREPO=~/Projects/Python/QBProject



echo Stoping Django active servers...

# ps auxw | grep runserver
djangoProcess=`ps auxw | grep "runserver..$PORT"` # To search id of django server in port 8000 process
set -- $djangoProcess
processID=$2
kill $processID

# pkill runserver


# echo Creating paths...
# cd ~/Projects/Python/QBProject
#
#
# echo Connecting to repository...
#
# echo    Cloning repository...
#
# echo    Pulling last version of the repository...
#
#
#
# echo  Creating virtual environment...
#
# echo    Virtual environment already created
#
#
#
# echo  Installing dependencies on the virtual environment...
#
#
#
# echo  Running Django migrations...
#
#
#
# echo  Running Django server...
#
#
#
# echo Finishing autodeployment.
#
#
#
#
#
#
#
#
#
# # We do it this way so that we can abstract if from just git later on
# LOCALREPO_VC_DIR="$LOCALREPO"/.git
#
# if [ ! -d $LOCALREPO_VC_DIR ]
# then
#     echo ""
#     echo "Cloning the repo..."
#     git clone "$REPOSRC" "$LOCALREPO"
# else
#     echo ""
#     echo "Repo already exist, pulling last version..."
#     (cd "$LOCALREPO")
#     git pull "$REPOSRC"
# fi
#
# # End
