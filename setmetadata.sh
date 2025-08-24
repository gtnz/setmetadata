#!/bin/sh

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
find -maxdepth 3 -mindepth 3 -type f | while read DOT ARTIST ALBUM TRACK; do
IFS=OLD_IFS
TARGET_TRACK="$ARTIST/$ALBUM/$TRACK"
echo $DOT
echo $TARGET_TRACK
RUN="ffmpeg -i $TARGET_TRACK -metadata title="$TRACK" -metadata artist="$ARTIST" -metadata author="$ARTIST" -metadata album="$ALBUM" -c copy tmp$TRACK"
echo $RUN
ffmpeg -i "$TARGET_TRACK" -metadata title="$TRACK" -metadata artist="$ARTIST" -metadata author="$ARTIST" -metadata album="$ALBUM" -c copy "tmp$TRACK"
mv "tmp$TRACK" "$TARGET_TRACK"
IFS=/
done
IFS=OLD_IFS
