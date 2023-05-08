#!/bin/bash

# move test builds to the Google Shared drive 
# renames windows builds to include the build version

# When help is needed it will always be given at Slack
function help
{
        echo " "
        echo $0 " Moves builds from ~/Downloads to the Google Shared drive and renames the Windows builds"
        echo "     - Needs one argument - build version, e.g., 4.32.122"
        echo " "
        exit 1
}

if [[ $# -eq 0 ]]; then
        help
        exit
fi

# assume builds are downloaded to the users HOME folder
downloads=$HOME"/Downloads"

build=$1

# I had issues with properly escaping the spaces when put into a variable. 
# So cd to it for now just to get something working 
cd $HOME/'Google Drive/Shared drives/Engineering/Client Engineering/Desktop Client Release/Verification/Builds'

echo " "
echo transferring *$build* files from $downloads to `pwd` 
echo " "

# move macOS, Linux, MSI Builds 
mv $downloads/*$build* . 

# move Squirrel and appx builds and rename to include build number
mv $downloads/Slack-ia32-prod.appx ./Slack-ia32-prod-$build.appx
mv $downloads/Slack-x64-prod.appx ./Slack-x64-prod-$build.appx
mv $downloads/SlackSetup-ia32-prod.exe ./SlackSetup-ia32-prod-$build.exe
mv $downloads/SlackSetup-x64-prod.exe ./SlackSetup-x64-prod-$build.exe
mv $downloads/SlackSetup-x64-prod.msi ./SlackSetup-x64-prod-$build.msi

echo "done!"
