# 15-07-2025
# take path first
# save every file in that folder through loop
# and move it to a separate directory

# ==> just cp every file there.

#!/usr/bin/env bash

# Testing

mkdir TEST
cd ./TEST 2>/dev/null
# how many text files to create
fileNum=1
files=5
creating_files() {
    for i in {1..5}; do # variable expansion does not work in range
        touch "file$fileNum.txt"
        (( ++fileNum ))
    done
}

if creating_files; then 
    printf "\nTest files created in ./TEST folder\n"
else
    printf "\nError: could not create files in ./TEST folder\n" >2
fi

printf "\nEnter the path of the dir you want to copy without slash in the end:\n"
read source
if cd "$(find . -type d -path "$source")"; then 
    printf "Current directory: "$PWD""
    printf "\nNavigated successfully.\n"
else 
    printf "\nNo dir with such name.\n" >&2;
fi

printf "\nEnter the path of the destination dir\n:"
read destination

# cp --debug -v -ri --target-directory=DIRECTORY 
# debug: explain how files is copied
# i: prompt before overwrite
# r: copy directories recursively
# v: explain what is being done
# Tested: function works