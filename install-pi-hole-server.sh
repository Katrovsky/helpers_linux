#!/bin/bash

set -e

# Проверка наличия установленного yay
if ! command -v yay &> /dev/null; then
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si --noconfirm
	cd ..
	rm -rf yay
fi

# Установка pi-hole-server с использованием yay
if ! yay -Q pi-hole-server &> /dev/null; then
	yay -S --noconfirm pi-hole-server
fi

# Установка необходимых пакетов
sudo pacman -S --noconfirm php-sqlite lighttpd php-cgi

# Копирование конфигурационного файла lighttpd
sudo cp /usr/share/pihole/configs/lighttpd.example.conf /etc/lighttpd/lighttpd.conf

# Включение и перезапуск службы lighttpd
sudo systemctl enable --now lighttpd.service

# Ввод пароля для защиты веб-интерфейса Pi-Hole
sudo pihole -a -p

# Изменение настроек Pi-hole для использования Cloudflare в качестве DNS-серверов
sudo sed -i 's/PIHOLE_DNS_1=8.8.8.8/PIHOLE_DNS_1=1.1.1.1/g' /etc/pihole/setupVars.conf
sudo sed -i 's/PIHOLE_DNS_2=8.8.4.4/PIHOLE_DNS_2=1.0.0.1/g' /etc/pihole/setupVars.conf

# Запуск службы Pi-hole
sudo systemctl enable --now pihole-FTL.service

# Запуск таймера pi-hole-gravity.timer
sudo systemctl start pi-hole-gravity.timer

echo "Установка Pi-hole и настройка компонентов завершена"

read -rp "Хотите открыть админ-панель Pi-Hole? (Y/n): " choice
case "$choice" in
	[Yy]*) xdg-open "http://localhost/admin" ;;
	[Nn]*) ;;
	*) ;;
esac