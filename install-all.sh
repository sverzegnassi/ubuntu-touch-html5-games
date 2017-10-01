#!/bin/bash

PKG=(`find . -name '*.click' -type f -printf '%P\n'`)

echo "Packages to install on phone: ${PKG[*]}"

for i in "${PKG[@]}"
do :
    adb push $i /tmp
    adb shell pkcon install-local --allow-untrusted /tmp/$i
done
