#!/bin/bash

# Отримуємо шлях виконання скрипта
SCRIPT_DIR="$(dirname "$(readlink -f -- "${0}")")"

# Переходимо у дану директорію
cd "$SCRIPT_DIR"

# Додаємо інформацію з шаблону в файл .bashrc
sed -i -e '/unset\ color_prompt\ force_color_prompt/rTemplate.sh' ~/.bashrc

# Інсталюємо необхідні пакети
sudo apt install fonts-powerline

