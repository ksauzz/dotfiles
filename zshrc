# launching tmux by default.
if [[ "$TERM" != "screen-256color" ]] then
  tmux attach-session -t "$USER" || tmux new-session -s "$USER"
  exit
fi

## Function section.
function watchmvn {
  watchmedo shell-command --patterns="*.java" --recursive --wait --command="mvn compile -o" $*
}

function watcherl {
  watchmedo shell-command --patterns="*.hrl;*.erl" --recursive --wait --command="./rebar compile" $*
}

function ack_vim {
  vim $(ack -g $@)
}

function cvs-diff {
  cvs diff -Nbup "$@" | colordiff | less -R
}

function _whois {
  whois "$@" | nkf
}

function safety_source {
  if [[ -s $1 ]];then
    source $1
  else
    echo "zsh: [WARN] $1 not found..."
  fi
}

safety_source $HOME/dotfiles/oh-my-zshrc
safety_source $(brew --prefix autojump)/etc/autojump

## Environment variable configuration

# auto change directory
#
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

# command correct edition before each completion attempt
#
# setopt correct
unsetopt correct_all

# compacked complete list display
#
setopt list_packed

# no beep sound when complete list displayed
#
setopt nolistbeep

## Keybind configuration
#
# vim like keybind 
#
bindkey -v

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

## Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

## Completion configuration
#
fpath=(~/dotfiles/zsh/completion $fpath)
fpath=(~/dotfiles/zsh/lib/zsh-completions $fpath)
fpath=(/usr/local/share/zsh/site-functions $fpath)
autoload -U compinit
compinit

# set terminal title including current directory
#
case "${TERM}" in
kterm*|xterm)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
esac

# set terminal title for GNU screen
#
if [ "$TERM" = "screen" ]; then
  chpwd () { echo -n "_`dirs`\\" }
  preexec() {
    # see [zsh-workers:13180]
    # http://www.zsh.org/mla/workers/2000/msg03993.html
    emulate -L zsh
    local -a cmd; cmd=(${(z)2})
    case $cmd[1] in
      fg)
        if (( $#cmd == 1 )); then
          cmd=(builtin jobs -l %+)
        else
          cmd=(builtin jobs -l $cmd[2])
        fi
        ;;
      %*) 
        cmd=(builtin jobs -l $cmd[1])
        ;;
      cd)
        if (( $#cmd == 2)); then
          cmd[1]=$cmd[2]
        fi
        ;&
      *)
        echo -n "k$cmd[1]:t\\"
        return
        ;;
    esac

    local -A jt; jt=(${(kv)jobtexts})

    $cmd >>(read num rest
      cmd=(${(z)${(e):-\$jt$num}})
      echo -n "k$cmd[1]:t\\") 2>/dev/null
  }
  chpwd
fi

# zaw https://github.com/zsh-users/zaw
safety_source ~/dotfiles/zsh/lib/zaw/zaw.zsh

# https://github.com/zsh-users/zsh-syntax-highlighting
safety_source ~/dotfiles/zsh/lib/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

safety_source ~/dotfiles/zshalias

safety_source $HOME/dotfiles/zshprofile.local
safety_source $HOME/.pythonbrew/etc/bashrc
safety_source $HOME/.perlbrew/etc/bashrc
safety_source $HOME/.scm_breeze/scm_breeze.sh
