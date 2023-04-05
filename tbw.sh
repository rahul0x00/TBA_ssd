#!/bin/bash

#Prompting the User to enter the device name(e.g./dev/sda)
read -p "Enter the device name(e.g. /dev/sda): " device_name

#Getting the Sector Size value for the device
sector_size=$(sudo smartctl -i $device_name | awk '/^Logical Sector Size|Sector Sizes/ {print $3}')

# Getting the Total_LBAs_Written value for the device
lba=$(sudo smartctl -A $device_name | awk '/^246/ {print $10}')

#Calculating total byte writeen data
tbw_g=$(bc -l <<< "$sector_size * $lba / 1024^3")

# Print the total written data in gigabytes
#echo "*** $(date -R) ***" 
printf "Total written data(tbw) for $device_name is: %.2f GB\n" "$tbw_g"
