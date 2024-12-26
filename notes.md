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
Copy the plugins/configs from [zsh/.zshrc](zsh/.zshrc) to your `.zshrc`.
Add the following for `zsh-autosuggestions` and `zsh-syntax-highlighting`:
- https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md
```sh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```
- https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
```sh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

## Touch gestures
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
