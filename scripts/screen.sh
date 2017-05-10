#!/bin/sh -e

# If running headless (i.e. default RCA video)
if /opt/vc/bin/tvservice -s | grep 'NTSC\|PAL'; then
  echo $(hostname) is running Headless
  /opt/vc/bin/tvservice -s
  if grep -Fxq "display_rotate=0" /boot/config.txt
   then
    sudo sed -i -- 's/display_rotate=0/display_rotate=2/g' /boot/config.txt
    sudo sed -i -- 's/#overscan_/overscan_/g' /boot/config.txt
    sudo sed -i -- 's/#framebuffer/framebuffer/g' /boot/config.txt
    sudo reboot
   fi
else
  echo $(hostname) is running hdmi
if grep -Fxq "display_rotate=2" /boot/config.txt
   then
    sudo sed -i -- 's/display_rotate=2/display_rotate=0/g' /boot/config.txt
    sudo sed -i -- 's/overscan_/#overscan_/g' /boot/config.txt
    sudo sed -i -- 's/framebuffer/#framebuffer/g' /boot/config.txt
    sudo reboot
   fi
fi
