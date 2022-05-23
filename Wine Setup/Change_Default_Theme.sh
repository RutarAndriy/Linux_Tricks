#!/bin/bash

# Підключаємо зовнішню функцію
source "Get_Bottles_List.sh"

# Конфігуруємо вивід інформації
COLUMNS=1
# Отримуємо шлях скрипта
SCRIPTFILE=$(readlink -f -- "${0}")
SCRIPTDIR=${SCRIPTFILE%/*}
# Переходимо у відповідну директорію
cd "$SCRIPTDIR"
# Зберігаємо розділювач файлів
IFS_ORIG=$IFS
# Змінюємо розділювач файлів
IFS=$'\n'

# Список доступних тем
THEME_NAMES=(\
"Breeze_Dark" \
"Безіменна темна тема №1" \
"Безіменна темна тема №2" \
"Відновити стандартну тему"\
)

# Файли доступних тем
THEME_FILES=(\
"wine_breeze_dark_theme.reg" \
"wine_dark_color_theme_1.reg" \
"wine_dark_color_theme_2.reg" \
"wine_reset_theme.reg"\
)

# Вибираємо wine-префікс
echo
echo "Виберіть wine-префікс:"
select PREFIX in $(get_bottles_list);
do
    [ -z "$PREFIX" ] && echo -e "\nНеправильний вибір: $REPLY\n" && exit 1
	echo -e "\n -- $PREFIX\n"
	break;
done

# Вибираємо тему для wine-префікса
echo "Виберіть тему для wine-префікса:"
select THEME in "${THEME_NAMES[@]}";
do
    [ -z "$THEME" ] && echo -e "\nНеправильний вибір: $REPLY\n" && exit 1
	echo -e "\n -- $THEME\n"
    THEME=${THEME_FILES[$(($REPLY-1))]}
	break;
done

# Змінюємо тему
WINEPREFIX="$PREFIX" wine regedit "Resources/$THEME"
# Виводимо повідомлення про успішну зміну теми
echo "Тему успішно змінено :)"
# Відновлюємо розділювач файлів
IFS=$IFS_ORIG

