#!/bin/bash

# Назва готової програми
APP_NAME="helloFromDeb"

# Створюємо робочу директорію і переходимо в неї
cd ~ && mkdir -p "$APP_NAME" && cd "$APP_NAME"

# Створюємо вихідний код програми
echo "\
#include <stdio.h>
int main(){
printf(\"This is $APP_NAME app\n\");
}" > "$APP_NAME.c"

# Компілюємо програму
gcc "$APP_NAME.c" -o "$APP_NAME"

# Створюємо директорії для deb-ресурсів
mkdir -p Resources/DEBIAN Resources/usr/bin

# Видаляємо вихідний код програми
rm "$APP_NAME.c"

# Переміщуємо зкомпільовану програму
mv ./"$APP_NAME" Resources/usr/bin

# Дізнаємося розмір інстальованої програми
APP_SIZE=( $(du -s --apparent-size Resources/usr/) )

# Створення маніфесту deb-пакету
echo "\
Package: hello-from-deb
Version: 1.0.0
Section: unknown
Priority: optional
Depends: libc6
Architecture: amd64
Essential: no
Installed-Size: ${APP_SIZE[0]}
Maintainer: RutarAndriy <RutarAndriy@gmail.com>
Description: Simple terminal application" > Resources/DEBIAN/control

# Дізнатися про залежності можна так:
# objdump -p ./$APP_NAME | grep NEEDED
# dpkg -S libc.so.6

# Package        - ім'я пакету;
# Version        - версія програми, буде використана при оновленні пакету;
# Section        - категорія пакету, дозволяє визначити навіщо він необхідний;
# Priority       - важливість пакету: (optional, required, important або standard);
# Depends        - залежності пакету, якщо вони відсутні, то пакет не встановиться;
# Recommends     - необов'язкові пакети, можуть розширювати функціональність;
# Conflicts      - пакет не встановиться, поки в системі інстальовані дані пакети;
# Architecture   - архітектура системи: (i386, amd64 або all);
# Installed-Size - загальний розмір програми після встановлення;
# Maintainer     - зазначає людину, яка зібрала та обслуговує даний пакет;
# Description    - короткий опис пакету.

# Створення пре-інсталяційного скрипта
echo "\
#!/bin/bash
echo \"Running pre-install script\"" > Resources/DEBIAN/preinst

# Створення пре-деінсталяційного скрипта
echo "\
#!/bin/bash
echo \"Running pre-remove script\"" > Resources/DEBIAN/prerm

# Створення пост-інсталяційного скрипта
echo "\
#!/bin/bash
echo \"Running post-install script\"" > Resources/DEBIAN/postinst

# Створення пост-деінсталяційного скрипта
echo "\
#!/bin/bash
echo \"Running post-remove script\"" > Resources/DEBIAN/postrm

# Задаємо дозволи для файлів
sudo chmod -R 755 ./Resources

# Збираємо deb-пакет
dpkg-deb --build ./Resources $APP_NAME.deb

# Видаляємо використані ресурси
rm -r ./Resources

