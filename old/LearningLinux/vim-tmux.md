	touch ~/.bashrc.mtime \
  && watch -n1 -t \
     '[ "$(stat --format="%Y" ~/.bashrc)" != "$(cat ~/.bashrc.mtime)" ] && tmux send-keys -t 0 "source ~/.bashrc" C-m && stat --format="%Y" ~/.bashrc > ~/.bashrc.mtime'








tmux

split screen vertical
Ctrl+b then %


Ctrl+b then o

Ctrl+b then ← →