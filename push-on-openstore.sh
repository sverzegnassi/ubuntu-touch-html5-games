#!/bin/bash

echo "Downloading OpenStore uploader"

git clone https://github.com/sverzegnassi/openstore-uploader-tool.git

CLICK_TO_UPLOAD=()

while IFS= read -d $'\0' -r file ; do
	CLICK_TO_UPLOAD=("${CLICK_TO_UPLOAD[@]}" "$file")
done < <(find . -name '*.click' -print0)

echo "Click packages to upload: ${CLICK_TO_UPLOAD[*]}"

for i in "${CLICK_TO_UPLOAD[@]}"
do :
	echo "Pushing $i"
	./openstore-uploader-tool/openstore-cli upload $i
done
