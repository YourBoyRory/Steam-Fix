#!/bin/bash

#    _____        _____
#   / _ \ \      / / _ \
#  | | | \ \ /\ / / | | |
#  | |_| |\ V  V /| |_| |
#   \___/  \_/\_/  \___/
# Organized Web Operations
# YourBoyRory
# v1.0

touch ~/.steamfix.encrypted

if [[ $1 == "-s" ]] || [[ $2 == "-s" ]]; then
	echo "Stopping Steam"
	killall steam
	echo "Waiting for steam to close"
	sleep 10
	ps aux | grep "Steam" | grep -v "grep" | grep -v "steamfix"
	if [[ $? -eq 0 ]]; then
		echo "Steam is still running and may have crashed, run without -s"
		exit
	fi
fi

if [[ $1 == "" ]] || [[ $1 == "-n" ]] && [[ $2 == "" ]]; then
	echo "Force killing Steam"
	c=0
	while [[ $c -eq 0 ]]; do
		killall -9 steam
		c=$?
		sleep 1
	done
fi

if [[ $1 == "-n" ]] || [[ $2 == "-n" ]]; then
	echo "-n detected: skipping Steam launch"
	exit
fi

if [[ $1 == "--set-login" ]]; then
	inData=$(openssl aes-256-cbc -d -pbkdf2 -in ~/.steamfix.encrypted -pass pass:"CHANGE_KEY")
	inData=$(echo $inData | cut -f 1 -d " ")
	outData=$(yad --title="Set Login" --fixed --center \
	--text="Enter the Login to the steam account. \nPasswords are encrypted with AES-256." \
	--image="dialog-password" \
	--form --align=center --separator=" " \
		--field=Username \
		--field=Password:H \
		$inData
	)
	if [[ $? -eq 0 ]]; then
		echo $outData | $(openssl aes-256-cbc -pbkdf2 -out ~/.steamfix.encrypted -pass pass:"CHANGE_KEY")
	fi
	exit
fi

if [[ $1 == "-h" ]]; then
	echo "    "
	echo "    _____        _____    "
	echo "   / _ \ \      / / _ \   "
	echo "  | | | \ \ /\ / / | | |  "
	echo "  | |_| |\ V  V /| |_| |  "
	echo "   \___/  \_/\_/  \___/   "
	echo " Organized Web Operations "
	echo " YourBoyRory "
	echo "    "
	echo " SteamFix is a bash script writen by Rory and compiled with shc"
	echo " Here is some documentation for this horible program:"
	echo "    "
	echo "    steamfix [arguments]"
	echo "    "
	echo "    "
	echo "    -h                Help."
	echo "    -s                Stops steam in a nice way, lets it wrap up what its doing first."
	echo "    -n                Does not launch steam after killing it."
	echo "    "
	echo "    --set-login      Open GUI that stores username and password to pass it to steam on launch"
	echo "                     Use only if steam constantly required re-auth such as when using a VPN"
	echo "                     Requires yad and openssl"
	echo "    "
	exit
fi

inData=$(openssl aes-256-cbc -d -pbkdf2 -in ~/.steamfix.encrypted -pass pass:"CHANGE_KEY")
if [[ $inData == "" ]]; then
	echo "Starting Steam in background"
	(steam)&
	exit
fi

echo "Starting Steam in background"
echo "Passing login"
(steam -login $(openssl aes-256-cbc -d -pbkdf2 -in ~/.steamfix.encrypted -pass pass:"CHANGE_KEY"))&
