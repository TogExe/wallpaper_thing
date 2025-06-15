# My thing to simplify wallpapers on arch
all you need is the sh and to have installed steam via 
```pacman -S steam```
then just run 
```sh
wpeselec.sh -i #installs the dependencies
```
and then `wpeselec.sh` to switch between wallpapers

if you need any help add me on discord.
## Note for the unstabe update.
- first step :
**Create the wallpaper config file**
```sh
touch ~/.config/hypr/wpe.con
```
you need to modify the `~/.config/hypr/hyprland.conf` and add 
```conf
source = ~/.config/hypr/wpe.conf
```
then just use the sh program the normal way and use --n --apply to preview and setup the wallpaper.
