#!/bin/bash

# Define the directory where your Steam Workshop items are stored
WORKSHOP_DIR="$HOME/.steam/steam/steamapps/workshop/content/431960"

# Check if the directory exists
if [ ! -d "$WORKSHOP_DIR" ]; then
    echo "Directory $WORKSHOP_DIR does not exist."
    exit 1
fi

# Function to get the folder ID by its order number
get_wp_engine() {
    local n=$1
    local count=0

    # Loop through each folder in the directory
    for folder in "$WORKSHOP_DIR"/*; do
        if [ -d "$folder" ]; then
            count=$((count + 1))
            if [ "$count" -eq "$n" ]; then
                # Extract the folder name which is the ID
                local folder_name=$(basename "$folder")

                echo "id of the $n th folder is : $folder_name"
                echo "Running : 'linux-wallpaperengine --screen-root DP-1 --bg $folder_name'"
                linux-wallpaperengine --screen-root DP-1 --bg $folder_name
                return
            fi
        fi
    done

    echo "No folder found at position $n"
}

display_help() {
    echo "Usage: $0 [--help] [--version] [--n <number>] [--apply]"
    echo "Options:"
    echo "  --help     Display this help message"
    echo "  --version  Display the version of the script"
    echo "  --n        Specify an input file"
    echo "  --apply    Apply the selected wallpaper without confirmation and modify a file"
    echo "  -i         Install dependencies arch by default"
    # Add more options as needed
}

dep_all(){
    #sudo pacman -S jp2a
    #yay -S linux-wallpaperengine-git
    PACKAGE="jp2a"
    if ! pacman -Q "$PACKAGE" > /dev/null 2>&1; then
        echo "$PACKAGE is not installed. Installing it now..."
        sudo pacman -S --noconfirm "$PACKAGE"
    else
        echo "$PACKAGE is already installed."
    fi

    PACKAGE1="linux-wallpaperengine-git"
    if ! pacman -Q "$PACKAGE1" > /dev/null 2>&1; then
        echo "$PACKAGE1 is not installed. Installing it now..."

        # Check if yay is installed
        if ! command -v yay > /dev/null 2>&1; then
            echo "yay is not installed. Please install yay first."
            exit 1
        fi

        # Install the package using yay
        yay -S --noconfirm "$PACKAGE1"
    else
        echo "$PACKAGE1 is already installed."
    fi
}

up_all(){
    #sudo pacman -S jp2a
    #yay -S linux-wallpaperengine-git
    PACKAGE="jp2a"
    if ! pacman -Q "$PACKAGE" > /dev/null 2>&1; then
        echo "$PACKAGE is not installed. Installing it now..."
        sudo pacman -S --noconfirm "$PACKAGE"
    else
        echo "$PACKAGE is already installed."
        sudo pacman -R --noconfirm "$PACKAGE"
        sudo pacman -S --noconfirm "$PACKAGE"
    fi

    PACKAGE1="linux-wallpaperengine-git"
    if ! pacman -Q "$PACKAGE1" > /dev/null 2>&1; then
        echo "$PACKAGE1 is not installed. Installing it now..."

        # Check if yay is installed
        if ! command -v yay > /dev/null 2>&1; then
            echo "yay is not installed. Please install yay first."
            exit 1
        fi

        # Install the package using yay
        yay -S --noconfirm "$PACKAGE1"
    else
        echo "$PACKAGE1 is already installed."
        yay -R --noconfirm "$PACKAGE1"
    fi
}

modify_file() {
	# Just modifying a specific config file for the background 
	# to be activated on load.
    local n=$1
    local file_path="~/.config/hypr/wpe.conf"
	
    touch file_path
	#truncate -s 0 file_path
	#printf "New content\n" >> file_path
	echo "exec-once = $0 --n $n" | tee ~/.config/hypr/wpe.conf > /dev/null
	#echo "someee data for the file" >> ~/.config/hypr/wpe.conf
    #cat "~/.config/hypr/wp_engstartup.conf" 
    #"text"
}

print_wp() {
    local apply=$2
    echo "Put the number of the wallpaper you would like to select:"
    read -r input
    local count=0

    # Loop through the first 10 folders
    for folder in "$WORKSHOP_DIR"/*; do
        if [ -d "$folder" ]; then
            count=$((count + 1))
            if [ "$count" -eq "$input" ]; then
                jp2a --color --width=50 "$folder"/"preview.jpg"

                if [ -n "$apply" ]; then
                    echo "Applying the selected wallpaper..."
                    linux-wallpaperengine --screen-root DP-1 --bg "$(basename "$folder")"
                    modify_file "$input"
                    return
                else
                    echo "Apply? : [y/n]"
                    read -n 1 yn
                    if [ "$yn" = "y" ]; then
                        linux-wallpaperengine --screen-root DP-1 --bg "$(basename "$folder")"
                        return
                    elif [ "$yn" = "n" ]; then
                        echo ""
                        return 1
                    fi
                fi
            fi
        fi
    done
    exit 1
}

# Check for --help option
if [ "$1" = "--help" ]; then
    display_help
    exit 0
elif [ "$1" = "-i" ]; then
    dep_all
    exit 0
elif [ "$1" = "-u" ]; then
    up_all
    exit 0
fi

# Parse command line arguments
apply=""
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --n) n="$2"; shift ;;
        --apply) apply="true" ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

# Check if n is set
if [ -z "$n" ]; then
    while true; do
        print_wp "$apply"
    done
    exit 1
fi

# Call the function with the provided number
if [ -n "$apply" ]; then
    get_wp_engine "$n"
    modify_file "$n"
else
    get_wp_engine "$n"
fi
