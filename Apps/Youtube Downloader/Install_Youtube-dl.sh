#!/bin/bash

# Переходимо у домашній каталог користувача
cd ~

# Скачуємо репозиторій із програмою 
wget -nv -O youtube-dl.zip \
https://github.com/ytdl-org/youtube-dl/archive/refs/heads/master.zip

# Розпаковуємо архів із репозиторієм
unzip youtube-dl.zip

# Переходимо у розархівовану папку
cd youtube-dl-master

# Збираємо програму
make youtube-dl

# Переміщуємо зібрану програму у системний каталог
sudo mv youtube-dl /usr/local/bin

# Переходимо у домашній каталог користувача
cd ~

# Видаляємо непотрібні файли
rm -r youtube-dl-master && rm youtube-dl.zip

# Встановлюємо необхідні додаткові компоненти
sudo apt install python-is-python3 -y

