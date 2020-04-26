# -----------------------
# Django automated deploy
# -----------------------
# 1. Stop Django active servers (This will kill all the django apps running at the
#    entered port, either if they are running in first plane or in background).
# 2. Create paths
# 3. Clone or pull the repository
# 4. Create and activate virtual environments
# 5. Install dependencies on virtual environment
# 6. Run Django migrations
# 7. Run Django server in local or server mode
#
# Having in mind a Django project folder structure like this:
# ~/                              (User folder, ej: /Users/jherran/)
# ├── Projects/
# │   ├── Python/
# │   │   ├── <AppName>Project/   (ej: QBProject)
# │   │   │   ├── venv/           (virtual environment folder)
# │   │   │   ├── <AppName>/      (ej: QB)
# │   │   │   │   ├── <AppName>/  (Main Django project App, ej: QB)
# │   │   │   │   ├── <AppName1>/ (App1 of the Django project, ej: QBAnalytics)
# │   │   │   │   ├── <AppName2>/ (App2 of the Django project, ej: QBShopCart)
# │   │   │   │   └── <AppName3>/ (App3 of the Django project, ej: QBShowcase)
# :   :   :   :
# :   :   :   :
#
# 24 April 2020 - @jaimeHMol


# Constants (eventually inputs)
# -----------------------------
PORT=7000
REPOSRC=https://github.com/jaimeHMol/QB.git
LOCALREPO=~/Projects/Python/OpenQBProject/OpenQB
VIRTUALENVNAME=venv
MODE=server  # MODE: local  -> to run on localhost using the same terminal session.
            #       server -> to keep running as a daemon (require screen installed).
            #                 YOU WILL LOSE ALL THE UN-PUSHED CHANGES (you shouldn't
            #                 be developing on the server!!!)


SCREENNAME=QBScreenSession


echo "*** Stoping Django active servers..."
processID=$(ps auxw | awk -v port="$PORT" '$11~"/python3" && $14~":"port {print $2}')
# set -- $processID
# ps auxw | grep runserver
# djangoProcess=`ps auxw | grep "runserver..$PORT"` # To search id of django server in port 8000 process
# set -- $djangoProcess
# processID=$2
# pkill runserver
if kill $processID; then
  echo "*** Process "$processID" was killed."
else
  echo "*** No Django app running on the entered port."
fi


echo "*** Creating project folder and local repo folder (if doesn't exist)..."
rootProjectFolder="${LOCALREPO%/*}/"
# mkdir -p $rootProjectFolder
mkdir -p $LOCALREPO

echo "*** Connecting to repository..."

# We do it this way so that we can abstract if from just git later on
localGitRepoExists="$LOCALREPO"/.git

if [ ! -d $localGitRepoExists ]; then
    echo "   *** Cloning repository..."
    git clone "$REPOSRC" "$LOCALREPO"
else
    echo "   *** Pulling last version of the repository..."
    cd "$LOCALREPO"
    # git fetch "$REPOSRC"
    git fetch
    # git checkout .e
    if [ "$MODE" == "server" ]; then
      git reset --hard origin/master
    fi
fi


echo  "*** Creating virtual environment..."
if [ -d "$rootProjectFolder"/"$VIRTUALENVNAME" ]; then
  echo "Virtual environment already created"
else
  echo "Virtual environment will be created"
  cd "$rootProjectFolder"
  virtualenv --no-site-packages "$VIRTUALENVNAME"
fi


echo  "*** Activating virtual environment..."
cd "$rootProjectFolder"
source "$VIRTUALENVNAME"/bin/activate


echo  "*** Installing dependencies on the virtual environment..."
cd "$LOCALREPO"
pip3 install -r requirements.txt


echo  "*** Running Django migrations..."
cd "$LOCALREPO"
python3 manage.py makemigrations
python3 manage.py migrate


if [ "$MODE" == "local" ]; then
  echo  "*** Running Django app in local mode..."
  echo  "*** Your webapp will run in this same session. Go to your browser at 127.0.0.1:$PORT"
  python3 manage.py runserver 127.0.0.1:"$PORT"
  echo  "*** Local deployment session ended."

elif [ "$MODE" == "server" ]; then
  echo  "*** Running Django app in server mode (You need Screen installed!!!)..."
  # Create screen if it doesn't exist
  if ! screen -list | grep $SCREENNAME >/dev/null ; then
    screen -dmS $SCREENNAME
  fi

  screen -S $SCREENNAME -d -m python3 manage.py runserver 0.0.0.0:"$PORT"
  echo "*** Autodeployment finished. Go to your browser at <ip or domain name>:$PORT if you don't know it just use 0.0.0.0:$PORT"

  # You can resume a dettached screen session running:
  # screen -list # To get the list of active screen sessions (session IDs)
  # screen -r <session ID>
  #
  # You can kill a dettaced screen session running:
  # screen -X -S <session ID> quit

fi
