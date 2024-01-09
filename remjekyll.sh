#!/bin/bash

uninstall_ruby_arch() {
    echo "Удаление Ruby для Linux (Arch Linux)"
    sudo pacman -Rns --noconfirm ruby base-devel rubygems
}

remove_ruby_gems_bash() {
    echo "Удаление настроек Ruby Gems из ~/.bashrc"
    sed -i '/Установка Ruby Gems в ~\/.gems/d' ~/.bashrc
    sed -i '/export GEM_HOME="$HOME\/.gems"/d' ~/.bashrc
    sed -i '/export PATH="$HOME\/.gems\/bin:$PATH"/d' ~/.bashrc
}

remove_ruby_gems_fish() {
    echo "Удаление настроек Ruby Gems из ~/.config/fish/config.fish"
    sed -i '/Установка Ruby Gems в ~\/.gems/d' ~/.config/fish/config.fish
    sed -i '/set -x GEM_HOME "$HOME\/.gems"/d' ~/.config/fish/config.fish
    sed -i '/set -x PATH "$HOME\/.gems\/bin" $PATH/d' ~/.config/fish/config.fish
}

remove_ruby_gems_zsh() {
    echo "Удаление настроек Ruby Gems из ~/.zshrc"
    sed -i '/Установка Ruby Gems в ~\/.gems/d' ~/.zshrc
    sed -i '/export GEM_HOME="$HOME\/.gems"/d' ~/.zshrc
    sed -i '/export PATH="$HOME\/.gems\/bin:$PATH"/d' ~/.zshrc
}

uninstall_jekyll_bundler() {
    echo "Удаление Jekyll и Bundler"
    gem uninstall -aIx jekyll bundler
}

# Проверка используемой оболочки
shell=$(basename "$SHELL")

# Удаление Jekyll и Bundler
uninstall_jekyll_bundler

# Откат настроек Ruby Gems для соответствующей оболочки
if [[ "$shell" == "bash" ]]; then
    remove_ruby_gems_bash
elif [[ "$shell" == "fish" ]]; then
    remove_ruby_gems_fish
elif [[ "$shell" == "zsh" ]]; then
    remove_ruby_gems_zsh
else
    echo "Не удалось определить используемую оболочку"
    exit 1
fi

# Удаление Ruby для Arch Linux
uninstall_ruby_arch

echo "Откат изменений завершен."
