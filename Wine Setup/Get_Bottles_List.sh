#!/bin/bash

# Функція повертає список wine-префіксів
function get_bottles_list {

# Переходимо в домашню директорію
cd ~
# Зберігаємо розділювач файлів
IFS_ORIG=$IFS
# Змінюємо розділювач файлів
IFS=$'\n'
# Записуємо шлях домашньої директорії
USER=$(pwd)

# Проходимося циклом по основних wine-директоріях
for DIR in $USER "$USER/.local/share/wineprefixes" "$USER/.photoshopCCV19"; do
    
    # Задаємо директорію
    cd "$DIR"
    # Записуємо шлях директорії
    CUR_DIR=$(pwd)

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

# Тестування функції
for bottle in $(get_bottles_list); do
    echo $bottle
done