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
Conditions=exec <scripts/check_not_executable.sh %F>;
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
Conditions=exec <scripts/check_executable.sh %F>;
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
"#!/bin/bash
if [ -x \"\$@\" ]; then
    RESULT=1
    continue
else
    RESULT=0
    break
fi
exit \$RESULT" > scripts/check_not_executable.sh

# Даємо дозвіл на виконання скрипта
chmod +x scripts/check_executable.sh
chmod +x scripts/check_not_executable.sh
