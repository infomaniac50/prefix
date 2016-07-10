#!/bin/bash

# %f - The path of the first selected file
# %d - directory containing the file that is passed in %f
# %n - the first selected filename (without path)

# Script args
# thunar-dropbox-puburl %d %n
directory="$1"
filename="$2"
cd "$directory"

puburl=$(dropbox puburl $filename)

echo $directory
echo $filename
echo $puburl
echo -n $puburl | xsel --clipboard
zenity --notification --window-icon="info" --text="The public link has been copied to your clipboard."
