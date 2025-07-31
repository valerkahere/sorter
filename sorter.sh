#!/usr/bin/env bash

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


isAudio() {
    # Audios
    # If they audio files are not in the folder - do not create folder for them

    find . -type f \( \
    -iname "*.mp3" -o \
    -iname "*.m4a" -o \
    -iname "*.flac" -o \
    -iname "*.wav" -o \
    -iname "*.ogg" \
    \) -print -quit
}

isDocs() {
    #Docs

    find . -type f \( \
    -iname "*.doc" -o \
    -iname "*.docx" -o \
    -iname "*.pdf" -o \
    -iname "*.xls" -o \
    -iname "*.xlsx" -o \
    -iname "*.ppt" -o \
    -iname "*.pptx" -o \
    -iname "*.csv" \
    \) -print -quit
}


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

    #Audio
    if isAudio
    then 
    printf "Audio files exist in current folder. Creating 'audios'.\n\n"
    mkdir 'audios'
    mv --target-directory=./audios --update --interactive --verbose -- \
    *.mp3 \
    *.m4a \
    *.flac \
    *.m4a \
    *.wav \
    *.ogg
    printf "Sorted Audios.\n\n"
    else
    printf "There are no audio files according to available extensions.\n\n"
    fi
    

    # Docs
    if isDocs
    then 
    printf "Docs files exist in current folder. Creating 'docs'.\n\n"
    mkdir 'docs'
    mv --target-directory=./docs --update --interactive --verbose -- \
    *.txt *.TXT *.Txt \
    *.docx *.doc *.DOCX *.DOC \
    *.zip *.ZIP \
    *.fb2 *.FB2 \
    *.pdf *.PDF \
    *.xls *.xlsx *.XLS *.XLSX \
    *.ppt *.pptx *.PPT *.PPTX \
    *.ics *.md *.epub *.csv *.ICS *.MD *.EPUB *.CSV
    printf "Sorted Docs.\n\n"
    else
    printf "There are no docs files according to available extensions.\n\n"
    fi
}

if sorting
then
    printf "\nSorted files in and moved them to videos, photos and docs folders accordingly.\n"
else
    printf "\nError: could not move test files.\n" 1>&2
    exit 1
fi
