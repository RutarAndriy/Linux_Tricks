#######################################
# Зміна теми GTK-програм

      GTK_THEME=[Theme:variant] [command],
напр. GTK_THEME=Adwaita:light nemo

#######################################
# Зміна теми QT-програм

      QT_STYLE_OVERRIDE=[Theme] [command],
напр. QT_STYLE_OVERRIDE=cleanlooks VirtualBox

#######################################
# Зміна теми в пускачі програм

    Exec=env GTK_THEME=[Theme:variant] [command]
    Exec=env QT_STYLE_OVERRIDE=[Theme] [command]

