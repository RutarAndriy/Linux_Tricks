#!/bin/bash

# Переходимо у папку скриптів
cd ~/.local/share/nemo/actions

# Створюємо директорію зі скриптами
mkdir scripts

# Записуємо файл скрипта
echo \
"[Nemo Action]
# Робимо файл видимим
Name=Показати файл
Comment=Зробити файл %N видимим
Exec=<scripts/make_file_visible.sh %P %N>
Icon-Name=find-location-symbolic
Conditions=exec <scripts/run_and_check.sh check_visibility.sh %P %N \"!=\" 0>;
Selection=s
Extensions=any;
Terminal=false" > make_file_visible.nemo_action

# Записуємо файл скрипта
echo \
"[Nemo Action]
# Робимо файл прихованим
Name=Приховати файл
Comment=Зробити файл %N прихованим
Exec=<scripts/make_file_unvisible.sh %P %N>
Icon-Name=action-unavailable-symbolic
Conditions=exec <scripts/run_and_check.sh check_visibility.sh %P %N \"=\" 0>;
Selection=s
Extensions=any;
Terminal=false" > make_file_unvisible.nemo_action

# Записуємо файл скрипта
echo \
"#!/bin/bash

# Переходимо у необхідну директорію
cd \"\$1\"

# Аналіз файлу .hidden
if grep \"\$2\" .hidden;

then
    RESULT=1 # Файл прихований
else
    RESULT=0 # Файл видимий
fi

# Не обробляємо файли, які починаються із символу '.'
if [[ \"\$2\" == .* ]]; then RESULT=1; fi

# Повернення результату
exit \$RESULT" > scripts/check_visibility.sh

# Записуємо файл скрипта
echo \
"#!/bin/bash

# Переходимо у необхідну директорію
cd \"\$1\"

# Обробляємо файл
sed -i \"/\$2/d\" .hidden

# Видаляємо файл .hidden, якщо він пустий
[ ! -s .hidden ] && rm .hidden" > scripts/make_file_visible.sh

# Записуємо файл скрипта
echo \
"#!/bin/bash

# Переходимо у необхідну директорію
cd \"\$1\"

# Обробляємо файл
echo \"\$2\" >> .hidden" > scripts/make_file_unvisible.sh

# Записуємо файл скрипта
echo \
'#!/bin/bash

# Отримання шляху скрипта
SCRIPT_FILE=$(readlink -f -- "${0}")
SCRIPT_DIR=${SCRIPT_FILE%/*}
cd $SCRIPT_DIR

# Перевірка наявності параметрів
if [ $# -eq 0 ]; then exit -1; fi

# Отримання команди для виконанння
EXEC_COMMAND=$1
for (( i=2; i<=$#-2; i++ ))
do  
   EXEC_COMMAND="$EXEC_COMMAND ${!i}"
done

# Виконання команди
sh ./$EXEC_COMMAND
EXEC_RESULT=$?

# Отримання операції порівняння
NUM_PRELAST=$(($# - 1))
OPERATOR=${!NUM_PRELAST}

# Отримання значення для порівняння
NUM_LAST=$#
VALUE=${!NUM_LAST}

# Обробка оператора "="
if   [ "$OPERATOR" = "="  ]; then
    if [ "$EXEC_RESULT" -eq "$VALUE" ]; then RESULT=0; else RESULT=1; fi

# Обробка оператора ">"
elif [ "$OPERATOR" = ">"  ]; then
    if [ "$EXEC_RESULT" -gt "$VALUE" ]; then RESULT=0; else RESULT=1; fi

# Обробка оператора ">="
elif [ "$OPERATOR" = ">=" ]; then
    if [ "$EXEC_RESULT" -ge "$VALUE" ]; then RESULT=0; else RESULT=1; fi

# Обробка оператора "<"
elif [ "$OPERATOR" = "<"  ]; then
    if [ "$EXEC_RESULT" -lt "$VALUE" ]; then RESULT=0; else RESULT=1; fi

# Обробка оператора "<="
elif [ "$OPERATOR" = "<=" ]; then
    if [ "$EXEC_RESULT" -le "$VALUE" ]; then RESULT=0; else RESULT=1; fi

# Обробка оператора "!="
elif [ "$OPERATOR" = "!=" ]; then
    if [ "$EXEC_RESULT" -ne "$VALUE" ]; then RESULT=0; else RESULT=1; fi

# Невідомий оператор
else
    echo "Unknown operator: $OPERATOR"; RESULT=1
fi

# Повертаємо результат
exit $RESULT' > scripts/run_and_check.sh

# Даємо дозвіл на виконання скрипта
chmod +x scripts/check_visibility.sh
chmod +x scripts/make_file_visible.sh
chmod +x scripts/make_file_unvisible.sh
chmod +x scripts/run_and_check.sh
