#!/bin/bash
# Execute slack with the correct command line options for each proxy type
# This script assumes the DMG is installed 

# When help is needed it will always be given at Slack
function help
{
        echo " "
        echo $0
        echo " - terminates the app"
        echo " - removes AppData"
        echo " - gets slack --version to use in filenames"
        echo " - executes each type of proxy (kerberos, basic, ntlm) and outputs logs"
        echo " - kerberos does not requires credentials but the others do"
        echo " - the app should launch to the purple sign in screen"
        echo " - you may then quit the app"
        exit 1
}

if [[ $# -ne 0 ]]; then
help
fi

# terminate Slack and remove AppData
osascript -e 'quit app "Slack"'
rm -rf "$HOME/Library/Application Support/Slack"

#echo " "
#echo "kinit should return without error"
#kinit proxytest@PROXYENV.com

#get the installed build version
BUILD=`/Applications/Slack.app/Contents/MacOS/Slack --version`

echo " "
echo "launching slack for proxy testing on "$BUILD

/Applications/Slack.app/Contents/MacOS/Slack --silent --log-net-log="/Users/$USER/Downloads/macOS-$BUILD-3128kerb.json" --proxy-server=rhelproxy.proxyenv.com:3128 >& /dev/null

/Applications/Slack.app/Contents/MacOS/Slack --silent --log-net-log="/Users/$USER/Downloads/macOS-$BUILD-3129basic.json" --proxy-server=rhelproxy.proxyenv.com:3129 >& /dev/null

/Applications/Slack.app/Contents/MacOS/Slack --silent --log-net-log="/Users/$USER/Downloads/macOS-$BUILD-3130ntlm.json" --proxy-server=rhelproxy.proxyenv.com:3130 >& /dev/null

cd $HOME/Downloads
LOGS=`ls -1 macOS-$BUILD*.json | xargs`
echo " "
echo "Please upload $LOGS to compliance Jira for release $BUILD"
echo " "
echo "done!"

