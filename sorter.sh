#!/usr/bin/env bash

printf "\nWelcome\n"

printf "\nEnter the path of the (SOURCE) folder to sort AS IT IS (white spaces are handled automatically)\n"
printf "WARNING: tilde expansion (~) does not work: \n"

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

isPhotos() {
    # Images
    # If the photo files are not in the SOURCE - do not create folder for them
    echo $PWD

    

    output=$(find . -type f -iname "*.jpg" -o -iname ".jpeg" -o -iname ".png" -o -iname ".webp" -o -iname ".gif" -o -iname ".bmp" -o -iname ".tiff" -quit)

 


    if [[ -z "$output" ]]
    then
    printf "No photo files.\n\n"
    else
    printf "Photo files exist in current folder.\n\n"
    printf "Enter 'Y' if you want to sort photos as '2025/05-May/01-05-2025/photos' or 'n' to keep them in a separate 'photos' folder  [Y/n]:\n"
    read answer
    if [ "$answer" = "y" ] || [ "$answer" = "Y" ]
    then
    exiftool '-Directory<DateTimeOriginal' -d '%Y/%m-%B/%d-%m-%Y/photos' -if '$FileTypeExtension =~ /jpe?g|png|webp|gif|bmp|tiff/i' -ext jpg -ext jpeg -ext png -ext webp -ext gif -ext bmp -ext tiff  .
    exiftool '-Directory<FileModifyDate' -d '%Y/%m-%B/%d-%m-%Y/photos' -if '$FileTypeExtension =~ /jpe?g|png|webp|gif|bmp|tiff/i' -ext jpg -ext jpeg -ext png -ext webp -ext gif -ext bmp -ext tiff  .
    printf "Sorted Photos.\n\n"
    else
    mkdir 'photos'
    mv --target-directory=./photos --update --interactive --verbose -- \
    *.jpg *.JPG *.jpeg *.JPEG \
    *.png *.PNG *.webp *.WEBP \
    *.gif *.GIF *.bmp *.BMP \
    *.tiff *.TIFF
    printf "\nMoved images to the './photos' folder.\n\n"
    fi
    fi

    


}


isAudio() {
    # Audios
    # If the audio files are not in the folder - do not create folder for them



    output=$(find . -type f \( \
    -iname "*.mp3" -o \
    -iname "*.m4a" -o \
    -iname "*.flac" -o \
    -iname "*.jpg" -o \
    -iname "*.ogg" \
    \) -quit)
    
    if [[ -z "$output" ]]
    then
    printf "No audio files.\n\n"
    else
    printf "Some audio files will be moved know.\n"
    printf "Creating 'audios' folder.\n\n"
    mkdir 'audios'
    mv --target-directory=./audios --update --interactive --verbose -- \
    *.mp3 \
    *.m4a \
    *.flac \
    *.m4a \
    *.wav \
    *.ogg
    printf "Sorted Audios.\n\n"
    fi
   
}

isDocs() {
    #Docs

    output=$(find . -type f \( \
    -iname "*.doc" -o \
    -iname "*.docx" -o \
    -iname "*.pdf" -o \
    -iname "*.xls" -o \
    -iname "*.xlsx" -o \
    -iname "*.ppt" -o \
    -iname "*.pptx" -o \
    -iname "*.csv" \
    \) -quit)

    if [[ -z "$output" ]]
    then
    printf "No docs files.\n\n"
    else
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
    fi

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

    

    if isPhotos
    then
    printf "Successfully sorted photos.\n\n"
    else
    printf "Error: Could not decide on photo files.\n\n" 1>&2
    fi
    

    # Videos

    printf "Enter 'Y' if you want to sort videos as '2025/05-May/01-05-2025/videos' or 'n' to keep them in a separate 'videos' folder  [Y/n]:\n"
    read answer
    if [ "$answer" = "y" ] || [ "$answer" = "Y" ]
    then
    exiftool '-Directory<DateTimeOriginal' -d '%Y/%m-%B/%d-%m-%Y/videos' -if '$FileTypeExtension =~ /mp4|mov|avi|mkv|wmv/i' -ext mp4 -ext mov -ext avi -ext mkv -ext wmv .
    exiftool '-Directory<FileModifyDate' -d '%Y/%m-%B/%d-%m-%Y/videos' -if '$FileTypeExtension =~ /mp4|mov/i' -ext mp4 -ext mov -ext avi -ext mkv -ext wmv .
    printf "Sorted Videos.\n\n"
    else
    mkdir 'videos'
    mv --target-directory=./videos --update --interactive --verbose -- \
    *.mp4 *.MP4 \
    *.mov *.MOV \
    *.avi *.AVI \
    *.mkv *.MKV \
    *.wmv *.WMV
    printf "\nMoved videos to the './videos' folder.\n\n"
    fi

    # if isVideos
    # then
    # printf "Successfully sorted videos.\n\n"
    # else
    # printf "Error: Could not decide on video files.\n\n" 1>&2
    # fi

    #Audio

    if isAudio
    then 
    printf "Successfully sorted audios.\n\n"
    else
    printf "Error: Could not decide on audio files.\n\n" 1>&2
    fi
    

    # Docs
    if isDocs
    then 
    printf "Successfully sorted docs.\n\n"
    else
    printf "Error: Could not decide on docs files.\n\n" 1>&2
    fi
}

if sorting
then
    printf "\nSorted files and moved them to videos, photos and docs folders accordingly.\n"
else
    printf "\nError: could not move test files.\n" 1>&2
    exit 1
fi

# printf "\nDo you want to remove the months folders and their contents? [Y/n]: \n"
# read answer
# if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
# 	rm -rf 1.January 2.February 3.March 4.April 5.May 6.June 7.July 8.August 9.September 10.October 11.November 12.December
# 	printf "\nFolders deleted as follows: \n\n"
# 	ls .
# else
# 	printf "\nNothing deleted."
# fi
# printf "\nThe script has finished.\n"

printf "Enter 'Y' to exit now and 'n' to restore everything? [Y/n]:\n"
read answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]
then
printf "Nothing deleted.\n\n"
else
find . -type f -path "./*" -exec mv '{}' .. \;
rm -rf '../MOVED'
fi
