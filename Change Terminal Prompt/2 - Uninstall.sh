#!/bin/bash

# Отримуємо шлях виконання скрипта
SCRIPT_DIR="$(dirname "$(readlink -f -- "${0}")")"

# Переходимо у дану директорію
cd "$SCRIPT_DIR"

# Ініціалізуємо необхідні змінні
TS=$(head -n 2 Template.sh | tail -n 1)
TE=$(tail -n 1 Template.sh)

# Отримуємо кількість рядків у файлі .bashrc
LINES=$(wc -l ~/.bashrc | cut -d ' ' -f1)

# Шукаємо ідентичні рядки
for ((Z = 1; Z <= $LINES; Z++)); do
    LINE=$(sed "${Z}q;d" ~/.bashrc)
    [ "$LINE" = "${TS}" ] && SI=$Z
    [ "$LINE" = "${TE}" ] && EI=$((Z+1))
    [ -n "${SI}" ] && [ -n "${EI}" ] && break
done

# Видаляємо рядки зі скриптом
[ -n "${SI}" ] && [ -n "${EI}" ] && sed -i -e "${SI},${EI}d" ~/.bashrc

# Видаляємо непотрібні пакети
sudo apt remove fonts-powerline

