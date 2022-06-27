#!/bin/bash

# Перемінні кольорів
R='\e[1;31m' # Червоний колір
G='\e[1;32m' # Зелений колір
B='\e[1;34m' # Синій колір
Y='\e[1;33m' # Жовтий колір
N='\e[0m'    # Стандартний колір

# Допоміжні перемінні
W=135           # Ширина вікна терміналу (в символах)
H=$(tput lines) # Висота вікна терміналу (в символах)
P='\e[1A'     # Керуючий символ, протилежний до \n
ERR=0           # Змінна вказує на помилку виконання команди

# Змінюємо розмір вікна терміналу
printf "\e[8;${H};${W}t"

# Список тестових прикладів
VARIANTS=(\
"Створити ярлик для програми" \
"Тестовий приклад №1 (Запустити файловий менеджер \"nemo\")" \
"Тестовий приклад №2 (Запустити перший файл із даної директорії, який відповідає масці <test*>)" \
"Тестовий приклад №3 (Інвертувати порядок сортування та запустити перший файл із даної директорії, який відповідає масці <test*>)" \
"Видалити ярлик тестового прикладу"\
)

# Список категорій
CATEGORY_EN=(Graphics AudioVideo Education Office Development Utility Game Network Application System Settings)
CATEGORY_UK=("Графіка" "Звук та відео" "Навчання" "Офіс" "Програмування" "Стандартні" "Ігри" "Інтернет" "Інші" "Адміністрування" "Параметри")

# Конфігуруємо вивід інформації
COLUMNS=1

# Вибираємо варіант створення ярлика //////////////////////////////////////////
echo
echo -e "${B}Виберіть варіант створення ярлика:${N}"
select VARIANT in "${VARIANTS[@]}"
do
    [ -z "${VARIANT}" ] && echo -e "${R}Неправильний вибір: ${REPLY}${N}" && continue
	echo -e "\n ${G}-- ${VARIANT}${N} \n"
	break
done

# /////////////////////////////////////////////////////////////////////////////
# Створення ярлика для програми ///////////////////////////////////////////////
if [ ${REPLY} -eq 1 ]; then

# Запитуємо ім'я програми /////////////////////////////////////////////////////
ERR=1
until [ ${ERR} -eq 0 ]; do
    echo -e "${B}Введіть ім'я програми:${N}"
    read APP_NAME
    [ -z "${APP_NAME}" ] && echo -e "${P}${R}Ім'я програми не вказано :(${N}" && continue
    [ -f "${HOME}/.local/share/applications/${APP_NAME}.desktop" ] && echo -e "${R}Дане ім'я уже використовується :(${N}" && continue
    echo -e "\n ${G}-- ${APP_NAME}${N} \n"
    ERR=0
done

# Запитуємо шлях до програми //////////////////////////////////////////////////
ERR=1
until [ ${ERR} -eq 0 ]; do
    echo -e "${B}Введіть шлях до програми:${N}"
    read APP_DIR
    [ -z "${APP_DIR}" ] && echo -e "${P}${R}Шлях до програми не вказано :(${N}" && continue
    ! [ -d "${APP_DIR}" ] && echo -e "${R}Даного шляху ${Y}(${APP_DIR})${R} не існує :(${N}" && continue
    APP_DIR=$(echo "${APP_DIR}" | tr -s '/')
    [ "${APP_DIR: -1}" = "/" ] && APP_DIR=${APP_DIR%/*}
    [ "${APP_DIR:0:1}" = "/" ] && APP_DIR=${APP_DIR#*/}
    echo -e "\n ${G}-- ${APP_DIR}${N} \n"
    ERR=0
done

# Запитуємо команду виконання програми ////////////////////////////////////////
ERR=1
until [ ${ERR} -eq 0 ]; do
    echo -e "${B}Введіть команду виконання програми:${N}"
    echo -e "напр. ${Y}env QT_STYLE_OVERRIDE=cleanlooks VirtualBox %U${N}"
    read APP_EXEC
    [ -z "${APP_EXEC}" ] && echo -e "${P}${R}Команду виконання програми не вказано :(${N}" && continue
    echo -e "\n ${G}-- ${APP_EXEC}${N} \n"
    ERR=0
done

# Запитуємо назву або шлях до іконки програми /////////////////////////////////
ERR=1
until [ ${ERR} -eq 0 ]; do
    echo -e "${B}Введіть назву або відносний шлях до іконки програми:${N}"
    read APP_ICON
    [ -z "${APP_ICON}" ] && echo -e "${P}${R}Назву або відносний шлях до іконки програми не вказано :(${N}" && continue
    [[ "${APP_ICON}" =~ .*".".* ]] && ! [ -f "/${APP_DIR}/${APP_ICON}" ] && echo -e "${P}${R}Даної іконки ${Y}(/${APP_DIR}/${APP_ICON})${R} не існує :(${N}" && continue
    echo -e "\n ${G}-- ${APP_ICON}${N} \n"
    ERR=0
done

# Запитуємо опис програми /////////////////////////////////////////////////////
echo -e "${B}Введіть опис програми [Опис відсутній]:${N}"
read APP_DESC
! [ -z "${APP_DESC}" ] && echo
APP_DESC=${APP_DESC:-"Опис відсутній"}
echo -e "${G} -- ${APP_DESC}${N} \n"

# Запитуємо категорію програми ////////////////////////////////////////////////
echo -e "${B}Виберіть категорію програми:${N}"
select APP_CATEGORY in "${CATEGORY_UK[@]}"
do
    [ -z "${APP_CATEGORY}" ] && echo -e "${R}Неправильний вибір: ${REPLY}${N}" && continue
	echo -e "\n ${G}-- ${APP_CATEGORY}${N} \n"
    APP_CATEGORY="${CATEGORY_EN[$(($REPLY-1))]}"
	break
done

# Запитуємо чи запускати програму в терміналі /////////////////////////////////
echo -e "${B}Запускати програму в терміналі [Ні]:${N}"
read APP_TERMINAL
! [ -z "${APP_TERMINAL}" ] && echo
[[ "${APP_TERMINAL}" =~ ^([yY][eE][sS]|[yY]|[тТ][аА][кК]|[тТ])$ ]] && APP_TERMINAL=Так || APP_TERMINAL=Ні
echo -e "${G} -- ${APP_TERMINAL}${N} \n"
[ ${APP_TERMINAL} = "Так" ] && APP_TERMINAL=true || APP_TERMINAL=false

# Запитуємо чи необхідний програмі автозапуск /////////////////////////////////
echo -e "${B}Даній програмі необхідний автозапуск [Ні]:${N}"
read APP_AUTOSTART
! [ -z "${APP_AUTOSTART}" ] && echo
[[ "${APP_AUTOSTART}" =~ ^([yY][eE][sS]|[yY]|[тТ][аА][кК]|[тТ])$ ]] && APP_AUTOSTART=Так || APP_AUTOSTART=Ні
echo -e "${G} -- ${APP_AUTOSTART}${N} \n"
[ ${APP_AUTOSTART} = "Так" ] && APP_AUTOSTART=true || APP_AUTOSTART=false

# Запитуємо затримку автозапуску програми /////////////////////////////////////
if [ ${APP_AUTOSTART} = "true" ]; then
    echo -e "${B}Виберіть затримку автозапуску програми:${N}"
    select APP_DELAY in "без затримки" "5 сек." "30 сек." "5 хв." "30 хв."
    do
        [ -z "${APP_DELAY}" ] && echo -e "${R}Неправильний вибір: ${REPLY}${N}" && continue
	    echo -e "\n ${G}-- ${APP_DELAY}${N} \n"
        case ${APP_DELAY} in
            "без затримки" ) APP_DELAY=0    ;;
            "5 сек."       ) APP_DELAY=5    ;;
            "30 сек."      ) APP_DELAY=30   ;;
            "5 хв."        ) APP_DELAY=300  ;;
            "30 хв."       ) APP_DELAY=1800 ;;
        esac; break
    done
else
    APP_DELAY=0
fi

# Переходимо у директорію програми
cd "/${APP_DIR}"

# /////////////////////////////////////////////////////////////////////////////
# Створюємо інсталяційний скрипт //////////////////////////////////////////////

echo "\
#!/bin/bash

# Ім'я та опис програми
APP_NAME=\"${APP_NAME}\"
APP_DESC=\"${APP_DESC}\"

# Робоча директорія програми
APP_DIR=\"\$(dirname \"\$(readlink -f -- \"\${0}\")\")\"

# Команда виконання програми
APP_EXEC=\"${APP_EXEC}\"

# Іконка програми
APP_ICON=\"${APP_ICON}\"

# Категорія програми
APP_CATEGORY=\"${APP_CATEGORY}\"

# Допускаються наступні категорії програм:
# Graphics, AudioVideo, Education, Office, Development,
# Utility, Game, Network, Application, System, Settings

# Додаткові параметри ярлика
APP_TERMINAL=\"${APP_TERMINAL}\"
APP_AUTOSTART=\"${APP_AUTOSTART}\"
APP_AUTOSTART_DELAY=\"${APP_DELAY}\"

# Перевірка наявності виконуваного файлу
[ -f \"\${APP_DIR}/\${APP_EXEC}\" ] && APP_EXEC=\"\${APP_DIR}/\${APP_EXEC}\"

# Перевірка наявності іконки
[ -f \"\${APP_DIR}/\${APP_ICON}\" ] && APP_ICON=\"\${APP_DIR}/\${APP_ICON}\"

# Опис ярлика програми
echo \"\\
[Desktop Entry]
Name=\${APP_NAME}
Comment=\${APP_DESC}
Exec=\\\"\${APP_EXEC}\\\"
Path=\${APP_DIR}
Icon=\${APP_ICON}
Terminal=\${APP_TERMINAL}
Type=Application
Categories=\${APP_CATEGORY};\" >> \"\${APP_NAME}.desktop\"

# Копіювання ярлика у директорію з програмами
cp \"\${APP_NAME}\".desktop \"\${HOME}/.local/share/applications\"

# Створення ярлика автозавантаження програми
if [[ \${APP_AUTOSTART} == true ]]; then

# Дописуємо в ярлик інформацію про автозавантаження
echo \"\\
X-GNOME-Autostart-enabled=true
X-GNOME-Autostart-Delay=\${APP_AUTOSTART_DELAY}\" >> \"\${APP_NAME}.desktop\"

# Перемішуємо ярлик у відповідну директорію
mv \"\${APP_NAME}\".desktop \"\${HOME}/.config/autostart\"

else

# Видаляємо зайву копію ярлика
rm \"\${APP_NAME}\".desktop

fi

# Зміна робочої директорії
cd \"\${HOME}/.local/share/applications\"

# Додавання ярлику прав на виконання програми
chmod +x \"\${APP_NAME}.desktop\"
" > "1 - Install.sh"

chmod +x "1 - Install.sh"

# /////////////////////////////////////////////////////////////////////////////
# Створюємо дезінсталяційний скрипт ///////////////////////////////////////////

echo "\
#!/bin/bash

APP_NAME=\"${APP_NAME}\"

# Зміна робочої директорії
cd \"\${HOME}/.config/autostart\"

# Вилучення ярлика автозавантаження
rm -f \"\${APP_NAME}.desktop\"

# Зміна робочої директорії
cd \"\${HOME}/.local/share/applications\"

# Вилучення ярлика програми
rm -f \"\${APP_NAME}.desktop\"
" > "2 - Uninstall.sh"

chmod +x "2 - Uninstall.sh"

# /////////////////////////////////////////////////////////////////////////////
# Генерування тестових прикладів //////////////////////////////////////////////
elif [ ${REPLY} -ge 2 ] && [ ${REPLY} -le 4 ]; then

# Ім'я та опис програми
APP_NAME="Test Shortcut"
APP_DESC="Test shortcut description"
APP_ICON="icon.svg"
APP_CATEGORY="Application;"
APP_TERMINAL="true"

# Отримання шляху скрипта
SCRIPT_FILE=$(readlink -f -- "${0}")
SCRIPT_DIR=${SCRIPT_FILE%/*}

# Робоча директорія програми
EXEC_PATH=${SCRIPT_DIR}

# Запустити файловий менеджер "nemo"
[ ${REPLY} -eq 2 ] && EXEC_PARAMS=\"nemo\" && APP_TERMINAL="false"

# Запустити перший файл із директорії програми, який відповідає масці <test*>
[ ${REPLY} -eq 3 ] && EXEC_PARAMS=\"$SCRIPT_DIR/$(ls test* | head -1)\"

# Інвертувати порядок сортування та запустити перший файл із директорії програми, який відповідає масці <test*>
[ ${REPLY} -eq 4 ] && EXEC_PARAMS=\"$SCRIPT_DIR/$(ls -r test* | head -1)\"

# Опис ярлика програми
echo "\
[Desktop Entry]
Name=${APP_NAME}
Comment=${APP_DESC}
GenericName=${APP_DESC}
Exec=${EXEC_PARAMS}
Path=${EXEC_PATH}
Icon=${SCRIPT_DIR}/${APP_ICON}
Terminal=${APP_TERMINAL}
Type=Application
Categories=${APP_CATEGORY}" >> "${APP_NAME}.desktop"

# Переміщення ярлика у директорію з програмами
mv "${APP_NAME}".desktop "${HOME}/.local/share/applications"

# Зміна робочої директорії
cd "${HOME}/.local/share/applications"

# Додавання ярлику прав на виконання програми
chmod +x "${APP_NAME}".desktop

# Інформаційне повідомлення
echo -e "${P}${Y} -- Тестовий приклад успішно згенеровано \n"

# /////////////////////////////////////////////////////////////////////////////
# Видалення ярлика тестового прикладу
else

APP_NAME="Test Shortcut"

# Зміна робочої директорії
cd "${HOME}/.local/share/applications"

# Вилучення ярлика програми
rm "${APP_NAME}.desktop"

# Інформаційне повідомлення
echo -e "${P}${Y} -- Ярлик тестового прикладу успішно видалено \n"

fi

