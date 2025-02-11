#!/bin/bash

# Переходимо у домашній каталог користувача
cd ~

# Скачуємо останній реліз
wget https://api.github.com/repos/Winetricks/winetricks/releases/latest -O - | \
awk -F \" -v RS="," '/tarball_url/ {print $(NF-1)}' | \
xargs wget -nv -O winetricks.tar.gz

# Створюємо типчасову директорію
mkdir temp 

# Розпаковуємо архів із репозиторієм
tar -xf winetricks.tar.gz -C temp --strip-components=1

# Переходимо у типчасову директорію
cd temp

# Збираємо виконуваний файл
sudo make install

# Переходимо у домашній каталог користувача
cd ~

# Видаляємо непотрібні файли
rm -r temp && rm winetricks.tar.gz

