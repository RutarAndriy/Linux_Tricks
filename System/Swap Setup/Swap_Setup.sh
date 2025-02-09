#!/bin/bash

# Показати процент використання файлу підкачки
echo Процент використання файлу підкачки \(0 - 100\): $(cat /proc/sys/vm/swappiness)

# Показати значення часу збереення кешу
echo Час збереження кешу \(0 - 100\): $(cat /proc/sys/vm/vfs_cache_pressure)
echo

# Задати процент використання файлу підкачки (постійне значення)
sudo sysctl -w vm.swappiness=10

# Задати значення часу збереення кешу (постійне значення)
sudo sysctl -w vm.vfs_cache_pressure=75

echo
echo Натисніть Enter для продовження; read dummy;
