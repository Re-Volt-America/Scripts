#!/bin/bash

readonly GAMEFILES_URL=https://distribute.re-volt.io/packs/game_files.zip
readonly RVGL_LINUX_URL=https://distribute.re-volt.io/packs/rvgl_linux.zip
readonly ASSETS_URL=https://distribute.re-volt.io/packs/rvgl_assets.zip
readonly SOUNDTRACK_URL=https://distribute.re-volt.io/packs/soundtrack.zip
readonly DREAMCAST_PACK_URL=https://distribute.re-volt.io/packs/rvgl_dcpack.zip
readonly RVA_PACK_URL=https://github.com/Re-Volt-America/RVA/releases/download/1.0/RVA.tar
readonly DESKTOP_LOGO_URL=https://user-images.githubusercontent.com/5833446/75056793-fb5b7c00-54d7-11ea-9247-9a5bcd8567bb.png

mkdir Re-Volt && cd Re-Volt
readonly INSTALL_PATH=$(pwd)

echo Installing Re-Volt...

echo Installing required packages...
sudo apt install libsdl2-2.0-0 libsdl2-image-2.0-0
sudo apt install libopenal1 libenet7 libunistring2
sudo apt install libjpeg8 libpng16-16 libtiff5 libwebp6
sudo apt install libvorbisfile3 libflac8 libmpg123-0 libfluidsynth1

echo Verifying wget package...
sudo apt-get install wget

echo Verifying unzip package...
sudo apt-get install unzip

echo Verifying git package...
sudo apt-get install git

wget $GAMEFILES_URL
wget $RVGL_LINUX_URL
wget $ASSETS_URL
wget $SOUNDTRACK_URL
wget $DREAMCAST_PACK_URL
wget $RVA_PACK_URL
wget $DESKTOP_LOGO_URL

unzip -o game_files.zip
unzip -o soundtrack.zip
unzip -o rvgl_assets.zip
unzip -o rvgl_linux.zip
unzip -o rvgl_dcpack.zip
tar -xvf RVA.tar
mv 75056793-fb5b7c00-54d7-11ea-9247-9a5bcd8567bb.png bolt.png

cd ~/Desktop

cat > Re-Volt.desktop << EOF1
[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Icon=$INSTALL_PATH/bolt.png
Exec=$INSTALL_PATH/rvgl
Name=Re-Volt
EOF1

gio set Re-Volt.desktop metadata::trusted yes
chmod +x Re-Volt.desktop

echo Installation complete!
echo A shortcut has added to your Desktop.
echo Double-click it to launch Re-Volt.
