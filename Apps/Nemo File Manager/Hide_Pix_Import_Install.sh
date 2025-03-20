#!/bin/bash

# Переходимо у директорію .config
cd ~/.config

# Перевіряємо наявність рядка "[Removed Associations]"
if grep -Fxq "[Removed Associations]" mimeapps.list
then
    # Рядок знайдено
    sed -i '/\[Removed Associations\]/ a x-content/image-dcf=pix-import.desktop;' mimeapps.list
else
    # Рядок не знайдено
    echo -e "\n[Removed Associations]\nx-content/image-dcf=pix-import.desktop;" >> mimeapps.list
fi



