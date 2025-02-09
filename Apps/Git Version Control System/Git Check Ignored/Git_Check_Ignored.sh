#!/bin/bash

for file in `find . -type f -not -path "./.git/*"`
do

git check-ignore -q --no-index $file

if [ $? -eq 1 ]
then
    echo -e "\033[32;1m$file\033[0m"
else
    echo -e "\033[30;1m$file\033[0m"
fi

done
