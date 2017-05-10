
echo -n "setting config"
cp ./retrograme.cfg.6button /boot/retrogame.cfg

echo -n "installing retrogame..."
cp ./retrogame /usr/local/bin
chmod 755 /usr/local/bin/retrogame


echo "config stuff:"
# Add udev rule (will overwrite if present)
echo "SUBSYSTEM==\"input\", ATTRS{name}==\"retrogame\", ENV{ID_INPUT_KEYBOARD}=\"1\"" > /etc/udev/rules.d/10-retrogame.rules

# Start on boot
grep retrogame /etc/rc.local >/dev/null
if [ $? -eq 0 ]; then
  # retrogame already in rc.local, but make sure correct:
  sed -i "s/^.*retrogame.*$/\/usr\/local\/bin\/retrogame \&/g" /etc/rc.local >/dev/null
else
  # Insert retrogame into rc.local before final 'exit 0'
  sed -i "s/^exit 0/\/usr\/local\/bin\/retrogame \&\\nexit 0/g" /etc/rc.local >/dev/null
fi
echo "OK"
