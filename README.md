# Devlix WM (Dwm Fork)

## Table of contents :

* Description
    * Patches
    * Key binds
    * Images
* Installation
* To do

## Description

This is a fork of `dwm 6.4` with a lot of changes in the configurations and a lot of patches applied.

### Patches

All patches can be found in the [patch](patch/) directory.

#### List of patches applied
| File Name & Path | Readme |
|-------------|--------|
[dwm-6.2-urg-border.diff](patch/dwm-6.2-urg-border.diff)|[https://dwm.suckless.org/patches/urgentborder/](https://dwm.suckless.org/patches/urgentborder/)
[dwm-alwayscenter-20200625-f04cac6.diff](patch/dwm-alwayscenter-20200625-f04cac6.diff)|[https://dwm.suckless.org/patches/alwayscenter/](https://dwm.suckless.org/patches/alwayscenter/)
[dwm-attachbelow-6.2.diff](patch/dwm-attachbelow-6.2.diff)|[https://dwm.suckless.org/patches/attachbelow/](https://dwm.suckless.org/patches/attachbelow/)
[dwm-autostart-20210120-cb3f58a.diff](patch/dwm-autostart-20210120-cb3f58a.diff)|[https://dwm.suckless.org/patches/autostart/](https://dwm.suckless.org/patches/autostart/)
[dwm-cursorwarp-6.3.diff](patch/dwm-cursorwarp-6.3.diff)|[https://dwm.suckless.org/patches/cursorwarp/](https://dwm.suckless.org/patches/cursorwarp/)
[dwm-fullgaps-6.4.diff](patch/dwm-fullgaps-6.4.diff)|[https://dwm.suckless.org/patches/fullgaps/](https://dwm.suckless.org/patches/fullgaps/)
[dwm-movestack-20211115-a786211.diff](patch/dwm-movestack-20211115-a786211.diff)|[https://dwm.suckless.org/patches/movestack/](https://dwm.suckless.org/patches/movestack/)
[dwm-pertag-20200914-61bb8b2.diff](patch/dwm-pertag-20200914-61bb8b2.diff)|[https://dwm.suckless.org/patches/pertag/](https://dwm.suckless.org/patches/pertag/)

### Images
| 1 | 2 |
|---|---|
![devlix](screenshots/scrot1.png)|![devlix](screenshots/scrot2.png)

## Installation

**Warning: I will assume this is a clean arch linux installation**
### Steps

1. Install these packages:

```bash
sudo pacman -Syu alacritty xorg-server xorg-xinit xorg-xsetroot xorg-xrandr feh picom python-pywal neofetch lf ueberzug ffmpegthumbnailer imagemagick poppler base-devel git bat chafa unzip p7zip unrar cardoc docx2txt odt2txt gnumeric exiftool zsh vim go webkit2gtk libxft libxinerama libx11
```

```bash
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
yay -Syu epub-thumbnailer-git wkhtmltopdf-static 7-zip
```
2. Change you default shell to zsh

```bash
chsh -s /usr/bin/zsh
exit
```
Then login
Press 1 then 2 then 1 then 0

3. Now install oh my zsh with these commands

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

also install these plugins for it

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
```

4. Install also this nerd font for customization

```bash
sudo pacman -Syu ttf-jetbrains-mono-nerd
```

5. Clone this repository in your home directory

```bash
git clone https://github.com/Mohamed1242012/suckless.git
```

6. Copy these files

```bash
cp suckless/.p10k.zsh ~/.p10k.zsh
cp suckless/.zshrc ~/.zshrc
cp suckless/.zprofile ~/.zprofile
```

7. Install p10k
```bash
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
```
