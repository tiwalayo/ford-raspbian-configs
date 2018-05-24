<h3 align="center"><img src="https://i.imgur.com/VP3CnHu.png" width="200px"></h3>


# ford-rc: Ms. Ford's Raspbian Configs


Configuration backup and documentation for Ms. Ford's Raspberry Pi B2 ricing

## Images

<img src="https://i.imgur.com/zxbZrZo.jpg" alt="img" align="right" width="400px">

The two most important images for the ricing configuration are `~/Pictures/Wal/bg1.jpg` (the Ford logo) and `~/Pictures/Wal/terminal_img.jpg` (the adorable baby goat). `bg1.jpg` is the wallpaper background and `terminal_img.jpg` is the image presented when the `neofetch` command is executed in the terminal. I don't know whether or not the images you choose must have certain dimension specifications, because the defaults I chose worked on the first try. For the sake of aesthetics, it's recommended that `terminal_img.jpg` has square dimensions.

## i3 and the $mod key

The beautiful thing about i3 is that it augments productivity by a large margin by allowing for quick navigation between (and straightforward modification of) windows. Combine this with proficiency in `vim`, and it's a programmer's dream. i3 removes the need for a mouse (using a mouse is still possible, however; sometimes it is even rather convenient) by assigning several modes and functions to the keyboard. At the heart of these keyboard shortcuts is the $mod key, which is defined in `~/.config/i3/config`. By default, $mod is set to `Mod4`, i.e. the Windows key. You can change the several shortcuts as well as the key used for $mod by editing your `~/.config/i3/config` file. **Warning:** setting a different key as $mod may interfere with other shortcuts (for instance, using Shift as $mod may make capitalization impossible without using Caps Lock).

Here are a few shortcuts; the full list is available in `~/.config/i3/config`. Read the config file to understand it, and, if necessary, make changes to make the most of your configuration.

### Basic commands

Use $mod+Return (i.e. $mod+[Enter]) to open a new terminal window

Use $mod+Shift+q to close the current window

Use $mod+d to open dmenu

Use $mod+h to make tiled windows split horizontally next time you create a new window

Use $mod+v to make tiled windows split vertically next time you create a new window (ex: pressing $mod+Return then $mod+v then $mod+Return will create two vertically-aligned terminal windows)

Use $mod+Shift+c to reload/refresh your configuration

### Moving between windows

Use $mod+Shift+space to make a floating window tiled (or vice versa)

Use $mod+space to toggle between tiling/floating-focus mode. When in floating-focus mode, you can access your floating windows, and when in tiled-focus mode you can access your tiled windows 

In tiled-focus mode, use $mod+ArrowKey to change focus to the tiled window to the ArrowKey-direction of the currently focused window (e.g. $mod+Down will change focus to the tiled window below your currently focused tiled window)

In floating-focus mode, use $mod+Left/Right to cycle through your floating windows

*Note that you can also simply click on the window you want using the mouse.*

Use $mod+# to switch to workspace #, where # is an integer between 0 and 9, inclusive

### Resizing and moving windows

Press $mod to be able to resize floating windows with the mouse

Hold $mod to be able to move a floating window using the mouse

Use $mod+Shift+ArrowKey to move the focused floating window in the direction of the ArrowKey pressed

Use $mod+Shift+# to move the focused window to workspace #, where # is an integer between 0 and 9, inclusive

Use $mod+r to enter resize mode. After entering resize mode, use the arrow keys to resize the window. Then press the Escape key to exit resize mode

## dmenu

Dmenu is kind of like a Start Menu search bar, and it is the ideal way to open GUI applications such as `midori` (the lightweight Web browser). By default, `$mod+d` opens dmenu, from which you can search for and open GUI-based programs. (You can try to open non-GUI programs, but it won't do anything.) For example, instead of executing

    $mod+Return   #launch terminal
    program &      #launch "program" outside the terminal
    exit           #close terminal

to "cleanly" open an application through `urxvt` (i.e. the terminal), you can simply execute

    $mod+d             #open dmenu
    program [Enter]    #search for "program" and run it

to open an application using dmenu.

## ranger

Ranger is pretty straightforward. It is a terminal-based file manager that integrates well with the riced theme. Execute `ranger` in a terminal, and the entire terminal will be transformed into a file manager that is pretty intuitive to navigate. Vim users will find the way ranger behaves rather familiar. Type `:q[Enter]` to quit ranger. Learn more about how to use ranger [here](https://ranger.github.io/).

## lemonbar

Lemonbar is a program that sends its input to the bar at the bottom of the screen. The input is acquired through the shell script at `~/.config/lemon/lemonfeeder.sh`. It is composed of several functions that extract system info through bash commands. For instance, the function `geteth()` executes `ifconfig`, searches for an instance of "eth0" in the output, and then uses Unix positional parameters to print the accompanying local IP address:

```
geteth(){
    var=$(echo $(ifconfig eth0 | grep 'inet ') | awk '{print $2;}')
    echo "E: $var"
}

...

BAR_INPUT="$(gitHelpMessage)${TABB}...$(geteth)${TABB}...$(clock)${TABB}"
echo "%{r}${F#2B84BB} $BAR_INPUT"

```


Then, `geteth()` is called by `BAR_INPUT`, which concatenates the output of all the other system info functions, separating each datum by 5 spaces (the ${TABB} variable). The concatenated data is returned by the shell script, which pipes this output to lemonbar, which puts the info at the bottom of the screen. `lemonfeeder.sh` runs every second, making the bar consistently update itself. (See `~/.config/i3/config` to view exactly how lemonbar is called.)

If you want make changes to the lemonbar, then add a **bash** function that parses and/or returns what you want to the body of `lemonfeeder.sh` and then add the function to the `BAR_INPUT` variable (which is also in the .sh file) in the order that you want. Reload your computer to finalize changes (i.e. run `reboot` in a terminal). You can also change the color of the bar foreground and background by editing the final `echo` command in `lemonfeeder.sh` according to the formatting rules documented [here](https://wiki.archlinux.org/index.php/lemonbar#Usage).

By default, there is a (non-clickable) link on the lemonbar to this repository (in case support is sought). You can remove this by deleting the `$(gitHelpMessage)${TABB}` from `BAR_INPUT`.

## Useful programs/commands

* nano - straightforward in-terminal text editor
* gedit - GUI text editor
* midori - lightweight browser
* ranger - file manager

---

* `neofetch` - command that pretty-prints various system info in the terminal
* `wget` - command that downloads a file from a URL
* `chmod +x [file]` - command that makes a file executable
* `reboot` - command the restarts the computer
* `shutdown` - command that shuts down the comuter (use `shutdown now` to shutdown immediately)
* `sudo apt-get install [package]` - command that installs a program, assuming it exists in the Raspbian repositories

## Configuration backup

If certain files in your `.config` directory get lost, ruined, etc., then you can replace the files within the directory (or replace the entire directory, if you wish to revert to defaults) with the files in the `.config` directory from this repository.

To revert to intended defaults, run the following commands:

    git clone https://github.com/tiwalayo/ford-rc
    cp -r ford-rc/.config ~/.config
    rm -rf ford-rc
	
To change a certain file(s):

    git clone https://github.com/tiwalayo/ford-rc
    cp ford-rc/.config/file-to-replace ~/.config/file-to-replace
    cp ford-rc/.config/file2-to-replace ~/.config/file2-to-replace   #do this for however many files you want to replace
    rm -rf ford-rc/                                                  #after you're done replacing files

## Support

If you have any issues or questions, submit a ticket in the issues tab of this repository and I'll look into it.

