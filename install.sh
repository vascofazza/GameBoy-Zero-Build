#!/bin/sh

read -p "Do you want to install wpa_supplicant and connect to internet via WI-FI? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    killall wpa_supplicant
    cp configs/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf
    wpa_supplicant -Dnl80211 -iwlan0 -c/etc/wpa_supplicant/wpa_supplicant.conf
    sleep 5
fi

read -p "Do you want to install Adafruit Retrogame? for button support?" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    cd gpio-to-vkeyboard
    bash install.sh
    cd ..
fi

#Configurations
echo "Installing configurations"
sed -i -- 's/console=tty1/console=tty3/g' cmdline.txt #disable start/shutdown text
cp configs/config.txt /boot/config.txt
# Insert shutdown script into rc.local before final 'exit 0'
sed -i "s/^exit 0/bash \/home\/pi\/scripts\/screen.sh \&\\nexit 0/g" /etc/rc.local >/dev/null
# Insert shutdown script into rc.local before final 'exit 0'
sed -i "s/^exit 0/python \/home\/pi\/scripts\/shutdown.py \&\\nexit 0/g" /etc/rc.local >/dev/null
# Insert battery script into rc.local before final 'exit 0'
#sed -i "s/^exit 0/python \/home\/pi\/scripts\/battery.py \&\\nexit 0/g" /etc/rc.local >/dev/null

##battery meter stuff
echo "Installing libraries"
apt-get update
apt-get --assume-yes install vim
apt-get --assume-yes install htop
apt-get --assume-yes install i2c-tools
apt-get --assume-yes install python-smbus
apt-get --assume-yes install python-pkg-resources
apt-get --assume-yes install python-gpiozero

#scripts
echo "Installing scripts"
mkdir /home/pi/scripts
chown pi /home/pi/scripts
cp scripts/screen.sh /home/pi/scripts/screen.sh
cp scripts/shutdown.py /home/pi/scripts/shutdown.py
#cp scripts/battery.py /home/pi/scripts/battery.py
chmod 755 scripts/shutdown.py
chmod 755 scripts/screen.sh
#chmod 755 scripts/battery.py

echo "The system will reboot in 5 seconds"
sleep 5
reboot
exit
