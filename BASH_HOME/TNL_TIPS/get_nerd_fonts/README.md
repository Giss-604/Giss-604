Source Code Pro
https://adobe-fonts.github.io/source-code-pro/
https://github.com/adobe-fonts/source-code-pro
dnf install adobe-source-code-pro-fonts
dnf install mozilla-fira-mono-fonts
dnf install google-droid-sans-mono-fonts
dnf install dejavu-sans-mono-fonts

Hack
A typeface designed for source code
Hack is designed to be a workhorse typeface for source code:
https://github.com/source-foundry/Hack?tab=readme-ov-file
Linux
Download the latest version of Hack.
Extract the files from the archive (.zip).
Copy the font files to either your system font folder (often /usr/share/fonts/) or user font folder (often ~/.local/share/fonts/ or /usr/local/share/fonts).
Copy the font configuration file in config/fontconfig/ to either the system font configuration folder (often /etc/fonts/conf.d/) or the font user folder (often ~/.config/fontconfig/conf.d)
Clear and regenerate your font cache and indexes with the following command:
$ fc-cache -f -v
You can confirm that the fonts are installed with the following command:

$ fc-list | grep "Hack"

---------------------------------------------------
desktop’s default font on Fedora 39 is perfect (Noto fonts are now 
the default for languages using the Indic script). 
But if you crave more, here are some of the cool fonts you can install. 

dnf install -y 'google-roboto*' 'mozilla-fira*' fira-code-fonts


# getNF

## A better way to install NerdFonts

### Dependencies

- curl
- unzip
- fontconfig

### Installation

```
git clone https://github.com/ronniedroid/getnf.git
cd getnf
./install.sh
```

Make sure that `~/.local/bin` is in your PATH

### Usage

run `getnf -h` to get a help message.

- run `getnf` from the terminal and it will represent you with a list of Nerd Fonts,
- choose one font at a time from the list.
- Type `i` to install the selected fonts or `q` to  cancel.

By default the downloaded zip files are removed,
use the `-k` flag to keep the zip files in the downloads directory.

By default, the already installed fonts are not listed in the select menu,
unless there is a new version of Nerd Fonts.
You can force reinstalling a font by using the `-f` flag.

Enjoy!
