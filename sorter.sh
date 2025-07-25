
#!/user/bin/env bash

# mkdir videos

# mv "*.mp4" "*.MOV" --target-directory=./videos --update --strip-trailing-slashes --interactive --verbose

# Или чтобы уменьшить количество ошибок, привязать stdout ls к mv? Use for loop?

# printf "\n\n"

printf "\nWelcome\n"

# Creating a function for error handling

testing() {
    mkdir 'test' 2>/dev/null
    cd './test'

    for (( i=0; i<=5; i++ ))
    do
        touch "file$i.mp4"
    done
}

if testing
then
    printf "\nTest files with .mp4 extension created in ./test folder\n"
else
    printf "\nError: could not create test folder and files\n" >2

printf "\nThis is the present working directory:\n\n"
pwd

printf "\nCreated test files in test folder as follows:\n\n"
ls