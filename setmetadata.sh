#!/bin/bash

LIB_PVD=$1
if [ -z "$LIB_PVD" ]; then
	echo "use ./setmetadata.sh <libdir>"
	echo "for exumple:"
	echo "./setmetadata.sh music"
	exit 1
fi
cd $LIB_PVD
OLD_IFS=IFS
IFS=/
find -maxdepth 3 -mindepth 3 -type f -iname '*.mp3' | while read -r DOT ARTIST ALBUM TRACK; do
	IFS=$OLD_IFS
	TARGET_TRACK="$ARTIST/$ALBUM/$TRACK"
	echo -E author="$ARTIST" artist="$ARTIST" album="$ALBUM" title="$TRACK"
	echo -E "$TARGET_TRACK"
	ffmpeg -i "$TARGET_TRACK" -nostdin -metadata title="$TRACK" -metadata artist="$ARTIST" -metadata author="$ARTIST" -metadata album="$ALBUM" -c copy "tmp$TRACK" 2>/dev/null
	mv "tmp$TRACK" "$TARGET_TRACK"
	IFS=/
done
