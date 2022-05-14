#!/bin/bash

# Переходимо у папку скриптів
cd ~/.local/share/nemo/actions

# Інсталюємо необхідні утиліти
sudo apt-get install icoutils

# Створюємо директорію зі скриптами
mkdir scripts

# Записуємо файл скрипта
echo "[Nemo Action]
# Видобування іконок із *.exe та *.dll файлів
Name=Видобути іконки із %N
Comment=Видобування іконок із файлів *.exe та *.dll
Exec=<scripts/extract_icons.sh %P %N>
Icon-Name=albumfolder-importdir
Selection=s
Extensions=exe;dll;
EscapeSpaces=true
Terminal=true" > extract_icons.nemo_action

# Записуємо файл скрипта
echo "#!/bin/bash
mkdir "\$1/\$2_icons"
wrestool -x --output="\$1/\$2_icons" -t14 "\$1/\$2"
exit 0" > scripts/extract_icons.sh

# Даємо дозвіл на виконання скрипта
chmod +x scripts/extract_icons.sh 
