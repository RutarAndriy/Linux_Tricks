#!/bin/bash

# Переходимо у папку скриптів
cd ~/.local/share/nemo/actions

# Видаляємо файл скрипта
rm open_in_notepad++.nemo_action

# Видаляємо іконки
for size in 16 32 48 64 128 256
do
xdg-icon-resource uninstall --size $size notepad++
done
