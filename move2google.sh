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
        echo " Assumes most builds are dl from /desktop-release post dogfood-assets"
        echo " but bc the builds dl w/o the 32/64bit nomenclature so harder to distinguish"
        echo " so for now, dl the 32bit builds from GH release page"
        echo " "
        exit 1
}

if [[ $# -eq 0 ]]; then
        help
        exit
fi

# assume builds are downloaded to the users HOME folder
#i need to put in a check to see if the builds exist
# but really, I need to reuse the code from "/desktop-release" to dl the builds
downloads=$HOME"/Downloads"

build=$1

# I had issues with properly escaping the spaces when put into a variable.
# So cd to it for now just to get something working
cd $HOME/'Google Drive/Shared drives/Engineering/Client Engineering/Desktop Client Release/Verification/Builds'

echo " "
echo transferring *$build* files from $downloads to `pwd`
echo " "

# move Squirrel and appx builds and rename to include build number
# 64bit builds
mv $downloads/Slack.appx ./Slack-x64-prod-$build.appx
mv $downloads/SlackSetup.exe ./SlackSetup-x64-prod-$build.exe
mv $downloads/SlackSetup.msi ./SlackSetup-x64-prod-$build.msi
mv $downloads/slack-standalone-$build.0.msi ./slack-standalone-$build.0-x64-prod.msi

#32bit builds
mv $downloads/Slack-ia32-prod.zip ./Slack-ia32-prod-$build.appx
mv $downloads/SlackSetup-ia32-prod.exe ./SlackSetup-ia32-prod-$build.exe
mv $downloads/slack-standalone-$build.0-ia32-prod.exe ./slack-standalone-$build.0-ia32-prod.msi


# move macOS, Linux, MSI Builds
mv $downloads/*$build* .


echo "done!"
