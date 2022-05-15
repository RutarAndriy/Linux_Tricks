#!/bin/bash

# Ім'я та опис програми
APP_NAME="Test Shortcut"
APP_DESC="Test shortcut description"
APP_ICON="icon.svg"
APP_CATEGORY="Application;"

# Допускаються наступні категорії програм:
# Application, AudioVideo, Audio, Video, Development, Education, 
# Game, Graphics, Network, Office, Science, Settings, System, Utility

# Додаткові параметри ярлика
APP_TERMINAL=true
APP_AUTOSTART=true
APP_AUTOSTART_DELAY=5

# Отримання шляху скрипта
SCRIPT_FILE=$(readlink -f -- "${0}")
SCRIPT_DIR=${SCRIPT_FILE%/*}

# Робоча директорія програми
EXEC_PATH=$SCRIPT_DIR

# Запустити файловий менеджер nemo
EXEC_PARAMS=nemo

# Запустити файл test_script_1, який знаходиться у директорії програми
# EXEC_PARAMS=\"$SCRIPT_DIR/test_script_1\"

# Запустити перший файл із директорії програми, який відповідає масці <test*>
# EXEC_PARAMS=\"$SCRIPT_DIR/$(ls test* | head -1)\"

# Інвертувати порядок сортування та запустити перший файл із директорії програми, який відповідає масці <test*>
# EXEC_PARAMS=\"$SCRIPT_DIR/$(ls -r test* | head -1)\"

# Опис ярлика програми
echo "\
[Desktop Entry]
Name=$APP_NAME
Comment=$APP_DESC
GenericName=$APP_DESC
Exec=$EXEC_PARAMS
Path=$EXEC_PATH
Icon=$SCRIPT_DIR/$APP_ICON
Terminal=$APP_TERMINAL
Type=Application
Categories=$APP_CATEGORY" >> "$APP_NAME.desktop"

# Копіювання ярлика у директорію з програмами
cp "$APP_NAME".desktop "$HOME/.local/share/applications"

# Створення ярлика автозавантаження програми
if [[ $APP_AUTOSTART == true ]]
then

# Дописуємо в ярлик інформацію про автозавантаження
echo "\
X-GNOME-Autostart-enabled=true
X-GNOME-Autostart-Delay=$APP_AUTOSTART_DELAY" >> "$APP_NAME.desktop"

# Перемішуємо ярлик у відповідну директорію
mv "$APP_NAME".desktop "$HOME/.config/autostart"

else

# Видаляємо зайву копію ярлика
rm "$APP_NAME".desktop

fi

# Зміна робочої директорії
cd "$HOME/.local/share/applications"

# Додавання ярлику прав на виконання програми
chmod +x "$APP_NAME".desktop

