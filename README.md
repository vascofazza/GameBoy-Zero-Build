# Game-Boy-Zero-setup

![Front](/images/gbzero.jpg)

![Back](/images/gbzero-back.jpg)

## Introduction
This project is a quick start configuration script for the Game Boy Zero Retropie build.
It includes several features:

*  WiFi credential setup
*  Adafruit Retrogame software installation (hardware buttons)
*  Custom **config.txt** ready for **BW** 3.5" screen
*  Automatic screen rotation when connected through HDMI (the composite screen is mounted upside down)
*  Python script for **Graceful shutdown** circuitry handling
*  Python script for **Battery Level** meter (https://github.com/vascofazza/gbzattinymonitor)
*  Disable the initial boot logo (goes directly to the splashscreen without prompts)
*  Invert the status led behaviour for power saving (the led is powered on sd activity)
*  Downloads a fixed version of pifba for joypad compability
*  Added RTC (Real Time Clock) configuration for DS3231  (**NEW!**)
*  Added **install_extra.sh** configuration script for super performances!  (**BETA**)

Features included in **install_extra.sh**:

* Map *log* and *tmp* folders to ramdisk
* Swap ram to disk only if strictly needed
* Replaces the *samba server* with *ProFTP server* (more resource-friendly)
* Replaces *OpenSSH* with *DropBear* SSH server (more resource-friendly)
* Removes *avahi-daemon*, you cannot use retropie.local in local network, **retropie.lan still works** :)

## Hardware
This simple schematic illustrates the **Graceful shutdown** mechanism.

![Graceful shutdown](/schematics/graceful_shutdown.png)

For the **Battery Level** circuit check out [this project!](https://github.com/vascofazza/gbzattinymonitor)

## Installation
```
$ git clone https://github.com/vascofazza/GameBoy-Zero-Build.git
$ cd GameBoy-Zero-Build/
$ sudo bash install.sh
```
