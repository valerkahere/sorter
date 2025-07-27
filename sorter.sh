
#!/usr/bin/env bash

# printf "\n\n"

printf "\nWelcome\n"

printf "\nEnter the path of the folder to sort AS IT IS (white spaces are handled automatically):\n"

read pathtodir

if cd "$pathtodir"
then
    printf "Path accepted."
else
    printf "Wrong path. Stopping...\n" 1>&2
    exit 1
fi

# Creating a function for error handling
creating() { 
    mkdir '../MOVED' 2>/dev/null
}

if creating
then
    printf "\nCreated "MOVED" dir one level higher than the SOURCE, where SOURCE will be moved to\n"

    ls
else
    printf "\nError: could not create "MOVED" dir\n" 1>&2
    exit 1
fi

# all contents (files) from dirs in the SOURCE dir will be first recursively moved to "MOVED" dir

if find . -type f -exec mv {} ../MOVED \;
then
    printf "\nAll regular files are moved to '../MOVED'\n"
else
    printf "\nError: Could not move files" 1>&2
    exit 1
fi


sorting() {
    printf "\nSorting the files based on their extension:\n"

    cd '../MOVED'
    pwd
    # creating actual folders:
    # docs, files, videos, photos
    
    # PATH: /home/user/Desktop/TEST/MOVED

    mkdir 'videos' 'photos' 'docs' 'audios' 'other'
    
    printf "Videos:\n"
    
    mv *.mp4 *.MOV *.mov --target-directory=./videos --update --interactive --verbose
    printf "\n"


    printf "Photos:\n"

    mv --target-directory=./photos --update --interactive --verbose -- *.jpg *.jpeg *.png *.webp
    printf "\n"

    printf "Docs:\n"
    
    mv --target-directory=./docs --update --interactive --verbose -- *.txt *.docx *.doc *.zip *.fb2 *.pdf *.xlsx *.pptx *.ics *.md *.epub
    printf "\n"

    printf "Audios:\n"
    
    mv --target-directory=./audios --update --interactive --verbose -- *.mp3 *.m4a  
    printf "\n"


    printf "Other (no extension):\n"
    find . -maxdepth 1 -type f -exec mv --target-directory=./other --update --interactive --verbose {} \+
}

if sorting
then
    printf "\nSorted test files in and moved them to videos, photos and docs folders accordingly.\n"
else
    printf "\nError: could not move test files.\n" 1>&2
    exit 1
fi

printf "\nThis is the present working directory while executing the script:\n"
pwd
