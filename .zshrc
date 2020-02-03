# there can be only one editor
export EDITOR=/usr/local/bin/emacs

# history settings
export HISTSIZE=1000
export SAVEHIST=1000
export HISTFILE=~/.zsh_history
export APPEND_HISTORY=true
export INC_APPEND_HISTORY=true
export SHARE_HISTORY=true
export HIST_IGNORE_ALL_DUPS=true

# fixup the prompt
export PS1='%D %T %n@%m %~ %# '

# customize bat for light iterm2
export BAT_THEME="OneHalfLight"
