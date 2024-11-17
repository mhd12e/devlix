# Installation

> This will cover the installation process of Devlix and how to set it up.

You can install Devlix using the script or the manual way.


## Prerequisites

?> I will assume this is a new minimal Arch Linux installation and you user can use sudo

!> If you want to run Devlix wm on a Virtual Machine ensure that 3d acceleration is turned on, without it the Virtual Machine will freeze every time you open it

## Install script

These are the steps you need to follow to install Devlix wm with the installer script.

### Install `git` for cloning my repository

Install `git` on Arch Linux with this command

```bash
sudo pacman -Syu git
```

### Clone Devlix wm repository

Clone our repository with this command

```bash
git clone https://github.com/mohamed1242012/devlix.git
```


### Start the script

Start the installer script using these commands

```bash
cd ~/devlix
./install.sh
```

> Don't forget to type your password when the installer prompts you to

When the installer asks you to choose a wallpaper, you can use the included wallpapers in our repository `~/devlix/wallpapers/[wallpaper]`.

replace `[wallpaper]` with the wallpaper you want to set.

see our [wallpapers in github](https://github.com/Mohamed1242012/devlix/tree/main/wallpapers).


## Manual Installation

### Install the needed packages and programs for building `dwm`, `dmenu`, `dwmblocks` and install the apps you need

```bash
sudo pacman -Syu --noconfirm alacritty xorg-server xorg-xinit xorg-xsetroot xorg-xrandr feh picom python-pywal neofetch lf ueberzug ffmpegthumbnailer imagemagick poppler base-devel git bat chafa unzip p7zip unrar catdoc docx2txt odt2txt gnumeric zsh go webkit2gtk libxft libxinerama libx11 ttf-jetbrains-mono-nerd alsa-utils scrot python3 networkmanager curl flameshot bluez-obex bluez bluez-utils blueman pulsemixer
```

List of packages needed and there uses:

- `alacritty`: The terminal emulator we will use
- `xorg-server`: For dwm to start with the `X Window System`
- `xorg-xinit`: For the `.xinitrc` file
- `xorg-xsetroot`: For setting the curser appearance and background color
- `xorg-xrandr`: For tweaking monitors (brightness , resolution etc.)
- `feh`: For the setting an image as a background
- `picom`: A compositor that adds transparency and some effects in opening and closing windows

?> `picom` also helps in reducing screen tearing

- `python-pywal`: Sets terminal color schemes based on an image
- `neofetch`: For displaying your system information in a nice way
- `lf`: A file manager that runs in the terminal
- `ueberzug`: Adds image support to lf
- `ffmpegthumbnailer`: A requirement for `lfimg`
- `imagemagick`: A requirement for `lfimg`
- `poppler`: A requirement for `lfimg`
- `base-devel`: For compiling the code
- `git`: For git cloning
- `bat`: like cat but with syntax highlighting and line numbers
- `chafa`: A requirement for `lfimg`
- `unzip`: For unzipping `.zip` files
- `p7zip`: For `.7z` files
- `unrar`: for `.rar` files
- `catdoc`: A requirement for `lfimg`
- `docx2txt`: A requirement for `lfimg`
- `odt2txt`: A requirement for `lfimg`
- `gnumeric`: A requirement for `lfimg`
- `zsh`: The shell we will use
- `vim`: A code editor that only pros use
- `go`: A programming language
- `webkit2gtk`: `dwm` wont compile without it
- `libxft`: `dwm` wont compile without it
- `libxinerama`: `dwm` wont compile without it
- `libx11`: `dwm` wont compile without it
- `ttf-jetbrains-mono-nerd`: For the symbols you will use in `dwm`
- `alsa-utils`: For controlling sound level
- `scrot`: For taking screenshots
- `python3`: For running python scripts
- `networkmanager`: For connecting to the internet
- `curl`: One of the ways to install `Oh My Zsh`
- `flameshot`: Another tool for taking screenshots
- `bluez-obex`: For bluetooth support
- `bluez`: For bluetooth support
- `bluez-utils`: For bluetooth support
- `blueman`: For bluetooth support
- `pulsemixer`: A tui tool for controlling sound


### Install `yay` (AUR helper)

?> You can skip this part if `yay` is already installed on your system

> The Arch User Repository (AUR) is a community-driven repository for Arch Linux users. It contains package descriptions (PKGBUILDs) that allow you to compile a package from source with makepkg and then install it via pacman. The AUR was created to organize and share new packages from the community and to help expedite popular packages' inclusion into the extra repository. This document explains how users can access and utilize the AUR.
> 
> \- [Arch wiki - aur](https://wiki.archlinux.org/title/Arch_User_Repository)

To make installing packages from the AUR easier we install an AUR helper.

There are 2 main AUR helpers
- [`yay`](https://github.com/Jguer/yay)
- [`paru`](https://github.com/Morganamilo/paru)

But in this guid I will use the most popular one `yay`

Use these commands to install and compile `yay`

```bash
git clone https://aur.archlinux.org/yay.git ~/yay
cd ~/yay
makepkg -si
sudo rm -rf ~/yay
```

### Install some packages from the AUR

```bash
yay -Syu --noconfirm epub-thumbnailer-git wkhtmltopdf-static 7-zip
```

This is a list a packages and there uses

- `epub-thumbnailer-git`: A requirement for `lfimg`
- `wkhtmltopdf-static`: A requirement for `lfimg`
- `7-zip`: For `.7z` files

### Clone Devlix repository in your Home directory

>What is Devlix
>Devlix is a window manager based on `dwm 6.5`, designed to provide a lightweight, efficient, and customizable environment for users who prefer minimalism and simplicity in their computing experience. Built with performance in mind, Devlix focuses on delivering a streamlined user interface that enhances productivity while utilizing minimal system resources. Unlike `dwm`, which often requires extensive configuration and patching, Devlix is ready to use out of the box, allowing users to quickly set up and start working without the need for extensive customization.
>
> \- [What is Devlix - Devlix Wiki 📚](../README.md#what-is-devlix)

```bash
git clone https://github.com/Mohamed1242012/devlix.git ~/devlix
```

### Copy `.config` directory to your system

Copy all files in `~/devlix/configs` to your `~/.config` file by using this command

```bash
cp -r ~/devlix/configs/* ~/.config
```

### Set the terminal color scheme and the background image using `Pywal`

> `Pywal` is a tool that generates a color palette from the dominant colors in an image. It then applies the colors system-wide and on-the-fly in all of your favorite programs.
>
> [`Pywal README.md` on GitHub](https://github.com/dylanaraps/pywal?tab=readme-ov-file)

We have added some good looking wallpapers in our repository in this directory `~/devlix/wallpapers/[img name]` but you can put also any other wallpaper in any directory.

?> See [wallpapers included on GitHub](https://github.com/Mohamed1242012/devlix/tree/main/wallpapers)

#### Use these commands to set the terminal color schemes

```bash
rm -rf ~/.cache/wal
wal -i [ img path ]
```

?> For more information about this tool (`pywal`) read their [wiki](https://github.com/dylanaraps/pywal/wiki)

Replace `[ img path ]` with you real image path.


#### Example

```bash
rm -r ~/.cache/wal
wal -i ~/devlix/wallpapers/wall2.png
```


### Export `pywal` colors to Alacritty

> Alacritty is a modern terminal emulator that comes with sensible defaults, but allows for extensive configuration. By integrating with other applications, rather than reimplementing their functionality, it manages to provide a flexible set of features with high performance. The supported platforms currently consist of BSD, Linux, macOS and Windows.
>
> \- [Alacritty official website](https://alacritty.org/)

?> For more information about Alacritty read their [documentation](https://github.com/alacritty/alacritty/blob/master/docs/features.md)

To export `pywal` generated colors to alacritty use `pywal2alacritty`

?> `pywal2alacritty` is an open source tool that exports the colors generated from `pywal` to Alacritty `.toml` file that has all the config, for more information about it read there [`README.md` file on GitHub](https://github.com/egeesin/pywal2alacritty?tab=readme-ov-file#pywal2alacritty)

Use these commands to export the colors

```bash
cd ~/devlix/alacritty-color-export
./script.sh
```

### Compile `dwm`, `dmenu`, `dwmblocks` and `lfimg`

Compile the code for these apps using these commands one by one

```bash
# Add your username
sed -i "s/mohamed/$(whoami)/g" ~/devlix/dwm/config.def.h ~/devlix/dmenu/config.def.h

# Compile dwm - Dynamic Window Manager
cd ~/devlix/dwm
sudo make clean install

# Compile dmenu
cd ~/devlix/dmenu
sudo make clean install

# Compile dwmblocks
cd ~/devlix/dwmblocks
sudo make clean install

# Compile lfimg
cd ~/devlix/lfimg
make install
```

### Put configuration files in there place

Copy these configuration files in the desired directories using these commands

```bash
cp ~/devlix/.zshrc ~/.zshrc
cp ~/devlix/.zprofile ~/.zprofile
cp ~/devlix/.xinitrc ~/.xinitrc
cp ~/devlix/.p10k.zsh ~/.p10k.zsh
```

#### References
(Coming Soon)

### Set zsh as the default shell

> The Z shell (Zsh) is a Unix shell that can be used as an interactive login shell and as a command interpreter for shell scripting. Zsh is an extended Bourne shell with many improvements, including some features of Bash, ksh, and tcsh.
> 
> [Z shell - Wikipedia](https://en.wikipedia.org/wiki/Z_shell)

```bash
chsh -s /usr/bin/zsh
```

?>_Tip:_ `chsh` stands for Change Shell

### Install `Oh My Zsh` and set it as the default shell

> Oh My Zsh is a delightful, open source, community-driven framework for managing your Zsh configuration. It comes bundled with thousands of helpful functions, helpers, plugins, themes, and a few things that make you shout...
> 
> \- [Oh My Zsh Official Website](https://ohmyz.sh)

Use this command to install `Oh My Zsh` and set it as the default shell.

```bash
# Install Oh My Zsh using curl
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
```

?> For more information read the official [Oh My Zsh documentation](https://github.com/ohmyzsh/ohmyzsh/wiki)

### Install some useful `zsh` plugins

These plugins add some functionality to zsh and make it more efficient and easier to use, an example of this are these plugins.

- `zsh-autosuggestions`
    - This gives auto suggestions for the past commands you wrote and increases speed so you don't type any command again and again
    - For more information about `zsh-autosuggestions` read it's [`README.md` file on GitHub](https://github.com/zsh-users/zsh-autosuggestions)
- `zsh-syntax-highlighting`
    - This gives you syntax highlighting in the commands you type
    - For more information about `zsh-syntax-highlighting` read it's [`README.md` file on GitHub](https://github.com/zsh-users/zsh-syntax-highlighting)

To install them enter these commands in your terminal

!> You should enter `zsh` before installing these plugins for them to be installed in the right directory

?> It's OK to see some errors when you enter zsh and they will be fixed once you install the [plugins](#install-some-useful-zsh-plugins) and the [`PowerLevel10k` theme](#install-powerlevel10k-theme-on-zsh)

```bash
# If you miss this command the plugins will not be installed in there right directory
zsh

# zsh-autosuggestions - https://github.com/zsh-users/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions

# zsh-syntax-highlighting - https://github.com/zsh-users/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
```

<!-- zsh -i -c 'echo $ZSH_VERSION' -->


### Install `Powerlevel10k` theme on `zsh`

> Powerlevel10k is a theme for Zsh. It emphasizes speed, flexibility and out-of-the-box experience.
>
> \- [Powerlevel10k README.md on GitHub](https://github.com/romkatv/powerlevel10k)

`Powerlevel10k` lets you customize the terminal to do somethings like this

![powerlevel10k](../pictures/powerlevel10k.png)

To install `Powerlevel10k` run this command

```bash
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
```

### Congrats 🎉

Now Logout and Login and you should be greeted with Devlix WM !

![screenshot](../screenshots/scrot2.png ':size=700')