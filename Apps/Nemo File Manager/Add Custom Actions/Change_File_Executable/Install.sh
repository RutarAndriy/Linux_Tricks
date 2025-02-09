#!/bin/bash

# Переходимо у папку скриптів
cd ~/.local/share/nemo/actions

# Створюємо директорію зі скриптами
mkdir scripts

# Записуємо файл скрипта
echo \
"[Nemo Action]
# Робимо файл виконуваним
Name=Зробити файл виконуваним
Comment=Зробити файл %N виконуваним
Exec=chmod +x %P/%N
Icon-Name=system-run-symbolic
Conditions=exec <scripts/run_and_check.sh check_executable.sh %F \"!=\" 0>;
Selection=s
Extensions=sh;jar;
Terminal=false" > make_file_executable.nemo_action

# Записуємо файл скрипта
echo \
"[Nemo Action]
# Робимо файл невиконуваним
Name=Зробити файл невиконуваним
Comment=Зробити файл %N невиконуваним
Exec=chmod -x %P/%N
Icon-Name=system-run-symbolic
Conditions=exec <scripts/run_and_check.sh check_executable.sh %F \"=\" 0>;
Selection=s
Extensions=sh;jar;
Terminal=false" > make_file_not_executable.nemo_action

# Записуємо файл скрипта
echo \
"#!/bin/bash
if [ -x \"\$@\" ]; then
    RESULT=0
    continue
else
    RESULT=1
    break
fi
exit \$RESULT" > scripts/check_executable.sh

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
chmod +x scripts/check_executable.sh
chmod +x scripts/run_and_check.sh
