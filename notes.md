# Setup
Distro: Arch Linux \
Desktop: KDE Plasma \
Protocol: X11

## Zsh
https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH
```sh
sudo pacman -S zsh
chsh -s $(which zsh)
```

### Oh My Zsh
```sh
zsh
echo "Follow the prompts"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

#### Plugins
Copy the plugins/configs from [.zshrc](zsh/.zshrc) to your `.zshrc`.
Add the following for `zsh-autosuggestions` and `zsh-syntax-highlighting`:
- https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md
```sh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```
- https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
```sh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

## ~~Touch gestures (touchegg)~~
- https://a2nb.medium.com/add-custom-touch-gesture-in-kde-the-one-minute-setup-13d9a922b00f

```sh
sudo pacman -S touchegg
sudo systemctl enable touchegg.service --now
reboot
```
```sh
yay -S touche
```
Then, just set up the gestures as you like

## Nevermind, fusuma is better
- follow instructions here: https://github.com/iberianpig/fusuma
- add this to alt tab freely: https://github.com/iberianpig/fusuma/wiki/3-fingers-Alt-Tab-Switcher(Windows-Style)
- use [https://github.com/iberianpig/fusuma-plugin-sendkey](https://github.com/iberianpig/fusuma-plugin-sendkey) to send key events (maximize window, etc)

Add USER to input group
```sh
newgrp input
sudo gpasswd -a $USER input
```
Install Fusuma
```sh
sudo pacman -Syu libinput
sudo pacman -Syu ruby
gem install fusuma # non root install
sudo pacman -Syu xdotool
```
Link the config file
```sh
mkdir -p ~/.config/fusuma
ln -s ~/dotfiles/fusuma/config.yml ~/.config/fusuma/config.yml
```
Add these lines to `~/.bashrc` or `~/.zshrc` to add ruby gems to path
```sh
# Ruby Gems
export GEM_HOME="$(gem env user_gemhome)"
export PATH="$PATH:$GEM_HOME/bin"
```

To start fusuma on startup, add this to `~/.config/autostart/fusuma.sh` or however auto start works in your desktop environment
[scripts/fusuma.sh](scripts/fusuma.sh)
```sh
#!/bin/bash
GEM_HOME=$(gem env user_gemhome)
$GEM_HOME/bin/fusuma
```

### Firefox gestures
https://askubuntu.com/questions/853910/how-to-enable-touchscreen-scrolling-in-firefox
- edit `/etc/security/pam_env.conf` and add `MOZ_USE_XINPUT2 DEFAULT=1`
```sh
sudo echo "MOZ_USE_XINPUT2 DEFAULT=1" >> /etc/security/pam_env.conf
```
reboot and restart firefox

## Discord
- install discord, then use vencord to setup plugins, use the cloud sync to restore settings
```sh
pacman -S discord
sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"
```

## Tesseract for OCR
```sh
yay tesseract
```
[tesseract_ocr_eng.sh](tesseract/ocr_eng.sh)
[tesseract_ocr_ara.sh](tesseract/ocr_ara.sh)
