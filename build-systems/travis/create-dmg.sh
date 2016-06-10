#!/bin/bash

#
# creating the LogAnalyzer.dmg with Applications link
#

#QTDIR="/Applications/Qt/5.5/clang_64"
QTDIR="/usr/local/opt/qt5"
APP=LogAnalyzer
# this directory name will also be shown in the title when the DMG is mounted
TEMPDIR=$APP
SIGNATURE="Patrizio Bekerle"
NAME=`uname`

if [ "$NAME" != "Darwin" ]; then
    echo "This is not a Mac"
    exit 1
fi

echo "Changing bundle identifier"
sed -i -e 's/com.yourcompany.LogAnalyzer/com.PBE.LogAnalyzer/g' $APP.app/Contents/Info.plist
# removing backup plist
rm -f $APP.app/Contents/Info.plist-e

# copy translation files to app
#cp languages/*.qm $APP.app/Contents/Resources

# use macdeployqt to deploy the application
echo "Calling macdeployqt"
$QTDIR/bin/macdeployqt ./$APP.app
if [ "$?" -ne "0" ]; then
    echo "Failed to run macdeployqt"
    exit 1
fi

echo "Create $TEMPDIR"
#Create a temporary directory if one doesn't exist
mkdir -p $TEMPDIR
if [ "$?" -ne "0" ]; then
    echo "Failed to create temporary folder"
    exit 1
fi

echo "Clean $TEMPDIR"
#Delete the contents of any previous builds
rm -Rf ./$TEMPDIR/*
if [ "$?" -ne "0" ]; then
    echo "Failed to clean temporary folder"
    exit 1
fi

echo "Move application bundle"
#Move the application to the temporary directory
mv ./$APP.app ./$TEMPDIR
if [ "$?" -ne "0" ]; then
    echo "Failed to move application bundle"
    exit 1
fi

echo "Create symbolic link"
#Create a symbolic link to the applications folder
ln -s /Applications ./$TEMPDIR/Applications
if [ "$?" -ne "0" ]; then
    echo "Failed to create link to /Applications"
    exit 1
fi

echo "Create new disk image"
#Create the disk image
rm -f ./$APP.dmg
hdiutil create -srcfolder ./$TEMPDIR -format UDBZ ./$APP.dmg
if [ "$?" -ne "0" ]; then
    echo "Failed to create disk image"
    exit 1
fi

echo "moving $APP.dmg to $APP-$VERSION_NUMBER.dmg"
mv $APP.dmg $APP-$VERSION_NUMBER.dmg

# delete the temporary directory
rm -Rf ./$TEMPDIR/*
if [ "$?" -ne "0" ]; then
    echo "Failed to clean temporary folder"
    exit 1
fi

exit 0
