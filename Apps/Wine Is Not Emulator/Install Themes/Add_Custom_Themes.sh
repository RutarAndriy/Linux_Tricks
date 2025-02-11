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

# Отримуємо список wine-префіксів
LIST=$(get_bottles_list)

# Перевіряємо чи є доступні wine-префікси
[ -z "$LIST" ] && echo -e "\nНемає жодного wine-префіксу" && exit 1

# Вибираємо wine-префікс
echo -e "\nВиберіть wine-префікс:"
select PREFIX in $LIST;
do
    [ -z "$PREFIX" ] && echo -e "\nНеправильний вибір: $REPLY\n" && exit 1
	echo -e "\n -- $PREFIX\n"
	break;
done

# Отримуємо список доступних тем
THEME_LIST=( $(find ./Themes -mindepth 1 -maxdepth 1 -printf "%f\n") )
# Добавляємо в список додаткові елементи
THEME_LIST+=( "Усі доступні теми" "Видалити встановлені теми" )

# Вибираємо тему для wine-префікса
echo "Виберіть яку тему встановити:"
select THEME in "${THEME_LIST[@]}";
do
    [ -z "$THEME" ] && echo -e "\nНеправильний вибір: $REPLY\n" && exit 1
	echo -e "\n -- $THEME\n"
	break;
done

# Видаляємо встановлені теми
if [ $REPLY -eq ${#THEME_LIST[@]} ]
then
    unset THEME_LIST[-1] && unset THEME_LIST[-1]
    for THEME in "${THEME_LIST[@]}"; do
        [ -e "$PREFIX/drive_c/windows/resources/themes/$THEME" ] && echo " -- $THEME"
        rm -rf "$PREFIX/drive_c/windows/resources/themes/$THEME"
    done
    echo -e "\nУсі встановлені теми успішно видалено :)"

# Встановлюємо усі теми
elif [ $REPLY -eq $(( ${#THEME_LIST[@]} - 1 )) ]
then
    unset THEME_LIST[-1] && unset THEME_LIST[-1]
    for THEME in "${THEME_LIST[@]}"; do
        echo " -- $THEME"
        cp -ar "./Themes/$THEME" "$PREFIX/drive_c/windows/resources/themes"
    done
    echo -e "\nУсі теми успішно встановлено :)"

# Встановлюємо конкретну тему   
else
    cp -ar "./Themes/$THEME" "$PREFIX/drive_c/windows/resources/themes"
    echo "Тему \"$THEME\" успішно встановлено :)"
fi

# Відновлюємо розділювач файлів
IFS=$IFS_ORIG

