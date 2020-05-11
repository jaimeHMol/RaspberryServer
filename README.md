# RaspberryServer
Set of scripts, configurations and steps to use a Raspberry Pi 4 as a Python/Web/Database/etc server.


## Initial setup
- [x] wpa_supplicant and ssh files (For wifi headless config)
- [x] run shell script on boot to send a pushbullet.py with status and ip-address (SSH ready). Get and send public and private ip adress. Send environment variables, tool versions, etc.
- [x] Hostname setup (raspi-config)
- [x] update
- [x] upgrade
- [x] virtualenv
- [x] avahi-daemon
- [x] rmate
- [x] screen
- [ ] docker
- [ ] (ngrok)
- [ ] Custom Raspberry configs (fix HDMI issue, splash screen, avoid Raspberry go to sleep) 
- [x] Create custom users (handling permissions) in addition to pi user.
- [ ] Set up my projects folder (Python, Web, R, Commons, 0.Config)
  * Create folders
  * Git clone to my repositories
  * Deploy (call script)
- [ ] Set Aliases (call script)
- [ ] Set CronJobs (call script)


## Aliases


## Deploy
* Django webapps
* Http server (static wepages)


## CronJobs
* Modem automated config


## Dependencies
* Raspbian custom image to run a shell script on first boot: https://github.com/nmcclain/raspberian-firstboot 
