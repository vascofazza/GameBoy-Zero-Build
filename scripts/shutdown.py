import RPi.GPIO as GPIO
import os
import sys
import time


powerGPIO = 4
GPIO.setmode(GPIO.BCM)
GPIO.setup(powerGPIO, GPIO.IN, pull_up_down=GPIO.PUD_UP)

while True:
  time.sleep(1)
  if GPIO.input(powerGPIO) is 1:
    os.system("sudo shutdown -h now")
