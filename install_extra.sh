#!bin/sh

#ramdisk
echo "tmpfs /var/log tmpfs defaults,size=20m,noatime,nodev,nosuid,mode=1777 0 0" >> /etc/fstab
echo "tmpfs /tmp tmpfs defaults,size=10m,noatime,nodev,nosuid,mode=1777 0 0" >> /etc/fstab

#swap iff strictly needed
echo "vm.swappiness = 1" >> /etc/sysctl.conf 

#install DropBear over OpenSSH
sudo apt-get --assume-yes install dropbear
sed -i -- "s/NO_START=1/NO_START=0/g" /etc/default/dropbear

sudo /etc/init.d/ssh stop
sudo /etc/init.d/dropbear start
sudo apt-get purge openssh-server -y

sudo cp configs/prepare-dirs /etc/init.d/
sudo chmod 755 /etc/init.d/prepare-dirs
sudo update-rc.d prepare-dirs defaults 01 99

sudo apt-get purge samba -y
sudo apt-get install proftpd -y

sudo nano /etc/proftpd/proftpd.conf

#set 'UseIPv6' to 'off' (...if not using IPv6)
#change 'ServerName'
#uncomment 'AuthOrder'
#ctrl+x, y, enter

sudo apt-get purge avahi-daemon -y

sudo apt-get autoremove --purge

sudo systemctl disable triggerhappy
sudo systemctl stop triggerhappy
