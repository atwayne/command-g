#!/bin/bash

# Installation
# set in .bashrc alias g='. path/to/g.sh'

alias=$1

# color output
RED='\033[0;31m'
NC='\033[0m' # No Color

# path to .grc file
mapping="$USERPROFILE/.grc"

if [ "$alias" == "" ]; then
	echo -e "${RED}Alias not provided.${NC}"
    return
fi

if [ ! -f $mapping ]; then
    echo -e "${RED}No mapping file found. Create $mapping to start.${NC}"
    return
fi

# sed statements
# modify the path to match linux environment variables (%USERPROFILE% to $USERPROFILE)
# trim the text (whitespaces and line breaks)
# modify the path to match linux path  (%USERPROFILE%\.grc to $USERPROFILE/.grc)
match=$(cat $mapping |grep -E "^$alias\s"|awk '{$1=""; print $0}'|sed -r 's/\%(\w+)\%/\$\1/g; s/\s+(.+)\s+/\1/g; s/\\/\//g;')
if [ "$match" == "" ]; then
	echo -e "${RED}No mapping found in $mapping ${NC}"
    return
fi

target=$(eval echo "$match")
pushd "${PWD}" > /dev/null
cd $target