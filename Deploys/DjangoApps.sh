ps auxw | grep runserver
ps auxw | grep "runserver..8000" # To search id of django server in port 8000 process
kill id

pkill runserver


cd ~/Projects/Python/QBProject



#!/bin/sh

REPOSRC=$1
LOCALREPO=$2

# We do it this way so that we can abstract if from just git later on
LOCALREPO_VC_DIR="$LOCALREPO"/.git

if [ ! -d $LOCALREPO_VC_DIR ]
then
    echo ""
    echo "Cloning the repo..."
    git clone "$REPOSRC" "$LOCALREPO"
else
    echo ""
    echo "Repo already exist, pulling last version..."
    (cd "$LOCALREPO")
    git pull "$REPOSRC"
fi

# End
