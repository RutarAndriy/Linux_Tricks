#!/bin/bash

# Інсталяція git
sudo apt install git -y

# Показ версії
git --version

# Логін користувача
git config --global user.name "Rutar Andriy"

# Пошта користувача
git config --global user.email "RutarAndriy@gmail.com"

# Текстовий редактор за замовчуванням
git config --global core.editor xed

# Кольори
red=#FF3333
green=#44FF55
blue=#729FCF
yellow=#FCE94F
git config --global color.branch.remote "$red bold"
git config --global color.status.added "$green bold"
git config --global color.status.untracked "$red bold"
git config --global color.status.changed "$yellow bold"
git config --global color.diff.commit "$yellow bold"
git config --global color.diff.new "$green bold"
git config --global color.diff.old "$red bold"
git config --global color.diff.frag "$blue bold"

git config --global alias.custom-log "log --pretty=format:'* %C(bold $red)%h%Creset %s%C(bold $yellow)%d%Creset %C(bold $green)(%cr) %C(bold $blue)<%an>%Creset' --abbrev-commit --date=relative"

# Список конфігів
git config --list

# Налаштування кольорів - https://www.atlassian.com/git/tutorials/setting-up-a-repository/git-config
