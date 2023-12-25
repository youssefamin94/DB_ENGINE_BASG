#!/usr/bin/bash

# Lisitng tables

ls -F | nl

# Creation of a table

while true
do 
    echo "Please type the name of the table to be created in the database."
    read table_name

    # Check if the table name is not empty
    if [ -z "$table_name" ]; then
        echo "Error: Table name cannot be empty."
        continue 
    fi

    # Check if the name contains only letters, numbers, and underscores
    if ! [[ $table_name =~ ^[a-zA-Z0-9_]+$ ]]; then
	echo "Error: Table name can only contain letters, numbers, and underscores. It cannot contain special characters or spaces."
	continue
    fi

    if [[ $table_name == *' '* ]]; then
	echo "Error: Table name can not have any spaces."
	continue
    fi


    # Check if the name doesn't exceed 64 characters (MySQL limit)
    if [ ${#table_name} -gt 64 ]; then
        echo "Error: Table name exceeds the maximum length of 64 characters."
        continue
    fi

    # Check if the name starts with a letter
    if ! [[ $table_name =~ ^[a-zA-Z] ]]; then
        echo "Error: Table name must start with a letter."
        continue
    fi

    # Check if the name already exists
    if find "$table_name" -type f &> /dev/null; then
        echo "Error: Table name already exists, please proceed with a different name."
        continue
    fi
	
    touch $table_name
    break
done

######################################################################################################


#Letting user create the table#

while true 
do
echo "Please enter number of columns."
read no_of_columns
if [[ $no_of_columns -le 0 ]]; then
        echo "Error: Cannot assign number of column(s) zero or a negative number"
        continue
else
	echo "Number of column(s) for the $table_name are $no_of_columns ."
	break
fi

done

for((i=1;i<=$no_of_columns;i++))

do

while true
do 
	echo "Please enter your column name for column number $i."
	read col_name

	    # Check if the name is not empty
	    if [ -z "$col_name" ]; then
		echo "Error: Column name cannot be empty."
		continue
	    fi
		
	    # Check if the name starts with a letter
	    if ! [[ $col_name =~ ^[a-zA-Z] ]]; then
		echo "Error: Column name must start with a letter."
		continue
	    fi

	    # Check if the name contains only letters, numbers, and underscores
	    if ! [[ $col_name =~ ^[a-zA-Z0-9_]+$ ]]; then
		echo "Error: Column name can only contain letters, numbers, and underscores."
		continue
	    fi

	    # Check if the name doesn't exceed 64 characters (MySQL limit)
	    if [ ${#col_name} -gt 64 ]; then
		echo "Error: Column name exceeds the maximum length of 64 characters."
		continue
	    fi

	    # Check if the database name already exists.
	    if (find $col_name `head -1 $table_name` &> /dev/null 2>&1) then
		echo "Error: Column name already exists, please proceed with a different name."
	    else 
		if [ $i -eq 1 ]; then
		    row+=$col_name"(PK):"
		else
    		    row+=$col_name":"
		fi

	    fi
	    
	    

		echo "Please enter your column datatype for $col_name (has to be either Integer or String)."
		echo "Please note that the first column is the PK and it has to be an Integer."

		read col_datatype


		if [ $i -eq 1 ];
				then
				if [ $col_datatype != "Integer" ]; then
				echo "First column is the PK and it has to be an Integer."
				continue
			else
				row_type+="Integer:"
				break
			fi
				
				fi

		
			if [ $col_datatype == "Integer" ]; then
				row_type+="Integer:"
				break
			fi
			if [ $col_datatype == "String" ]; then
				row_type+="String:"
				break
			fi
			if [ $col_datatype != "Integer" -o "String" ]; then
				echo "Invalid choice, please choose either Integer or String."
				continue
			fi 			
		

done
done

echo $row >> $table_name
echo $row_type >> $table_name

echo "Table MetaData:
$row
$row_type"

cd ../scripts &> /dev/null 2>&1
