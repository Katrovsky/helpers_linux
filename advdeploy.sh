#!/bin/bash

# Получите имя локального репозитория из аргумента командной строки
REPOSITORY_NAME=$1

# Укажите относительный путь к папке репозитория Jekyll
RELATIVE_REPOSITORY_PATH="$REPOSITORY_NAME"

# Получите абсолютный путь к папке репозитория
ABSOLUTE_REPOSITORY_PATH="$(pwd)/$RELATIVE_REPOSITORY_PATH"

# Проверьте наличие папки репозитория
if [ ! -d "$ABSOLUTE_REPOSITORY_PATH" ]; then
  # Создайте репозиторий Jekyll, если он отсутствует
  jekyll new "$ABSOLUTE_REPOSITORY_PATH"
fi

# Перейдите в папку репозитория
cd "$ABSOLUTE_REPOSITORY_PATH"

# Удалите строку с gem "jekyll"
sed -i '/gem "jekyll"/d' Gemfile

# Расскомментируйте строку # gem "github-pages", group: :jekyll_plugins
sed -i 's/# gem "github-pages", group: :jekyll_plugins/gem "github-pages", group: :jekyll_plugins/' Gemfile

# Добавьте в группу group :jekyll_plugins gem 'jekyll-admin' и gem 'webrick'
echo "gem 'jekyll-admin', group: :jekyll_plugins" >> Gemfile
echo "gem 'webrick'" >> Gemfile

# Установите Jekyll и зависимости
bundle install

# Спросите у пользователя, хочет ли он запустить Jekyll перед запуском jekyll serve
read -p "Do you want to run Jekyll now? (Y/n): " runJekyll

if [[ $runJekyll == "n" || $runJekyll == "N" ]]; then
  echo "Jekyll will not be run."
else
  # Запустите Jekyll для генерации сайта
  bundle exec jekyll serve
fi