#!/usr/bin/bash


echo "The existing tables are: "

ls -F | nl

while true
do

echo "Please type the name of the table that you want to insert into: "

read table_select

if (find $table_select `ls -F | grep *` &> /dev/null 2>&1) then
	echo "Enter the row number you want to view: "
        read num
	((row_num = num + 2))

        # Display the specified row
        sed -n "${row_num}p" "$table_select"
	break
else
	echo "The name of the table $table_select is not found. Please enter a valid name."
	continue
fi

done
cd ../scripts &> /dev/null 2>&1

