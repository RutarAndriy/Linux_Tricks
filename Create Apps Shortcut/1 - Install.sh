#!/bin/bash

# Ім'я програми
APP_NAME="Create Apps Shortcut"

# Отримуємо шлях виконання скрипта
SCRIPT_DIR="$(dirname "$(readlink -f -- "${0}")")"

# Переходимо у дану директорію
cd "${HOME}/.local/share/applications"

# Створюємо ярлик програми
echo "\
[Desktop Entry]
Name=${APP_NAME}
Exec=\"${SCRIPT_DIR}/Create_Apps_Shortcut.sh\"
Terminal=true
Icon=add-placemark
Type=Application" > "${APP_NAME}.desktop"

# Додавання ярлику прав виконання
chmod +x "${APP_NAME}.desktop"


