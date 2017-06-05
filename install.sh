#!/bin/sh

read -p "Do you want to install wpa_supplicant and connect to internet via WI-FI? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    killall wpa_supplicant
    cp configs/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf
    wpa_supplicant -Dnl80211 -iwlan0 -c/etc/wpa_supplicant/wpa_supplicant.conf
    ifup -a
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
if ! grep -Fxq "console=tty1" /boot/cmdline.txt
then
    sed -i -- 's/console=tty1/console=tty3/g' /boot/cmdline.txt #disable start/shutdown text
fi
if ! grep -Fxq "logo.nologo" /boot/cmdline.txt
then
echo -n " logo.nologo" >> /boot/cmdline.txt #disable start/shutdown text
fi
cp configs/config.txt /boot/config.txt
# Insert shutdown script into rc.local before final 'exit 0'
if ! grep -Fxq "bash /home/pi/scripts/screen.sh &" /etc/rc.local
then
    sed -i "s/^exit 0/bash \/home\/pi\/scripts\/screen.sh \&\\nexit 0/g" /etc/rc.local >/dev/null
fi
# Insert shutdown script into rc.local before final 'exit 0'
if ! grep -Fxq "python /home/pi/scripts/shutdown.py &" /etc/rc.local
then
    sed -i "s/^exit 0/python \/home\/pi\/scripts\/shutdown.py \&\\nexit 0/g" /etc/rc.local >/dev/null
fi

##battery meter stuff
echo "Installing libraries"
apt-get update
apt-get --assume-yes install vim
apt-get --assume-yes install htop
apt-get --assume-yes install i2c-tools
apt-get --assume-yes install python-smbus
apt-get --assume-yes install python-pkg-resources
apt-get --assume-yes install python-gpiozero
apt-get --assume-yes install libpng12-dev

#scripts
echo "Installing scripts"
mkdir /home/pi/scripts
chown pi /home/pi/scripts
cp scripts/screen.sh /home/pi/scripts/screen.sh
cp scripts/shutdown.py /home/pi/scripts/shutdown.py
chmod 755 scripts/shutdown.py
chmod 755 scripts/screen.sh

#Battery monitor
read -p "Do you want to install the Battery Meter Script?" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
mkdir gbzattinymonitor
cd gbzattinymonitor/
wget https://raw.githubusercontent.com/vascofazza/gbzattinymonitor/master/Install.sh
chmod +x Install.sh
bash Install.sh
fi

#RTC module
read -p "Do you want to install the RTC module configurations?" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
sed -i -- 's/#dtoverlay=i2c-rtc,ds3231/dtoverlay=i2c-rtc,ds3231/g' /boot/config.txt #enable rtc
apt-get -y purge fake-hwclock
update-rc.d -f fake-hwclock remove
cp configs/hwclock-set /lib/udev/hwclock
date
hwclock -w
hwclock -r
fi

#autosave
read -p "Do you want to enable autosave to disk?" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
sed -i -- 's/# autosave_interval =/
autosave_interval = 60/g' /opt/retropie/configs/all/retroarch.cfg #enable autosave
fi

#fixed version of pifba
read -p "Do you want to download Lumberjack's pifba fixed version for NEOGEO?" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
wget https://github.com/digitalLumberjack/pifba/releases/download/0.3/pifba-0.3.zip -P /home/pi/
fi


echo "The system will reboot in 5 seconds"
sleep 5
reboot
exit
