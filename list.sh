#!/usr/bin/bash

echo "Existing database(s) are: "

cd ../databases

ls -F | grep / | tr / " " | nl

cd ../scripts 
