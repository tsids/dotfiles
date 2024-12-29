#!/usr/bin/env bash
#
# install from scratch.

DOTFILES_ROOT=$(pwd -P)

set -e

echo ''

info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

setup_gitconfig () {
  info 'setup gitconfig'

  git_credential='cache'
  if [ "$(uname -s)" == "Darwin" ]
  then
    git_credential='osxkeychain'
  fi

  user ' - What is your github author name?'
  read -e git_authorname
  user ' - What is your github author email?'
  read -e git_authoremail

  gitconfig --global user.name "$git_authorname"
  gitconfig --global user.email "$git_authoremail"
  gitconfig --global credential.helper "$git_credential --timeout=86400000"

  success 'gitconfig'
}


link_file () {
  local src=$1 dst=$2

  local overwrite= backup= skip=
  local action=

  if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
  then

    if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]
    then

      local currentSrc="$(readlink $dst)"

      if [ "$currentSrc" == "$src" ]
      then

        skip=true;

      else

        user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac

      fi

    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]
    then
      rm -rf "$dst"
      success "removed $dst"
    fi

    if [ "$backup" == "true" ]
    then
      mv "$dst" "${dst}.backup"
      success "moved $dst to ${dst}.backup"
    fi

    if [ "$skip" == "true" ]
    then
      success "skipped $src"
    fi
  fi

  if [ "$skip" != "true" ]  # "false" or empty
  then
    ln -s "$1" "$2"
    success "linked $1 to $2"
  fi
}

install_dotfiles () {
  info 'installing dotfiles'

  local overwrite_all=false backup_all=false skip_all=false

  for src in $(find -H "$DOTFILES_ROOT" -maxdepth 2 -name '*.symlink' -not -path '*.git*')
  do
    dst="$HOME/.$(basename "${src%.*}")"
    link_file "$src" "$dst"
  done
}

# setup_gitconfig
# install_dotfiles

# Install yay
cd ~/Downloads
sudo pacman -S --needed --noconfirm git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm

# Github
sudo pacman -S git
user ' - What is your github author name?'
read -e git_authorname
user ' - What is your github author email?'
read -e git_authoremail
git config --global user.name "$git_authorname"
git config --global user.email "$git_authoremail"
git config --global credential.helper "cache --timeout=86400000"

## Dotfiles
cd ~
git clone https://github.com/tsids/dotfiles

# ZSH
sudo pacman -S zsh
chsh -s $(which zsh)
zsh
echo "====== Follow the prompts to install oh-my-zsh ======"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

## Touchegg touch gestures
# sudo pacman -S touchegg
# sudo systemctl enable touchegg.service --now
# yay -S touche
# mkdir -p ~/.config/touchegg
# ln -s ~/dotfiles/touchegg/touchegg.conf ~/.config/touchegg/touchegg.conf

## Fusuma touch gestures
# Add USER to input group
newgrp input
sudo gpasswd -a $USER input

# Install Fusuma
sudo pacman -Syu libinput
sudo pacman -Syu ruby
gem install fusuma # non root install
sudo pacman -Syu xdotool
#
 Link the config file
mkdir -p ~/.config/fusuma
ln -s ~/dotfiles/fusuma/config.yml ~/.config/fusuma/config.yml

# Add these lines to `~/.bashrc` or `~/.zshrc` to add ruby gems to path
echo '# Ruby Gems
export GEM_HOME="$(gem env user_gemhome)"
export PATH="$PATH:$GEM_HOME/bin"' >> ~/.zshrc

### Firefox touch gestures
sudo echo "MOZ_USE_XINPUT2 DEFAULT=1" >> /etc/security/pam_env.conf

# Discord
pacman -S discord
sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"

# Flameshot
sudo pacman -S flameshot
ln -s ~/dotfiles/flameshot/ ~/.config/

# Tesseract
yay tesseract
yay tesseract-data-eng
yay tesseract-data-ara
sudo pacman -S xclip imagemagick

# Binaries
mkdir -p ~/bin
ln -s ~/dotfiles/bin/* ~/bin/

echo "Reboot the system"
read -p "Do you want to reboot now? [y/N] " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    sudo reboot
fi
echo "Reboot the system to apply changes"