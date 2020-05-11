# RaspberryServer

## First boot setup

* Don't forget to edit the `wpa_supplicant.conf` file with information of your wifi network name and password if you want the Raspberry to be connected to your network automatically (headless mode: with neither monitor nor keyboard) every time it turns on.

* The `ssh` file will remain as it is (its content doesn't matter).

* The `firstboot.sh` contains all the steps we want to be executed at the first boot of the raspberry (to get it ready working as a server from the begging).

* Put the `wpa_supplicant.conf`, the `ssh` and the `firstboot.sh` files in the root folder inside the raspbian image (usually called boot) that you are going to flash to the SD card. Remember, this should be a customized image in order to run automatically this configurations on the very first boot. You can find that images here: https://github.com/nmcclain/raspberian-firstboot/releases 
