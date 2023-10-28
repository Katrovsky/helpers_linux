#!/bin/bash

install_ruby_fedora() {
    echo "Установка Ruby для Linux (Fedora)"
    sudo dnf install ruby ruby-devel openssl-devel redhat-rpm-config gcc-c++ @development-tools
}

install_ruby_debian() {
    echo "Установка Ruby для Linux (Debian/Ubuntu)"
    sudo apt-get update
    sudo apt-get install -y ruby-full build-essential
}

install_ruby_opensuse() {
    echo "Установка Ruby для Linux (OpenSUSE)"
    sudo zypper install -y -t pattern devel_ruby devel_C_C++
    sudo zypper install -y ruby-devel
}

install_ruby_arch() {
    echo "Установка Ruby для Linux (Arch Linux)"
    sudo pacman -Syu --needed --noconfirm ruby base-devel
}

install_ruby_clear() {
    echo "Установка Ruby для Linux (Clear Linux)"
    sudo swupd update
    sudo swupd bundle-add-y ruby-basic
}

configure_ruby_gems_bash() {
    echo '# Установка Ruby Gems в ~/.gems' >> ~/.bashrc
    echo 'export GEM_HOME="$HOME/.gems"' >> ~/.bashrc
    echo 'export PATH="$HOME/.gems/bin:$PATH"' >> ~/.bashrc
    source ~/.bashrc
}

configure_ruby_gems_fish() {
    echo '# Установка Ruby Gems в ~/.gems' >> ~/.config/fish/config.fish
    echo 'set -x GEM_HOME "$HOME/.gems"' >> ~/.config/fish/config.fish
    echo 'set -x PATH "$HOME/.gems/bin" $PATH' >> ~/.config/fish/config.fish
    source ~/.config/fish/config.fish
}

configure_ruby_gems_zsh() {
    echo '# Установка Ruby Gems в ~/.gems' >> ~/.zshrc
    echo 'export GEM_HOME="$HOME/.gems"' >> ~/.zshrc
    echo 'export PATH="$HOME/.gems/bin:$PATH"' >> ~/.zshrc
    source ~/.zshrc
}

install_jekyll_bundler() {
    gem install jekyll bundler
}

# Определение операционной системы
os=$(lsb_release -a | awk -F': ' '/Distributor ID/{print $2}')

# Установка Ruby для Linux
declare -A os_install_functions=(
    ["Fedora"]="install_ruby_fedora"
    ["Debian"]="install_ruby_debian"
    ["Ubuntu"]="install_ruby_debian"
    ["openSUSE"]="install_ruby_opensuse"
    ["Arch Linux"]="install_ruby_arch"
    ["Clear Linux"]="install_ruby_clear"
)

if [[ -n "${os_install_functions[$os]}" ]]; then
    ${os_install_functions[$os]}
fi

# Определение используемой оболочки
shell=$(basename "$SHELL")

# Настройка Ruby Gems для выбранной оболочки
declare -A shell_configure_functions=(
    ["bash"]="configure_ruby_gems_bash"
    ["fish"]="configure_ruby_gems_fish"
    ["zsh"]="configure_ruby_gems_zsh"
)

if [[ -n "${shell_configure_functions[$shell]}" ]]; then
    ${shell_configure_functions[$shell]}
fi

# Установка Jekyll и Bundler
install_jekyll_bundler

echo "Ruby, Jekyll и Bundler установлены."