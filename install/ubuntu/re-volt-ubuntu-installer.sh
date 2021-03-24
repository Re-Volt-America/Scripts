#!/bin/bash

readonly GAMEFILES_URL=https://distribute.re-volt.io/packs/game_files.zip
readonly RVGL_LINUX_URL=https://distribute.re-volt.io/packs/rvgl_linux.zip
readonly ASSETS_URL=https://distribute.re-volt.io/packs/rvgl_assets.zip
readonly SOUNDTRACK_URL=https://distribute.re-volt.io/packs/soundtrack.zip
readonly DREAMCAST_PACK_URL=https://distribute.re-volt.io/packs/rvgl_dcpack.zip
readonly RVA_PACK_URL=https://github.com/Re-Volt-America/RVA/releases/download/1.0/RVA.tar
readonly DESKTOP_LOGO_URL=https://user-images.githubusercontent.com/5833446/75056793-fb5b7c00-54d7-11ea-9247-9a5bcd8567bb.png

if [ ! -d Re-Volt ]
then
    mkdir ./Re-Volt
fi

cd ./Re-Volt || exit

readonly INSTALL_PATH=$(pwd)
readonly DESKTOP_PATH=$(xdg-user-dir DESKTOP)

echo Installing Re-Volt...
echo Installing required libraries...
sudo apt install -y libsdl2-2.0-0 libsdl2-image-2.0-0
sudo apt install -y libopenal1 libenet7 libunistring2
sudo apt install -y libjpeg8 libpng16-16 libtiff5 libwebp6
sudo apt install -y libvorbisfile3 libflac8 libmpg123-0 libfluidsynth1

echo Verifying wget package...
sudo apt install -y wget

echo Verifying unzip package...
sudo apt install -y unzip

wget $GAMEFILES_URL
wget $RVGL_LINUX_URL
wget $ASSETS_URL
wget $SOUNDTRACK_URL
wget $DREAMCAST_PACK_URL
wget $DESKTOP_LOGO_URL
wget $RVA_PACK_URL

unzip -o game_files.zip
unzip -o soundtrack.zip
unzip -o rvgl_assets.zip
unzip -o rvgl_linux.zip
unzip -o rvgl_dcpack.zip

mkdir rva
tar -xvf RVA.tar -C rva
mv rva packs

cat > packs/default.txt << EOF
default
rva
local *
EOF

mv 75056793-fb5b7c00-54d7-11ea-9247-9a5bcd8567bb.png bolt.png

rm game_files.zip
rm soundtrack.zip
rm rvgl_assets.zip
rm rvgl_linux.zip
rm rvgl_dcpack.zip
rm RVA.tar

sudo chown root:root "$INSTALL_PATH"/rvgl
sudo chown root:root "$INSTALL_PATH"/rvgl.32
sudo chown root:root "$INSTALL_PATH"/rvgl.64

sudo chmod a+s "$INSTALL_PATH"/rvgl
sudo chmod a+s "$INSTALL_PATH"/rvgl.32
# shellcheck disable=SC2086
sudo chmod a+s $INSTALL_PATH/rvgl.64

cd "$DESKTOP_PATH" || exit

cat > Re-Volt.desktop << EOF
[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Icon=$INSTALL_PATH/bolt.png
Exec=$INSTALL_PATH/rvgl -window
Name=Re-Volt
EOF

gio set Re-Volt.desktop metadata::trusted yes
chmod +x Re-Volt.desktop

echo ✔ Re-Volt has been successfully installed.
echo ✔ A shortcut has been added to your Desktop.
echo ✔ Done.
