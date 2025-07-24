# 15-07-2025
# take path first
# save every file in that folder through loop
# and move it to a separate directory

# ==> just cp every file there.

#!/usr/bin/env bash

# Testing

mkdir TEST 2>/dev/null
cd ./TEST 
# how many text files to create
fileNum=1
files=5
creating_files() {
    for i in {1..5} # no semicolon needed for multiline
    do # variable expansion does not work in range
        touch "file$fileNum.txt"
        (( ++fileNum ))
    done
}

if creating_files
then # keywords always on different lines
    printf "\nTest files created in ./TEST folder\n"
else
    printf "\nError: could not create files in ./TEST folder\n" >2
fi

printf "\nEnter the path of the dir you want to copy without slash in the end:\n"
read source
if cd "$(find . -type d -path "$source")"
then # -D all for debugopts 
    printf "Current directory: "$PWD""
    currentdir=$PWD
    printf "\nNavigated successfully.\n"
    # the cd searcher for any dir that's why navigates anyway
else 
    printf "\nError: %s\n" "could not navigate" >/dev/stderr # changed from >&2 for readability
    # No need: 2>&1 - Make FD 2 target FD 1's target
    # Actually need: 1>&2
fi

cd ../..; mkdir BACKUP; cp --debug -v -ri "$currentdir" "./BACKUP" 
printf "\nCopied successfully to BACKUP folder in present working directory."

printf "\nError: %s\n" "could not copy\n" >/dev/seterr


# mkdir ~/Desktop/Projects/backup; cp "$PWD" --debug -v -ri --target-directory=/home/valerka/Desktop/Projects/backup

# cp --debug -v -ri --target-directory=DIRECTORY 
# debug: explain how files is copied
# i: prompt before overwrite
# r: copy directories recursively
# v: explain what is being done
# Tested: function works