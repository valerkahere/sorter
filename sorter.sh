
#!/usr/bin/env bash

# printf "\n\n"

printf "\nWelcome\n"

printf "\nEnter the path of the (SOURCE) folder to sort AS IT IS (white spaces are handled automatically):\n"

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
    mkdir './MOVED' 2>/dev/null
}

if creating
then
    printf "\nCreated "MOVED" folder in the current directory, where all the files from SOURCE will be moved to. \n\n"
    
else
    printf "\nError: could not create "MOVED" dir\n" 1>&2
    exit 1
fi

# all contents (files) from dirs in the SOURCE dir will be first recursively moved to "MOVED" dir

# Here, \! - escaping interpretation by shell as script punctutation, same with single quotes around {}. Same protection for semicolon.
if find . -type f  \! -path "./MOVED/*" -exec mv '{}' ./MOVED \;
then
    printf "\nAll regular files are moved to './MOVED'\n"
else
    printf "\nError: Could not move files" 1>&2
    exit 1
fi


sorting() {

    cd './MOVED'
    printf "\n\nPWD: $PWD"
    printf "\n'MOVED' dir contents: $(ls)\n\n"
    


    printf "\nSorting the files based on their extension:\n"

    # creating actual folders:
    # docs, files, videos, photos
    
    # PATH: /home/user/Desktop/TEST/MOVED

    # Photos

    exiftool '-Directory<DateTimeOriginal' -d '%Y/%m-%B/%d-%m-%Y/photos' -if '$FileTypeExtension =~ /jpe?g|png|webp|gif|bmp|tiff/i' -ext jpg -ext jpeg -ext png -ext webp -ext gif -ext bmp -ext tiff  .

    exiftool '-Directory<FileModifyDate' -d '%Y/%m-%B/%d-%m-%Y/photos' -if '$FileTypeExtension =~ /jpe?g|png|webp|gif|bmp|tiff/i' -ext jpg -ext jpeg -ext png -ext webp -ext gif -ext bmp -ext tiff .

    printf "Sorted Photos.\n\n"

    # Videos

    exiftool '-Directory<DateTimeOriginal' -d '%Y/%m-%B/%d-%m-%Y/videos' -if '$FileTypeExtension =~ /mp4|mov|avi|mkv|wmv/i' -ext mp4 -ext mov -ext avi -ext mkv -ext wmv .

    exiftool '-Directory<FileModifyDate' -d '%Y/%m-%B/%d-%m-%Y/videos' -if '$FileTypeExtension =~ /mp4|mov/i' -ext mp4 -ext mov -ext avi -ext mkv -ext wmv .

    printf "Sorted Videos.\n\n"

    # Came to conclusion that I don't want audios and docs sorted in the '%Y/%m-%B/%d-%m-%Y/audios' format
    # Audios

    mv --target-directory=./audios --update --interactive --verbose -- *.mp3 *.m4a

    printf "Sorted Audios.\n\n"

    # Docs
    mv --target-directory=./docs --update --interactive --verbose -- *.txt *.docx *.doc *.zip *.fb2 *.pdf *.xlsx *.pptx *.ics *.md *.epub

    printf "Sorted Docs.\n\n"

   
}

if sorting
then
    printf "\nSorted files in and moved them to videos, photos and docs folders accordingly.\n"
else
    printf "\nError: could not move test files.\n" 1>&2
    exit 1
fi
