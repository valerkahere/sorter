
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
    printf "\nCreated test files with .mp4; .txt; .jpeg; .jpg; .pdf extensions created in ./test folder\n"
else
    printf "\nError: could not create test folder and files\n" >2
fi

printf "\nCreated test files in test folder as follows:\n\n"
ls


printf "\nThis is the present working directory while executing the script:\n\n"
pwd


printf "\nSorting the files based on their extension:\n"

sorting() {

    # creating actual folders:
    # docs, files, videos, photos
    
    mkdir 'videos' 'photos' 'docs'
    printf "Videos:\n"
    
    # Sorts .mp4, .MOV into ./test/videos dir
    yes | mv *.mp4 *.MOV --target-directory=./videos --update --strip-trailing-slashes --interactive --verbose
    printf "\n"


    printf "Photos:\n"

    # Sorts .jpg, .jpeg into ./test/photos dir
    yes | mv *.jpg *.jpeg --target-directory=./photos --update --strip-trailing-slashes --interactive --verbose 
    printf "\n"

    printf "Docs:\n"
    
    # Sorts .txt, .docs, .pdf into ./test/docs dir
    yes | mv *.txt *.docs *.pdf --target-directory=./docs --update --strip-trailing-slashes --interactive --verbose 
    printf "\n"
}

if sorting
then
    printf "\nSorted test files in and moved them to videos, photos and docs folders accordingly.\n"
else
    printf "\nError: could not move test files.\n" >2
fi
