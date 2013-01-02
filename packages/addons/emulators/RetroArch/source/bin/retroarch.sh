#!/bin/sh
ADDON_DIR="$HOME/.xbmc/addons/emulators.RetroArch"
ADDON_HOME="$HOME/.xbmc/userdata/addon_data/emulators.RetroArch"

mkdir -p "$ADDON_HOME"
mkdir -p "$ADDON_HOME/save/"
export LD_LIBRARY_PATH=$ADDON_DIR/bin/

if [ ! -f "$ADDON_HOME/retroarch.cfg" ]
then
        cp -P $ADDON_DIR/config/* $ADDON_HOME/ -r
fi

chmod a+rx "$ADDON_DIR/bin/retroarch" 
"$ADDON_DIR/bin/retroarch" -c "$ADDON_HOME/retroarch.cfg" -f -L $ADDON_DIR/bin/libretro.so "$@" &
        

sleep 2
killall -STOP xbmc.bin

while [ $(pidof retroarch) ];do
    usleep 200000
done;
killall -CONT xbmc.bin
