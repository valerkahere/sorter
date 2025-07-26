
#!/user/bin/env bash

# printf "\n\n"

printf "\nWelcome\n"

printf "\nEnter the path of the folder to move:\n"
read pathtodir
cd "$pathtodir"

printf "\nThis is the present working directory while executing the script:\n\n"
pwd
# Creating a function for error handling
testing() { 
    mkdir 'MOVED' 2>/dev/null
    

    
}

if testing
then
    printf "\nCreated test files with .mp4; .txt; .jpeg; .jpg; .pdf extensions created in ./test folder\n"
    ls
else
    printf "\nError: could not create test folder and files\n" >2
fi


printf "\nSorting the files based on their extension:\n"

sorting() {

    # creating actual folders:
    # docs, files, videos, photos
    
    mkdir './MOVED/videos' './MOVED/photos' './MOVED/docs'
    printf "Videos:\n"
    
    # Sorts .mp4, .MOV into ./test/videos dir
    mv *.mp4 *.MOV --target-directory=./MOVED/videos --update --strip-trailing-slashes --interactive --verbose
    printf "\n"


    printf "Photos:\n"

    # Sorts .jpg, .jpeg into ./test/photos dir
    mv *.jpg *.jpeg *.png --target-directory=./MOVED/photos --update --strip-trailing-slashes --interactive --verbose 
    printf "\n"

    printf "Docs:\n"
    
    # Sorts .txt, .docs, .pdf into ./test/docs dir
    mv *.txt *.docs *.pdf --target-directory=./MOVED/docs --update --strip-trailing-slashes --interactive --verbose 
    printf "\n"
}

if sorting
then
    printf "\nSorted test files in and moved them to videos, photos and docs folders accordingly.\n"
else
    printf "\nError: could not move test files.\n" >2
fi
