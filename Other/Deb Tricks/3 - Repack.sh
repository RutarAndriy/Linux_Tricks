#!/bin/bash

# Назва готової програми
APP_NAME="helloFromDeb"

# Переходимо в робочу директорію
cd ~/"$APP_NAME"

# Збираємо deb-пакет
dpkg-deb --build ./Unpacked_App $APP_NAME"_repack.deb"

# Видаляємо використані ресурси
rm -r ./Unpacked_App

