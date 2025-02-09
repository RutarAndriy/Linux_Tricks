#!/bin/bash

# Шлях до програми
APP_PATH=/mnt/disk_d/5_Programs/2_Windows/Developer_Utils/Notepad++

# Отримуємо шлях виконання скрипта
SCRIPT_FILE=$(readlink -f -- "${0}")
SCRIPT_DIR=${SCRIPT_FILE%/*}

# Інсталюємо необхідні утиліти
sudo apt-get install xdg-utils inkscape

# Функція для створення іконок різних розмірів
function generate_icons() {

    src=$1

    for size in 16 32 48 64 128 256 512 1024
    do
        output=${1%.*}.png
        inkscape -o $output -w $size -h $size $src 2>/dev/null
        xdg-icon-resource install --novendor --size $size $output
        echo "Додано іконку ~/.local/share/icons/hicolor/${size}x${size}/apps/${output}"
        rm $output
    done
}

# Переходимо у папку з іконками
cd "$SCRIPT_DIR/Resources"

# Обробляємо іконки
for file in *.svg; do
    echo -e "\nГенерування іконок для файлу $file\n"
    generate_icons "$file"
done
