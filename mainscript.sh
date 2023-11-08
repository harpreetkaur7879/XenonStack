#!/bin/bash
# custom linux command

function internsctl() {
version="v0.1.0"
if [ $1 = "--version" ]; then
	echo "version of my command  $version "
elif [ $1 = "--help" ]; then
	cat commandHelp.txt
elif [[ ( $1 = "cpu" ) && ( $2 = "getinfo" ) ]]; then
	lscpu
elif [[ ( $1 = "memory" ) && ( $2 = "getinfo" ) ]]; then
	free
elif [[ ( $1 = "user" ) && ( $2 = "create" ) ]]; then
	sudo adduser $3
elif [[ ( $1 = "user" ) && ( $2 = "list" ) ]]; then
	{
		if [[ ( $1 = "user" ) && ( $2 = "list" ) && ( $3 = "--sudo-only" ) ]]; then
	 		grep '^sudo:.*$' /etc/group | cut -d: -f4
		else
			cat /etc/passwd | cut -d: -f1
		fi
	}
elif [[ ( $1 = "file" ) && ( $2 = "getinfo" ) ]]; then
	{
		if (( $# < 3 )); then
			echo "Invalid command"
			return
		fi
		if [ ! -f ${@: -1} ]; then
			echo "This file doesn't exist"
			return
		fi
				case $3 in 
					"--size" | "-s")
					  ls -l $4 | cut -d' ' -f5
					  ;;
					"--permissions" | "-p")
					  ls -l $4 | cut -d' ' -f1
					  ;;
					"--owner" | "-o")
					  ls -l $4 | cut -d' ' -f3
					  ;;
					"--last-modified" | "-m")
					  stat -c %y $4
					  ;;
					*)
					owner=`ls -l $3 | cut -d' ' -f3`
					size=`ls -l $3 | cut -d' ' -f5`
					permission=`ls -l $3 | cut -d' ' -f1`
					lastModified=`stat -c %y $3`
			                 echo "File: " $3
				       	 echo "Access: $permission"
					 echo "Size(B): $size"
	 				 echo "Owner: $owner"
					 echo "Modify: $lastModified"
				         ;;
				esac
	}

else
	echo "please enter valid arguements"
fi

}

