#!/usr/bin/bash

cd ../databases

while true
do 
	echo "Please enter your database name."
	read db_name

	    # Check if the database name already exists.
	    if (find $db_name `ls -F | grep /` &> /dev/null 2>&1) then
		echo "Error: Database name already exists, please proceed with a different name."
		continue 
	    fi

	    # Check if the name is not empty
	    if [ -z "$db_name" ]; then
		echo "Error: Database name cannot be empty."
		continue
	    fi
		
	    # Check if the name starts with a letter
	    if ! [[ $db_name =~ ^[a-zA-Z] ]]; then
		echo "Error: Database name must start with a letter."
		continue
	    fi

	    # Check if the name contains only letters, numbers, and underscores
	    if ! [[ $db_name =~ ^[a-zA-Z0-9_]+$ ]]; then
		echo "Error: Database name can only contain letters, numbers, and underscores."
		continue
	    fi

	    # Check if the name doesn't exceed 64 characters (MySQL limit)
	    if [ ${#db_name} -gt 64 ]; then
		echo "Error: Database name exceeds the maximum length of 64 characters."
		continue
	    fi

	    mkdir $db_name
	    break

done


cd ../scripts &> /dev/null 2>&1


