# My thing to simplify wallpapers on arch
*Sorry for the ugly code i was probably too tired to make something clean*
--
all you need is the sh and to have installed steam via 
```pacman -S steam```
install the wallpapers via the workshop
then just run 
```sh
wpeselec.sh -i #installs the dependencies
```
and then `wpeselec.sh` to switch between wallpapers

if you need any help add me on discord.
## Note for the unstabe update.
### Step 1 :
Create the wallpaper config file
```sh
touch ~/.config/hypr/wpe.con
```
### Step 2 :
> Make sure to rename the shell program to `wpeselec.sh`i  not alredy done

Modify `~/.config/hypr/hyprland.conf` and add 
```conf
source = ~/.config/hypr/wpe.conf
```
### Step 3 :
Use the sh program the normal way and use `wpeselec.sh --n <number> --apply` to preview and setup the wallpaper.
