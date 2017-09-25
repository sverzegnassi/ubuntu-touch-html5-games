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
	APP_ID=$(click info $i | jq --raw-output '.name')
	TEST_PACKAGE_EXISTS=$(./openstore-uploader-tool/open-uapp info-auth $APP_ID)
	if [[ "$TEST_PACKAGE_EXISTS" =~ "Cannot find app with a id:" ]]
	then
		echo "Pushing $i as new package"
		./openstore-uploader-tool/open-uapp new $i
	else
		echo "Pushing $i as an update"
		./openstore-uploader-tool/open-uapp update $i --force
	fi
done
