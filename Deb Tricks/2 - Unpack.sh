#!/bin/bash

# Назва готової програми
APP_NAME="helloFromDeb"

# Створюємо робочу директорію і переходимо в неї
cd ~ && mkdir -p "$APP_NAME/Unpacked_App" && cd "$APP_NAME"

# Розпаковуємо deb-пакет
dpkg-deb --raw-extract ./"$APP_NAME.deb" ./Unpacked_App

