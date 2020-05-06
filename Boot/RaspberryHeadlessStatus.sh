


# Constants
PUSHBULLETKEY = "o.NMEh6dZhlsNQX4IwH0EYQaeXZzmWSeUI"

# Get ip address
hostname -I
# ifconfig (Wlan0)


# Get tool current versions
apt --version
python --version
python3 --version
virtualenv --version
screen --version
avahi-daemon --version
rmate --version


# Sending a Pushbullet message reporting the Raspberry status
curl -u o.NMEh6dZhlsNQX4IwH0EYQaeXZzmWSeUI: -X POST https://api.pushbullet.com/v2/pushes --header 'Content-Type: application/json' --data-binary '{"type": "note", "title": "Sending push from unix terminal", "body": "Testing send a pushbullenmap