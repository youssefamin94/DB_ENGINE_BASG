#!/usr/bin/bash


echo "The existing tables are: "

ls -F | nl

while true
do

echo "Please type the name of the table that you want to insert into: "

read table_insert

if (find $table_insert `ls -F | grep *` &> /dev/null 2>&1) then
	echo "Adding data to table: $table_insert"
	break
else
	echo "The name of the table $table_insert is not found. Please enter a valid name."
	continue
fi

done

# Get column structure - first two rows for column names and data types


no_of_fields=$(sed -n "1p" $table_insert | awk -F: '{print NF}')
row=""

for ((i=1; i<no_of_fields; i++)); do
	col_name=$(sed -n "1p" $table_insert | awk -F: -v i="$i" '{print $i}')
	col_type=$(sed -n "2p" $table_insert | awk -F: -v i="$i" '{print $i}')

    valid_entry=false
    while [ "$valid_entry" = false ]; do
        echo "Enter $col_name $col_type: "
        read entry

        # Validate data type
        if [[ $col_type == "Integer" ]]; then
            if ! [[ "$entry" =~ ^[0-9]+$ ]]; then
                echo "Invalid entry. Expected integer value."
            else
                valid_entry=true
            fi
        elif [[ $col_type == "String" ]]; then
            valid_entry=true  # Accept any string value
        else
            echo "Unknown column type: ${column_types[$i]}"
            break
        fi
    done

    row+="$entry:"
done

echo "$row" >> "$table_insert"
echo "Data inserted successfully into $table_to_insert."

../scripts &> /dev/null 2>&1
