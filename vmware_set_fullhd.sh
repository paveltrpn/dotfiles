#!/bin/bash

# Скрипт для установки 1980x1020 в Linux Mint 20 Chinnamon
# в виртуальной машине VMWare 16 Player.
# Взято здесь - https://blog.maskys.com/how-to-set-linuxs-display-resolution-to-1920x1080-in-vmware/
# chmod +x *.sh

xrandr --newmode "1920x1080"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
xrandr --addmode Virtual1 1920x1080
xrandr --output Virtual1 --mode 1920x1080
