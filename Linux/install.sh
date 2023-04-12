#!/bin/bash

# Compiles shell script to bin using shc, if that fails it will just copy the shell script
rand=$(echo $(date +%s) | md5sum | head -c 32)			# generates a system wide encryption key for password manager
cp "./steamfix_linux.sh" "./steamfix_temp"				# creates temp file for adding the encryption key
chmod 600 ./steamfix_temp								# makes it only readable by this user
sed -i "s/CHANGE_KEY/$rand/g" "./steamfix_temp"			# add encryption key to temp file
sudo shc -f "./steamfix_temp" -o "/usr/bin/steamfix"	# compiles temp file into bin to /usr/bin/
rm "./steamfix_temp"									# deletes temp file

# Puts assets in the right place
sudo mkdir "/opt/steamfix/" 2> /dev/null				# makes dir for assests
sudo cp "./icon.png" "/opt/steamfix/icon.png"			# moves programs only assest (icon.png)

# Creates System Wide Launcher Entry
echo "[Desktop Entry]
Name=SteamFix
Comment=SteamFix
Keywords=Steam
Exec=/usr/bin/steamfix
Terminal=false
Icon=/opt/steamfix/icon.png
Type=Application
StartupNotify=false
Categories=Game;" | sudo tee -a /usr/share/applications/steamfix.desktop
