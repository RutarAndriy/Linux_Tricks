
UT='\[\033[0;1;7;32m\]'      # Стиль тексту користувача
UA='\[\033[0;1;27;32;104m\]' # Стиль тексту стрілки користувача
DT='\[\033[0;1;7;34m\]'      # Стиль тексту шляху
DA='\[\033[0;1;27;34m\]'     # Стиль тексту стрілки шляху
DP='\[\033[0m\]'             # Відновити стандартні параметри

PS1=${UT}'\u@\h'${UA}''${DT}'$([ $(grep -o "/" <<<"$PWD" | grep -c .) -le 3 ] && echo $PWD || echo ...${PWD#"${PWD%/*/*/*}"})'${DA}''${DP}'\n\$ '

unset UT UA DT DA DP
