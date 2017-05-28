#!bin/sh

#ramdisk
#map log and tmp directories to a ramdisk to improve sd life
echo "tmpfs /var/log tmpfs defaults,size=20m,noatime,nodev,nosuid,mode=1777 0 0" >> /etc/fstab
echo "tmpfs /tmp tmpfs defaults,size=10m,noatime,nodev,nosuid,mode=1777 0 0" >> /etc/fstab

#since the tmp and log folders are now ramdisk we need to create the needed folder structures upon startup.
sudo cp configs/prepare-dirs /etc/init.d/
sudo chmod 755 /etc/init.d/prepare-dirs
sudo update-rc.d prepare-dirs defaults 01 99

#swap iff strictly needed. Also improves sd life and overall system speed
echo "vm.swappiness = 1" >> /etc/sysctl.conf

#install DropBear over OpenSSH
sudo apt-get --assume-yes install dropbear
sed -i -- "s/NO_START=1/NO_START=0/g" /etc/default/dropbear

sudo /etc/init.d/ssh stop
sudo /etc/init.d/dropbear start
sudo apt-get purge openssh-server -y

#remove the samba client (use ftp instead)
sudo apt-get purge samba -y
sudo apt-get install proftpd -y

#configure proftpd
echo "set 'UseIPv6' to 'off' (...if not using IPv6)"
echo "change 'ServerName'"
echo "uncomment 'AuthOrder'"
echo "ctrl+x, y, enter"
sleep(5)
sudo nano /etc/proftpd/proftpd.conf

# remove avahi-daemon
sudo apt-get purge avahi-daemon -y
# remove all unused packages
sudo apt-get autoremove --purge

sudo systemctl disable triggerhappy
sudo systemctl stop triggerhappy
