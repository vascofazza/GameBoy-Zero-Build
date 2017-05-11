import os
from gpiozero import Button
from signal import pause

powerGPIO = 4
def shutdown():
    os.system("sudo shutdown -h now")

shutdown_btn = Button(powerGPIO, pull_up=True, bounce_time=0.5)
shutdown_btn.when_released = shutdown
pause()
