#!/bin/bash

# Переходимо у директорію .config
cd ~/.config

# Обробляємо файл
sed -i '/x-content\/image-dcf=pix-import.desktop;/d' mimeapps.list
