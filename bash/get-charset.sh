#!/bin/sh

codes=$(fc-query -i 0 --format='%{charset}\n' $1)
echo "$1,${codes}" >> /Users/ste/Downloads/codes.csv