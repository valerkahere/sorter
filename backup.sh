# 15-07-2025
# take path first
# save every file in that folder through loop
# and move it to a separate directory

# ==> just cp every file there.

#!/usr/bin/env bash

printf "\nEnter the path of the dir you want to copy:\n"
read argument
if cd "$(find . -type d -name "$argument")"; then 
    printf "Current directory: "$PWD""
    printf "\nNavigated successfully.\n"
else 
    printf "\nNo dir with such name.\n" >&2;
fi
