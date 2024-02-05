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
Exec=<scripts/make_file_visible.sh \"%P\" \"%N\">
Icon-Name=find-location-symbolic
Conditions=exec <scripts/check_unvisibility.sh \"%P\" \"%N\">;
Selection=s
Extensions=any;
Terminal=false" > make_file_visible.nemo_action

# Записуємо файл скрипта
echo \
"[Nemo Action]
# Робимо файл прихованим
Name=Приховати файл
Comment=Зробити файл %N прихованим
Exec=<scripts/make_file_unvisible.sh \"%P\" \"%N\">
Icon-Name=action-unavailable-symbolic
Conditions=exec <scripts/check_visibility.sh \"%P\" \"%N\">;
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

# Аналіз файлу .hidden
if grep \"\$2\" .hidden;

then
    RESULT=0 # Файл прихований
else
    RESULT=1 # Файл видимий
fi

# Не обробляємо файли, які починаються із символу '.'
if [[ \"\$2\" == .* ]]; then RESULT=1; fi

# Повернення результату
exit \$RESULT" > scripts/check_unvisibility.sh

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

# Даємо дозвіл на виконання скрипта
chmod +x scripts/check_visibility.sh
chmod +x scripts/make_file_visible.sh
chmod +x scripts/check_unvisibility.sh
chmod +x scripts/make_file_unvisible.sh
