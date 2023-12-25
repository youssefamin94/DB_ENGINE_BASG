#!/usr/bin/bash

cd ../

if (find databases `ls -F | grep *` &> /dev/null 2>&1) then
true
else
mkdir databases
fi
cd ./scripts

select choice in CREATE_DATABASE LIST_DATABASE CONNECT_DATABASE DROP_DATABASE
do
case $choice in

CREATE_DATABASE ) 
	echo " Creating Databse "
	./create.sh
;;
LIST_DATABASE ) 
	echo " Listing Databse "
	./list.sh
;;
CONNECT_DATABASE ) 
	echo " Connecting to Databse "
	./connect.sh
;; 
DROP_DATABASE ) 
	echo " Dropping Databse "
	./drop.sh
;;
	esac

done
