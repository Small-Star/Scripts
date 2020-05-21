#!/bin/bash
#Console Slideshow
#Requires xdg-open and xdotool
#
#Arguments:
#$1: Directory to choose random files from
#$2: Time (in seconds) to display each file
#$3: Number of files to display
#
#Example: console_slideshow /home/user/art/ 20 100

if [ "$1" = "" ]; then
    echo "Error: No directory argument"
    exit 1
  else
    DIR=$1
fi

if [ "$2" = "" ]; then
    echo "Error: sleep length argument"
    exit 1
fi

if [ "$3" = "" ]; then
    echo "Error: picture number argument"
    exit 1
fi

#Pull a list of $3 random files from $DIR
FILES=$(find $DIR -type f| shuf -n $3)

for i in $FILES
do
  #Remove the path, leaving the basename
  SHORT_FILE=$(basename "$i")

  #Open the file using the default application
  xdg-open $i

  #Send an F11 (fullscreen) keypress
  sleep .5s
  xdotool key "F11"

  #Wait for $2 seconds
  sleep "$2s"

  #Find the window with the same title as the filename and kill it
  #*NOTE* this depends on your file viewer spawning windows with the filename as the title! Works with XViewer.
  wmctrl -ic "$(wmctrl -l | grep "$SHORT_FILE")"
  sleep .5s
done
