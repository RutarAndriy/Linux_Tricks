# Скрипт для виправлення комбінації клавіш
# Ctrl + Shift + Key

# Додавання нового репозиторію
sudo add-apt-repository ppa:nrbrtx/xorg-hotkeys

# Оновлення інформації про доступні пакунки
sudo apt-get update

# Оновлення компонентів системи
sudo apt-get dist-upgrade

# Інформаційне повідомлення
echo Необхідно перезавантажити систему

# Діалог перезавантаження системи
read -r -p $'Перезавантажити систему зараз (Так/\e[4mНі\e[0m)? ' response
if [[ "$response" =~ ^([yY][eE][sS]|[yY]|[тТ][аА][кК]|[тТ])$ ]]
then
    echo Перезавантажуємо систему; sleep 1; reboot
else
    echo Завершуємо роботу скрипта; sleep 1
fi
