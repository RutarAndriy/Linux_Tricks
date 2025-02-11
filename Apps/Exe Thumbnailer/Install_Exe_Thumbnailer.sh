#!/bin/bash

# Встановлення pipx
sudo apt install -y pipx

# Встановлення icoextract
pipx install icoextract[thumbnailer]

# Додаємо дані до системної змінної %PATH 
pipx ensurepath

# Створюємо необхідну директорію
sudo mkdir /usr/local/share/thumbnailers

# Копіюємо файл генерування іконок
sudo cp exe-thumbnailer.thumbnailer /usr/local/share/thumbnailers

# Інформаційне повідомлення
echo Необхідно перезавантажити систему

# Діалог перезавантаження системи
read -r -p $'Перезавантажити систему зараз (Так/\e[4mНі\e[0m)? ' response
if [[ "$response" =~ ^([yY][eE][sS]|[yY]|[тТ][аА][кК]|[тТ])$ ]]
then
    echo Перезавантажуємо систему; sleep 1; reboot
else
    echo Завершуємо роботу скрипта; sleep 1
fi
