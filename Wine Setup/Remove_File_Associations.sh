#!/bin/bash

# Видаляємо асоціації файлів
rm -f ~/.local/share/applications/wine-extension*.desktop
rm -f ~/.local/share/icons/hicolor/*/*/application-x-wine-extension*

# Видаляємо старий кеш
rm -f ~/.local/share/applications/mimeinfo.cache
rm -f ~/.local/share/mime/packages/x-wine*
rm -f ~/.local/share/mime/application/x-wine-extension*

# Оновлюємо кеш
update-desktop-database ~/.local/share/applications
update-mime-database ~/.local/share/mime/
