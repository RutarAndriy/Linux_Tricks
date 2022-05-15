#!/bin/bash

APP_NAME="Test Shortcut"

# Зміна робочої директорії
cd "$HOME/.config/autostart"

# Вилучення ярлика автозавантаження
rm "$APP_NAME.desktop"

# Зміна робочої директорії
cd "$HOME/.local/share/applications"

# Вилучення ярлика програми
rm "$APP_NAME.desktop"

