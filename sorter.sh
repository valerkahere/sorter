
#!/user/bin/env bash

# printf "\n\n"

printf "\nWelcome\n"

# Creating a function for error handling
testing() { 
    mkdir 'test' 2>/dev/null
    cd './test'

    for (( i=0; i<=5; i++ ))
    do
        touch "file$i.mp4" "sample$i.txt" "bruh$i.jpeg" "$i.jpg" "reading$i.pdf"
    done
}

if testing
then
    printf "\nCreated test files with .mp4 extension created in ./test folder\n"
else
    printf "\nError: could not create test folder and files\n" >2
fi

printf "\nCreated test files in test folder as follows:\n\n"
ls


printf "\nThis is the present working directory while executing the script:\n\n"
pwd

# creating actual folders:
# docs files, videos, photos
mkdir 'videos' 'docs' 'photos' 2>/dev/null

printf "\nTrying to match files first and figure out what extensions are there:"
# Make FD2 write to where FD1 is writing
output=$(find . -path "**/*.jpg" -print0 -quit 1>/dev/null 2>&1) 


if [ "${my_variable:-'default value'}" = 'default value' ]; then
    printf "\n .jpg files are not there\n"
else
    printf "\n$output"
    printf "\n => .jpg is there\n"
fi

# :- operator checks if the value is null, and if it is, sets the "default value"

printf "\nSorting the files based on their extension:\n"

printf "Videos:\n"
# Sorts .mp4, .MOV into ./test/videos dir
mv *.mp4 *.MOV --target-directory=./videos --update --strip-trailing-slashes --interactive --verbose
printf "\n"


printf "Photos:\n"
# Sorts .jpg, .jpeg into ./test/photos dir
mv *.jpg *.jpeg --target-directory=./photos --update --strip-trailing-slashes --interactive --verbose 
printf "\n"

printf "Docs:\n"
# Sorts .txt, .docs, .pdf into ./test/docs dir
mv *.txt *.docs *.pdf --target-directory=./docs --update --strip-trailing-slashes --interactive --verbose 
printf "\n"

