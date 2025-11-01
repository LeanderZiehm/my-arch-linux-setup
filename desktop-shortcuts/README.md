

```
vim ~/.local/share/applications/hello-cat.desktop

[Desktop Entry]
Type=Application
Name=Show hello.txt
Exec=gnome-terminal -- bash -c "cat ~/hello.txt; exec bash"
Terminal=false
Icon=utilities-terminal
Categories=Utility;


```