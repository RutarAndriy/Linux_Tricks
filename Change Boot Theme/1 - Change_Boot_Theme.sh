#!/bin/bash

# Отримання шляху скрипта
script_file=$(readlink -f -- "${0}")
script_dir=${script_file%/*}

# Діалог вибору кольору фону, зелений фон за промовчанням
read -r -p $'Виберіть колір фону: 1 (\e[4mзелений\e[0m), 2 (червоний), 3 (синій): ' response
if [ -z "$response" ]
then
    background_color=1
else
    background_color=$response
fi

# Копіювання папки з темою
sudo cp -a Linux_Mint_Emerald /usr/share/plymouth/themes

# Переходимо до каталогу з темою
cd /usr/share/plymouth/themes/Linux_Mint_Emerald

# Замінюємо строку, яка відповідає за колір фону
sudo sed -i 's/background.color = 1;/background.color = '$background_color';/' Linux_Mint_Emerald.script

# Реєстрування теми
sudo update-alternatives --install '/usr/share/plymouth/themes/default.plymouth' default.plymouth /usr/share/plymouth/themes/Linux_Mint_Emerald/Linux_Mint_Emerald.plymouth 100

# Вибір теми
sudo update-alternatives --config default.plymouth

# Оновлення конфігурації
sudo update-initramfs -u

# Перехід до директорії скрипта
cd "$script_dir"

# Діалог попереднього перегляду теми, із відповіддю за промовчанням "Так"
read -r -p $'Виконати попередній перегляд теми? (\e[4mТак\e[0m/Ні)? ' response
if [[ "$response" =~ ^([yY][eE][sS]|[yY]|[тТ][аА][кК]|[тТ])$ ]] || \
    [ -z "$response" ]
then
    sudo "./2 - Plymouth_Preview.sh"
fi

