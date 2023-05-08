#!/bin/bash
# Clean Slack from the system

# When help is needed it will always be given at Slack
function help
{
	echo " "
	echo $0 " Terminates and Removes the Slack app, the AppData, and Slack Safe Storage" 
	echo "     - Needs one argument - ddl, mas, both" 
	echo " "
	echo " ddl - Removes the DDL, DDL AppData and Slack Safe Storage 'Slack Key' "
	echo " mas - Removes the MAS, MAS AppData and Slack Safe Storage 'Slack App Store Key' "
	echo " both - Remove both the DDL and the MAS, both AppData directories, and both Safe Storage keys"
	echo " "
	echo " Note: An account w/ sudo privs is required for removing the MAS package.  The script will ask you to enter your password."
	exit 1
}

#remove macOS DDL
function rmddl
{
	echo "Removing Slack DDL and AppData..."
	rm -rf /Applications/Slack*.app
	rm -rf "$HOME/Library/Application Support/Slack" 

	echo "Delete Slack Key"
	security delete-generic-password -a "Slack Key" 2>&1 >/dev/null
}

#remove MAS
function rmmas
{
	echo "Removing Slack MAS and AppData..."
	sudo rm -rf /Applications/Slack*.app
	rm -rf "$HOME/Library/Containers/com.tinyspeck.slackmacgap/Data/Library/Application Support"

	echo "Delete Slack App Store Key"
	security delete-generic-password -a "Slack App Store Key" 2>&1 >/dev/null
}

if [[ $# -eq 0 ]]; then
	help
	exit
fi



TODO=$1

osascript -e 'quit app "Slack"'
tccutil reset All com.tinyspeck.slackmacgap

case $TODO in

	ddl)
		rmddl
		;;

	mas)
		rmmas
		;;

	both)
		echo "do both"
		rmddl
		rmmas
		;;

	*)
		echo "unknown option $TODO"
		;;

esac

echo "done!"
