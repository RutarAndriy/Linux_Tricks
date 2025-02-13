#!/bin/bash

# Функція повертає список wine-префіксів
function get_bottles_list {

# Переходимо в домашню директорію
cd ~
# Записуємо шлях домашньої директорії
local USER=$(pwd)
# Зберігаємо розділювач файлів
local IFS_ORIG=$IFS
# Змінюємо розділювач файлів
IFS=$'\n'

# Проходимося циклом по основних wine-директоріях
for DIR in $USER "$USER/.local/share/wineprefixes" "$USER/.photoshopCCV19"; do
    
    # Задаємо директорію якщо вона існує
    [ -e $DIR ] && cd "$DIR" || continue
    
    # Записуємо шлях директорії
    local CUR_DIR=$(pwd)

    # Проходимося по всіх файлах у директорії
    for FILE in $(ls -a); do

        # Перевіряємо наявність wine-префіксів
        [ -e "$CUR_DIR/$FILE/dosdevices" ] || continue

        # Виводимо результат
        echo "$CUR_DIR/$FILE"

    done
done

# Відновлюємо розділювач файлів
IFS=$IFS_ORIG

}
