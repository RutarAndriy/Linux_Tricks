#!/bin/bash

# Шлях до програми
APP_PATH=/mnt/disk_d/5_Programs/2_Windows/Developer_Utils/Notepad++

# Отримуємо шлях виконання скрипта
SCRIPT_FILE=$(readlink -f -- "${0}")
SCRIPT_DIR=${SCRIPT_FILE%/*}

# Переходимо у папку скриптів
cd ~/.local/share/nemo/actions

# Записуємо файл скрипта
echo "[Nemo Action]
# Відкривання файлів у Notepad++
Name=Відкрити у Notepad++
Comment=Відкрити файл у Notepad++
Exec=wine \"$APP_PATH/notepad++.exe\" \"%P\"/\"%N\"
Icon-Name=notepad++
Selection=s
Extensions=nodirs;
EscapeSpaces=false
Terminal=false" > open_in_notepad++.nemo_action

# Інсталюємо необхідні утиліти
sudo apt-get install xdg-utils

# Переходимо у папку з іконками
cd "$SCRIPT_DIR/resources"

# Додаємо іконки
for size in 16 32 48 64 128 256
do
xdg-icon-resource install --novendor --size $size $size"x"$size.png notepad++
done
