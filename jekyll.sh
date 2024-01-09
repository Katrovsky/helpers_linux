#!/bin/bash

install_ruby_arch() {
    echo "Установка Ruby для Linux (Arch Linux)"
    sudo pacman -Syu --needed --noconfirm ruby base-devel rubygems
}

configure_ruby_gems_bash() {
    if ! grep -q 'Установка Ruby Gems в ~/.gems' ~/.bashrc; then
        cat << 'EOF' >> ~/.bashrc
# Установка Ruby Gems в ~/.gems
if [[ ":$PATH:" != *":$HOME/.gems/bin:"* ]]; then
    export GEM_HOME="$HOME/.gems"
    export PATH="$HOME/.gems/bin:$PATH"
fi
EOF
    fi
    source ~/.bashrc
}

configure_ruby_gems_fish() {
    if ! grep -q 'Установка Ruby Gems в ~/.gems' ~/.config/fish/config.fish; then
        cat << 'EOF' >> ~/.config/fish/config.fish
# Установка Ruby Gems в ~/.gems
if not contains $PATH $HOME/.gems/bin
    set -x GEM_HOME "$HOME/.gems"
    set -x PATH "$HOME/.gems/bin" $PATH
end
EOF
    fi
    source ~/.config/fish/config.fish
}

configure_ruby_gems_zsh() {
    if ! grep -q 'Установка Ruby Gems в ~/.gems' ~/.zshrc; then
        cat << 'EOF' >> ~/.zshrc
# Установка Ruby Gems в ~/.gems
if [[ ":$PATH:" != *":$HOME/.gems/bin:"* ]]; then
    export GEM_HOME="$HOME/.gems"
    export PATH="$HOME/.gems/bin:$PATH"
fi
EOF
    fi
    source ~/.zshrc
}

install_jekyll_bundler() {
    gem install jekyll bundler
}

# Проверка используемой оболочки
shell=$(basename "$SHELL")

# Установка Ruby для Arch Linux
install_ruby_arch

# Настройка Ruby Gems для соответствующей оболочки
if [[ "$shell" == "bash" ]]; then
    configure_ruby_gems_bash
elif [[ "$shell" == "fish" ]]; then
    configure_ruby_gems_fish
elif [[ "$shell" == "zsh" ]]; then
    configure_ruby_gems_zsh
else
    echo "Не удалось определить используемую оболочку"
    exit 1
fi

# Установка Jekyll и Bundler
install_jekyll_bundler

echo "Ruby, Jekyll и Bundler установлены."
