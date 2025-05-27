#linux-wallpaperengine --screen-root DP-1 --bg 2122598327
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

				echo "id of the 4 th folder is : $folder_name"
				echo "Running :'linux-wallpaperengine --screen-root DP-1 --bg $folder_name'"
				#linux-wallpaperengine --screen-root DP-1 --bg $folder_name
				#linux-wallpaperengine --screen-root DP-1 --bg 2122598327
				linux-wallpaperengine --screen-root DP-1 --bg $folder_name     
                return
            fi
        fi
    done

    echo "No folder found at position $n"
}

display_help() {
    echo "Usage: $0 []"
    echo "Options:"
    echo "  --help     Display this help message"
    echo "  --version  Display the version of the script"
    echo "  --n        Specify an input file"

    echo "  -i         Install dependencies arch by default"
    # Add more options as needed
}

dep_all(){
	#sudo pacman -S jp2a
	#yay -S linux-wallpaperengine-git
	PACKAGE="jp2a"
	if ! pacman -Q "$PACKAGE" > /dev/null 2>&1; then
	    echo "$PACKAGE is not installed. Installing it now..."
	    sudo pacman -Sy --noconfirm "$PACKAGE"
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

print_wp(){
	echo "Put the number of the walpaper you would like to select :"
	read -r input
	#local n = 10
	local count = 0

	#loop through the 10 first folders 
	for folder in "$WORKSHOP_DIR"/*; do
        if [ -d "$folder" ]; then
            count=$((count + 1))
            #jp2a --color --width=50 "$folder"/"preview.jpg"
            if [ $count -eq $input ]; then
            	jp2a --color --width=50 "$folder"/"preview.jpg"

				echo "Apply ? : [y/n]"
            	read -n 1 yn
            	if [ "$yn" =  "y" ]; then
            		#set +v  # Turn off command echoing
            		#exec > /dev/null
            		linux-wallpaperengine --screen-root DP-1 --bg $folder
            		#exec 1>&3  # Restore stdout
            		#set -v  # Turn off command echoing
            		return
            	elif [ "$yn" =  "n" ]; then
            		echo ""
            	    return 1
            	
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
fi

# Parse command line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --n) n="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

# Check if n is set
if [ -z "$n" ]; then
    #echo "Usage: $0 --n <number>"
    while true; do
		print_wp
    done
    exit 1
fi

# Call the function with the provided number
get_wp_engine "$n"
