# Game-Boy-Zero-setup

![Front](/images/gbzero.jpg)

![Back](/images/gbzero-back.jpg)

## Introduction
This project is a quick start configuration script for the Game Boy Zero Retropie build.
It includes several features:

*  WiFi credential setup
*  Adafruit Retrogame software installation
*  Custom **config.txt** configured for **BW** screen
*  Automatic screen rotation when connected through HDMI (the composite screen is mounted upside down)
*  Python script for **Graceful shutdown** circuitry handling
*  Python script for **Battery Level** meter (**NEW!**)
*  Disable the initial boot logo (goes directly to the splashscreen without prompts) (**NEW!**)
*  Invert the status led behaviour for power saving (the led is powered on sd activity) (**NEW!**)
*  Downloads a fixed version of pifba for joypad compability (**NEW!**)

## Hardware
This simple schematic illustrates the **Graceful shutdown** mechanism.

![Graceful shutdown](/schematics/graceful_shutdown.png)

For the **Battery Level* circuit check out [this project!](https://github.com/vascofazza/gbzattinymonitor)

## Installation
```
$ git clone https://github.com/vascofazza/GameBoy-Zero-Build.git
$ cd GameBoy-Zero-Build/
$ sudo bash install.sh
```
