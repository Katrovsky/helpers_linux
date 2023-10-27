#!/bin/bash

# Укажите относительный путь к папке репозитория Jekyll, не добавляйте другие символы.
RELATIVE_REPOSITORY_PATH="only_repo_name"

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

# Запустите Jekyll для генерации сайта
bundle exec jekyll serve