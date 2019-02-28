# launching tmux by default.
if [[ "x$TMUX" == "x" ]] then
  if ! which reattach-to-user-namespace > /dev/null; then
    echo "zsh: [WARN] reattach-to-user-namespace is not found"
  fi

  if ! tmux has-session -t default; then
    tmux new-session -s default
  elif [[ "x"  == "x`tmux list-sessions | grep attached | grep default`" ]] then
    tmux attach-session -t default
  else
    tmux new-session
  fi
  exit
fi

function xmod() {
  if [[ "`xmodmap | grep -c 'Caps_Lock (0x25)'`" == "0" ]]; then
    setxkbmap -option
    if [[ "`xinput | grep -c HHKB`" == "1" ]]; then
      xmodmap ~/dotfiles/xmodmap.hhkb
    else
      xmodmap ~/dotfiles/xmodmap
    fi
  fi
}
#xmod

## Function section.
function watchmvn {
  watchmedo shell-command \
    --patterns="*.java" \
    --recursive --wait \
    --command="mvn compile -o" $*
}

function watcherl {
  watchmedo shell-command \
    --patterns="*.hrl;*.erl" \
    --recursive --wait \
    --command="./rebar compile" $*
}

function watchc {
  watchmedo shell-command \
    --patterns="*.h;*.c" \
    --recursive --wait \
    --command="make;\
               echo \"$(tput setaf 2)## DONE ##$(tput sgr0) \$(date '+%Y/%m/%d %H:%M:%S')\"" $*
}

function watchgo {
  watchmedo shell-command \
    --patterns="*.go" \
    --recursive --wait \
    --command="go build -v . ;\
               echo \"$(tput setaf 2)## DONE ##$(tput sgr0) \$(date '+%Y/%m/%d %H:%M:%S')\""
}

function git-pr {
  pr_num=$1
  echo "fetching origin pull/$pr_num/merge as pr/$pr_num..."
  git fetch origin pull/$pr_num/merge:pr/$pr_num

  echo "checking out pr/$pr_num..."
  git checkout pr/$pr_num
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

function gist-clone {
  if [[ "x$1" != "x" ]];then
    git clone git@github.com:gist/$1.git $2
  else
    cat <<EOF
USAGE
=====
gist-clone gist-id [work-dir-name]
EOF
  fi
}

function split-3windows {
  tmux split-window -h
  cd ${PWD}
  tmux split-window
  cd ${PWD}
}

function safety_source {
  if [[ -s $1 ]];then
    source $1
  else
    echo "zsh: [WARN] $1 not found..."
  fi
}

function docker-rmi-all {
  docker rm $(docker ps -a -q -f status=exited)
  docker rmi $(docker images -q -f dangling=true)
  docker volume rm $(docker volume ls -q -f dangling=true)
}

function randstr {
  length=${1:-64}
  format=${2:-a-zA-Z0-9}
  sh -c "LC_ALL=C; openssl rand 1000 | tr -dc $format | fold -w \"$length\" | head -n 1"
}

# erlenv quickhack
ERL_HOME=/usr/local/erlang
function _erlenv_list {
  ls -1 $ERL_HOME | grep -v current
}

function _erlenv_current {
  echo -n "current: "
  ls -l $ERL_HOME | grep current | awk '{print $11}' | sed 's/\(.*\)\/\(.*\)/\2/'
}

function _erlenv_set {
  if [ "$1" = "" ]; then
    echo "USAGE: erlenv set <OTP VERSION>"
    return
  elif [ ! -d "$ERL_HOME/$1" ]; then
    echo "$ERL_HOME/$1 is not found."
    return
  fi
  echo "setting $1 as current otp..."
  rm $ERL_HOME/current
  ln -s $ERL_HOME/$1 $ERL_HOME/current
}

function erlenv {
  case "$1" in
    list)
      _erlenv_list
      ;;
    "set")
      _erlenv_set $2
      ;;
    *)
      _erlenv_current
  esac
}

safety_source $HOME/dotfiles/oh-my-zshrc
[ `uname` = "Darwin" ] && safety_source $(brew --prefix autojump)/etc/autojump.sh

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
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward


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
fpath=(~/dotfiles/zsh/lib/zsh-completions/src/ $fpath)
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

safety_source $HOME/.zprofile.local
safety_source $HOME/.perlbrew/etc/bashrc

safety_source `which virtualenvwrapper.sh`

safety_source $HOME/.nvm/nvm.sh
