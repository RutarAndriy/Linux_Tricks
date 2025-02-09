#!/bin/bash

# Шлях до програми
APP_PATH=/mnt/disk_d/5_Programs/2_Windows/Developer_Utils/Notepad++

# Отримуємо шлях виконання скрипта
SCRIPT_FILE=$(readlink -f -- "${0}")
SCRIPT_DIR=${SCRIPT_FILE%/*}

# Функція для видалення іконок
function delete_icons() {

    name=${1%.*}

    for size in 16 32 48 64 128 256 512 1024; do
        xdg-icon-resource uninstall --size $size $name
    done
}

# Переходимо у папку з іконками
cd "$SCRIPT_DIR/Resources"

# Обробляємо іконки
for file in *.svg; do
    echo Видалення іконок для файлу "$file"
    delete_icons "$file"
done

