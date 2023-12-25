#!/usr/bin/bash

cd ../databases

while true
do

echo "Please type the name of the database that you want to connect to: "

ls -F | grep / | tr / " " | nl

read db_connect

if (find $db_connect `ls -F | grep /` &> /dev/null 2>&1) then
	cd ./$db_connect
	echo "You're now connected to $db_connect!"
	break
else
	echo "The name of the database $db_connect is not found. Please enter a valid name."
	continue
fi

done

select choice in CREATE_TABLE LIST_TABLE INSERT_INTO_TABLE DROP_TABLE SELECT_FROM_TABLE DELETE_FROM_TABLE
do
case $choice in

CREATE_TABLE ) 
	echo " You chose $choice"
	source ../../scripts/create_table.sh
;;

LIST_TABLE ) 
	echo " You chose $choice"
	source ../../scripts/list_tables.sh
;;

DROP_TABLE ) 
	echo " You chose $choice"
	source ../../scripts/drop_tables.sh
;;

INSERT_INTO_TABLE ) 
	echo " You chose $choice"
	source ../../scripts/insert_into_table.sh
;;

SELECT_FROM_TABLE ) 
	echo " You chose $choice"
	source ../../scripts/select_from_table.sh
;;

* ) 
	echo " Please enter a valid option. "
;;
	esac

done

