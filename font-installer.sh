#!/bin/bash

sudo -v
mkdir -p /usr/share/fonts/windows-fonts
git clone --depth 1 https://github.com/Katrovsky/archlinux-win11-fonts /usr/share/fonts/windows-fonts

# Обновляем кэш шрифтов
fc-cache --force

# Устанавливаем шрифты Windows 11
echo "Шрифты Windows 11 успешно установлены."