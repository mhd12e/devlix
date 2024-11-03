# Devlix WM 1.0 (`dwm` Fork)

## Table of contents :

* Description
    * Patches
    * Images
    * Key binds
* Installation
    * Steps
    * Wallpapers
* To do
* Credits

## Description

This is my setup with a lot of changes in `dwm`, `dmenu`, `dwmblocks` by torrinfail, the configurations and a lot of patches applied.

### Patches

#### List of patches applied (`dwm`)
| File Name & Path | Readme |
|-------------|--------|
|[dwm-6.2-urg-border.diff](dwm/patch/dwm-6.2-urg-border.diff)|[https://dwm.suckless.org/patches/urgentborder/](https://dwm.suckless.org/patches/urgentborder/)|
|[dwm-alwayscenter-20200625-f04cac6.diff](dwm/patch/dwm-alwayscenter-20200625-f04cac6.diff)|[https://dwm.suckless.org/patches/alwayscenter/](https://dwm.suckless.org/patches/alwayscenter/)|
|[dwm-attachbelow-6.2.diff](dwm/patch/dwm-attachbelow-6.2.diff)|[https://dwm.suckless.org/patches/attachbelow/](https://dwm.suckless.org/patches/attachbelow/)|
|[dwm-autostart-20210120-cb3f58a.diff](dwm/patch/dwm-autostart-20210120-cb3f58a.diff)|[https://dwm.suckless.org/patches/autostart/](https://dwm.suckless.org/patches/autostart/)|
|[dwm-cursorwarp-6.3.diff](dwm/patch/dwm-cursorwarp-6.3.diff)|[https://dwm.suckless.org/patches/cursorwarp/](https://dwm.suckless.org/patches/cursorwarp/)|
|[dwm-fullgaps-6.4.diff](dwm/patch/dwm-fullgaps-6.4.diff)|[https://dwm.suckless.org/patches/fullgaps/](https://dwm.suckless.org/patches/fullgaps/)|
|[dwm-movestack-20211115-a786211.diff](dwm/patch/dwm-movestack-20211115-a786211.diff)|[https://dwm.suckless.org/patches/movestack/](https://dwm.suckless.org/patches/movestack/)|
|[dwm-pertag-20200914-61bb8b2.diff](dwm/patch/dwm-pertag-20200914-61bb8b2.diff)|[https://dwm.suckless.org/patches/pertag/](https://dwm.suckless.org/patches/pertag/)|

#### List of patches applied (`dmenu`)
| File Name & Path | Readme |
|-------------|--------|
|[dmenu-alpha-20230110-5.2.diff](dmenu/patch/dmenu-alpha-20230110-5.2.diff)|[https://tools.suckless.org/dmenu/patches/center/](https://tools.suckless.org/dmenu/patches/center/)|
|[dmenu-center-20240616-36c3d68.diff](dmenu/patch/dmenu-center-20240616-36c3d68.diff)|[https://tools.suckless.org/dmenu/patches/center/](https://tools.suckless.org/dmenu/patches/center/)|
|[dmenu-numbers-20220512-28fb3e2.diff](dmenu/patch/dmenu-numbers-20220512-28fb3e2.diff)|[https://tools.suckless.org/dmenu/patches/numbers/](https://tools.suckless.org/dmenu/patches/numbers/)|

### Images
| 1 | 2 |
|---|---|
|![devlix](screenshots/scrot1.png)|![devlix](screenshots/scrot2.png)|

### Key binds and shourtcuts

#### Keyboard Shortcuts

`MODKEY` is the `alt` key by default

| Shortcut                       | Function                     | Description                                                      |
|--------------------------------|------------------------------|------------------------------------------------------------------|
| `MODKEY + s`                   | `spawn`                      | Take a screenshot and save to `/home/mohamed/Pictures/scrot/`.   |
| `MODKEY + p`                   | `spawn`                      | Launch `dmenu_run` (program launcher).                           |
| `MODKEY + Shift + Enter`       | `spawn`                      | Open terminal (`alacritty`).                                     |
| `MODKEY + b`                   | `togglebar`                  | Toggle visibility of the top bar.                                |
| `MODKEY + j`                   | `focusstack +1`              | Focus the next window in the stack.                              |
| `MODKEY + k`                   | `focusstack -1`              | Focus the previous window in the stack.                          |
| `MODKEY + i`                   | `incnmaster +1`              | Increase the number of windows in the master area.               |
| `MODKEY + d`                   | `incnmaster -1`              | Decrease the number of windows in the master area.               |
| `MODKEY + h`                   | `setmfact -0.05`             | Decrease the size of the master window area.                     |
| `MODKEY + l`                   | `setmfact +0.05`             | Increase the size of the master window area.                     |
| `MODKEY + Shift + j`           | `movestack +1`               | Move the focused window down in the stack.                       |
| `MODKEY + Shift + k`           | `movestack -1`               | Move the focused window up in the stack.                         |
| `MODKEY + Enter`               | `zoom`                       | Promote the focused window to the master area.                   |
| `MODKEY + Tab`                 | `view`                       | Toggle to the previously selected tag.                           |
| `MODKEY + Shift + c`           | `killclient`                 | Close the focused window.                                        |
| `MODKEY + t`                   | `setlayout tile`             | Set the window layout to tiling mode.                            |
| `MODKEY + f`                   | `setlayout NULL`             | Set the window layout to floating mode.                          |
| `MODKEY + m`                   | `setlayout monocle`          | Set the window layout to monocle (single fullscreen) mode.       |
| `MODKEY + space`               | `setlayout`                  | Toggle between layouts.                                          |
| `MODKEY + Shift + space`       | `togglefloating`             | Toggle floating mode for the focused window.                     |
| `MODKEY + 0`                   | `view all tags`              | Show windows from all tags.                                      |
| `MODKEY + Shift + 0`           | `tag all tags`               | Tag focused window with all tags.                                |
| `MODKEY + ,`                   | `focusmon -1`                | Focus the previous monitor.                                      |
| `MODKEY + .`                   | `focusmon +1`                | Focus the next monitor.                                          |
| `MODKEY + Shift + ,`           | `tagmon -1`                  | Move the focused window to the previous monitor.                 |
| `MODKEY + Shift + .`           | `tagmon +1`                  | Move the focused window to the next monitor.                     |
| `MODKEY + -`                   | `setgaps -1`                 | Decrease the gaps between windows.                               |
| `MODKEY + =`                   | `setgaps +1`                 | Increase the gaps between windows.                               |
| `MODKEY + Shift + =`           | `setgaps 0`                  | Set the gaps between windows to zero.                            |
| `MODKEY + Shift + q`           | `quit`                       | Exit `dwm`.                                                      |
| `XF86AudioMute`                | `spawn mutecmd`              | Toggle mute for the system volume.                               |
| `XF86AudioLowerVolume`         | `spawn voldowncmd`           | Decrease the system volume.                                      |
| `XF86AudioRaiseVolume`         | `spawn volupcmd`             | Increase the system volume.                                      |
| `Mod4 + space`                 | `spawn keylayout`            | Toggle the keyboard layout.                                      |
| `XF86MonBrightnessUp`          | `spawn brightness_up`        | Increase screen brightness.                                      |
| `XF86MonBrightnessDown`        | `spawn brightness_down`      | Decrease screen brightness.                                      |
| `XF86PowerOff`                 | `spawn power_menu`           | Open the power menu script.                                      |
| `Pause`                        | `spawn power_menu`           | Open the power menu script.                                      |
| `MODKEY + (1-9)`               | `view`                       | Switch to a specific tag (workspace) by number.                  |
| `MODKEY + Control + (1-9)`     | `toggleview`                 | Toggle display of windows from a specific tag.                   |
| `MODKEY + Shift + (1-9)`       | `tag`                        | Apply a tag to the focused window.                               |
| `MODKEY + Control + Shift + (1-9)` | `toggletag`            | Toggle tagging of the focused window on a specific tag.          |

#### Mouse Shortcuts

| Click Target           | Modifier       | Button    | Function         | Description                                      |
|------------------------|----------------|-----------|------------------|--------------------------------------------------|
| Layout Symbol          | None           | Button1   | `setlayout`      | Set the layout.                                  |
| Layout Symbol          | None           | Button3   | `setlayout monocle` | Set layout to monocle (fullscreen).             |
| Window Title           | None           | Button2   | `zoom`           | Promote the focused window to the master area.   |
| Status Text            | None           | Button2   | `spawn termcmd`  | Open terminal (`alacritty`).                     |
| Client Window          | `MODKEY`       | Button1   | `movemouse`      | Move the window.                                 |
| Client Window          | `MODKEY`       | Button2   | `togglefloating` | Toggle floating mode for the window.             |
| Client Window          | `MODKEY`       | Button3   | `resizemouse`    | Resize the window.                               |
| Tag Bar                | None           | Button1   | `view`           | Switch to the selected tag.                      |
| Tag Bar                | None           | Button3   | `toggleview`     | Toggle the selected tag view.                    |
| Tag Bar                | `MODKEY`       | Button1   | `tag`            | Tag the focused window with the selected tag.    |
| Tag Bar                | `MODKEY`       | Button3   | `toggletag`      | Toggle tagging the focused window on a tag.      |


## Installation

**Warning: I will assume this is a brand new minimal arch linux installation**

**If you are doing this on virtual box enable 3d acceleration**

### Steps

1. Install these packages

```bash
sudo pacman -Syu alacritty xorg-server xorg-xinit xorg-xsetroot xorg-xrandr feh picom python-pywal neofetch lf ueberzug ffmpegthumbnailer imagemagick poppler base-devel git bat chafa unzip p7zip unrar catdoc docx2txt odt2txt gnumeric zsh vim go webkit2gtk libxft libxinerama libx11 ttf-jetbrains-mono-nerd alsa-utils scrot python3 networkmanager
```

```bash
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
yay -Syu epub-thumbnailer-git wkhtmltopdf-static 7-zip
```

2. `Git clone` this repository

```bash
git clone https://github.com/Mohamed1242012/suckless.git
```

3. Set the wallpaper by `wal`
```
cd suckless
wal -i wallpapers/[img name]
cd alacritty-color-export/
./script.sh
cd ..
```

#### Available Wallpapers
| Name | IMG | Name | IMG |
|------|-----|------|-----|
| walll1.jpg | ![wall1.jpg](wallpapers/wall1.jpg) | wall2.png | ![wall2.png](wallpapers/wall2.png) |
| walll3.png | ![wall3.png](wallpapers/wall3.png) | wall4.png | ![wall4.png](wallpapers/wall4.png) |
| wall5.jpg | ![wall5.jpg](wallpapers/wall5.jpg) |

4. Build

```bash
cd dwm
sudo make clean install
cd ..
cd dmenu
sudo make clean install
cd ..
cd dwmblocks
sudo make clean install
cd ..
```

5. Put all configs into place

```bash
rm -rf ~/.config/wal
cp -r configs/* ~/.config/
```

6. Set `zsh` as default shell

```bash
chsh -s /usr/bin/zsh
exit
```
Now login
Then press 1 then 2 then 1 then 0

7. Install `ohmyzsh`

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
exit
exit
```
Now login

8. Install `zsh` plugins and `powerlevel10k`

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
```

9. Putting more configs into place

```bash
cp suckless/.zshrc ~/.zshrc
cp suckless/.zprofile ~/.zprofile
cp suckless/.xinitrc ~/.xinitrc
cp suckless/.p10k.zsh ~/.p10k.zsh
```

8. `lf` image support

```bash
cd suckless/lfimg
sudo make clean install
```

9. Finally

```bash
exit
```
Now login

#### And You should be greeted with Devlix WM

---

### To Do

- [ ] Make an installer script
- [ ] Add key binds page
- [x] Fix freezing on virtual box
- [ ] Add support for multilingual keyboards other than Arabic
- [ ] Add it to the `AUR`
- [ ] Making a `vim` config
- [x] Audio key bind script
- [x] Brightness key bind script
- [ ] Adding a clipboard manager (`clipmenu` - integration with `dmenu`)
- [ ] Adding a notification manager
- [ ] Making a change background script
- [ ] Organizing the project more
- [ ] Finding a contributor :\
- [ ] Adding `slstatus` patch to `dwm`
- [ ] Make a documentation
- [ ] Make a wiki
- [ ] Make a website
- [ ] Add more photos and videos
- [ ] Make a YouTube channel
- [ ] Post on r/unix port
- [ ] Making a more descriptive `README.md`
- [ ] Configuring `scrot` for screenshots

---

### Credits
[LICENSE](LICENSE)

This open source project wouldn't be possible without these people and there open source projects:
- [https://github.com/egeesin/pywal2alacritty](https://github.com/egeesin/pywal2alacritty)
- [https://git.suckless.org/dwm](https://git.suckless.org/dwm)
- [https://git.suckless.org/dmenu](https://git.suckless.org/dmenu)
- [https://github.com/dylanaraps/pywal](https://github.com/dylanaraps/pywal)
- [https://github.com/torrinfail/dwmblocks](https://github.com/torrinfail/dwmblocks)
- [https://github.com/thimc/lfimg](https://github.com/thimc/lfimg)