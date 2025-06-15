# My thing to simplify Almamu's linux-wallpaperengine on arch
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
*the commands could be subject to change in the future (I wanna make it more intuitive).
Another inconvenient is the full requirement of hyprland. Instead of just wayland.*
### Step 1 :
Create the wallpaper config file
```sh
touch ~/.config/hypr/wpe.con
```
### Step 2 :
Modify `~/.config/hypr/hyprland.conf` and add 
```conf
source = ~/.config/hypr/wpe.conf
```
### Step 3 :
--
Use the sh program the normal way and use `wpeselec.sh --n <number> --apply` to preview and setup the wallpaper.

___
## for more info on what i use check
- [Almamu](https://github.com/Almamu)'s [linux-wallpaperengine](https://github.com/Almamu/linux-wallpaperengine).
- [cslarsen](https://github.com/cslarsen)'s [jp2a](https://github.com/cslarsen/jp2a).

---
