#!/bin/bash

mapfile -t folder_array < ./build-settings

echo "Folders to build: ${folder_array[*]}"

for i in "${folder_array[@]}"
do
   :
   ./build.sh $i
done
