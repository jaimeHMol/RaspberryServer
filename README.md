# RaspberryServer
Set of scripts, configurations and steps to use a Raspberry Pi 4 as a Python/Web/Database/etc server.


## Initial setup (Boot)
- [x] wpa_supplicant and ssh files (For wifi headless config)
- [x] Run shell script on boot to send a pushbullet (More info here: https://docs.pushbullet.com/v3/) with general status, private and public ip address, environment variables, tool versions, etc.
- [x] Hostname setup (raspi-config)
- [x] Update
- [x] Upgrade
- [x] Java (Open JDK)
- [x] virtualenv
- [x] avahi-daemon
- [x] rmate
- [x] screen
- [ ] docker
- [ ] X windows (X11) support (To eneable the use of tools like XQuartz or XMing)
- [ ] (ngrok)
- [ ] Custom Raspberry configs (fix HDMI issue, splash screen, avoid Raspberry go to sleep) 
- [x] Create custom users (handling permissions) in addition to pi user.
- [ ] Set up my projects folder (Python, Web, R, Commons, 0.Config)
  * Create folders
  * Git clone to my repositories
  * Deploy (call script)
- [ ] Set Aliases (call script)
- [ ] Set CronJobs (call script)


## Deployments
* Django webapps
* Http server (static wepages)


## Aliases


## CronJobs
* Modem automated config


## Dependencies
* Raspbian custom image to run a shell script on first boot: https://github.com/nmcclain/raspberian-firstboot 
* Pushbullet API: https://docs.pushbullet.com/v3/
