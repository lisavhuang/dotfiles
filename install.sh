#!/bin/bash

function install_zsh() {
    # Install shell if it doesn't yet exist.
    if ! command -v zsh > /dev/null; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    fi

    # Install oh-my-zsh if it doesn't yet exist.
    if ! test -d "$HOME/.oh-my-zsh"; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi

    # Install zplug if it doesn't yet exist.
    git clone https://github.com/zplug/zplug $HOME/.zplug

    # Link zsh config and theme.
    ln -sf $HOME/.dotfiles/zsh/.zshrc $HOME/.zshrc
    ln -sf $HOME/.dotfiles/zsh/milktea.zsh-theme $HOME/.oh-my-zsh/themes/milktea.zsh-theme
}

# Brew install formula
function brew_install() {
    echo "Installing ${1}."
    if brew list $1 &>/dev/null; then
        echo "${1} already installed."
    else
        brew install $1 && echo "${1} is installed."
    fi
}

function install_plain_nvim() {
    brew_install "nvim"
    # Link configuration.
    rm -rf "$HOME/.config/nvim"
    ln -sf "$HOME/.dotfiles/nvim" "$HOME/.config/nvim"

    # Install plugins.
    nvim +PlugInstall +qall
}

function install_yabai() {
    # Link configuration.
    ln -sf "$HOME/.dotfiles/yabai/.skhdrc" "$HOME/.skhdrc"
    ln -sf "$HOME/.dotfiles/yabai/.yabairc" "$HOME/.yabairc"
}

function install_tmux() {
    brew_install "tmux"
    # Link tmux configuration.
    ln -sf "$HOME/.dotfiles/tmux/.tmux.conf" "$HOME/.tmux.conf"
    ln -sf "$HOME/.dotfiles/tmux/.tmux.conf.local" "$HOME/.tmux.conf.local"
}

function install_astronvim(){
    # Install neovim
    brew_install "nvim"
    # Install NerdFont
    brew tap homebrew/cask-fonts && brew install --cask font-hasklug-nerd-font
    # clone AstroNvim
    if [ -d "$HOME/.config/nvim" ]; then
        mv "$HOME/.config/nvim" "$HOME/.config/nvim.old"
    fi
    git clone https://github.com/AstroNvim/AstroNvim "$HOME/.config/nvim"
    # Link astronvim configuration.
    mkdir "$HOME/.config/nvim/lua/user"
    ln -sf "$HOME/.dotfiles/astronvim/init.lua" "$HOME/.config/nvim/lua/user/init.lua"
    nvim +PackerSync
}

function install_alacritty() {
    brew_install "alacritty"
    # Link alacritty configuration.
    ln -sf "$HOME/.dotfiles/alacritty" "$HOME/.config/."
}
if [[ $# -lt 1 ]]; then
    echo "usage: $0 --[all, zsh, plain_nvim, tmux, astronvim, yabai, alacritty]"
    echo "--all = zsh, tmux, astronvim, alacritty"
fi

zsh=false
plain_nvim=false
yabai=false
tmux=false
astronvim=false
alacritty=false

for i in "$@"; do
    case $i in
        -z|--zsh)
            zsh=true
            ;;
        -n|--plain_nvim)
            nvim=true
            ;;
        -y|--yabai)
            yabai=true
            ;;
        -t|--tmux)
            tmux=true
            ;;
        --astronvim)
            astronvim=true
            ;;
        --alacritty)
            alacritty=true
            ;;
        -a|--all)
            zsh=true
            tmux=true
            astronvim=true
            alacritty=true
            ;;
    esac
done

if $zsh; then
    install_zsh
    echo "Installed zsh (remember to restart for changes)."
fi

if $nvim; then
    install_plain_nvim
fi

if $yabai; then
    install_yabai
fi

if $tmux; then
    install_tmux
fi
if $astronvim; then
    install_astronvim
fi
if $alacritty; then
    install_alacritty
fi
