#!/bin/sh
if [ $1 -eq "cyc" ]
do 
    networksetup -setairportpower en0 off
    networksetup -setairportpower en0 on 
done;
else if [ $1 -eq "on" ] or [ $1 -eq "off" ]
do
    networksetup -setairportpower en0 $1
done;
else
do
    echo "Usage: w on/off/cyc"
    echo "on turns wifi on, off turns wifi off, cyc turns wifi off then on"
done;
