#!/bin/sh

#load config
. ~/.openelec-addons

EXCLUDE_FILE=files.exclude

echo "Using openelec directory $OPENELEC"

echo "Copying binary addons to repo dir"

OLDDIR=`pwd`

cd $OPENELEC/target/addons/
ZIPS=`find . |grep .zip`	

cd $OLDDIR
[ -e $EXCLUDE_FILE ] && rm $EXCLUDE_FILE
for zip in $ZIPS
do
	zipcmp -q $OPENELEC/target/addons/$zip repo/$zip
	if [ $? -eq 0 ]
	then
		echo $zip | sed 's/^\.\/\(.*\)/\1/' >> $EXCLUDE_FILE
	fi
done

rsync --ignore-times -c  --progress -r --exclude-from $EXCLUDE_FILE $OPENELEC/target/addons/ repo/
