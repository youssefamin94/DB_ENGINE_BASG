#!/usr/bin/bash

cd ../databases

while true
do

echo "Please type the name of the database that you want to drop: "

ls -F | grep / | tr / " " | nl

read db_drop

if (find $db_drop `ls -F | grep /` &> /dev/null 2>&1) then
	rm -r $db_drop
	echo "Database $db_drop is dropped. Operation successful."
	break
else
	echo "The name of the database $db_drop is not found. Please enter a valid name."
	continue
fi

cd ../scripts

done
