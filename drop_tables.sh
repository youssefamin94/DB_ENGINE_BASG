#!/usr/bin/bash

echo "The existing tables are: "

ls -F | nl

while true
do

echo "Please type the name of the table that you want to drop: "

read table_drop

if (find $table_drop `ls -F | grep *` &> /dev/null 2>&1) then
	rm -r $table_drop
	echo "Table $table_drop is dropped. Operation successful."
	break
else
	echo "The name of the table $table_drop is not found. Please enter a valid name."
	continue
fi

done

../scripts &> /dev/null 2>&1

