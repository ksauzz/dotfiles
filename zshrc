if [ -f ~/.profile ]; then
	. ~/.profile
fi

## Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8

## Default shell configuration
#
# set prompt
#
case ${UID} in
0)
    PROMPT="%B%{[31m%}%/#%{[m%}%b "
    PROMPT2="%B%{[31m%}%_#%{[m%}%b "
    SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%{[m%}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
*)
    PROMPT="%{[31m%}%/%%%{[m%} "
    PROMPT2="%{[31m%}%_%%%{[m%} "
    SPROMPT="%{[31m%}%r is correct? [n,y,a,e]:%{[m%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
esac

# auto change directory
#
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

# command correct edition before each completion attempt
#
setopt correct

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

#
# Show branch name in Zsh's right prompt
#   https://gist.github.com/214109
case "${OSTYPE}" in
freebsd*|darwin*)
autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

function rprompt-git-current-branch {
        local name st color gitdir action
        if [[ "$PWD" =~ '/¥.git(/.*)?$' ]]; then
                return
        fi
        name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
        if [[ -z $name ]]; then
                return
        fi

        gitdir=`git rev-parse --git-dir 2> /dev/null`
        action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"

        st=`git status 2> /dev/null`
        if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
                color=%F{green}
        elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
                color=%F{yellow}
        elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
                color=%B%F{red}
        else
                 color=%F{red}
         fi
              
        echo "$color$name$action%f%b "
}

setopt prompt_subst
;;
esac

RPROMPT='[`rprompt-git-current-branch`%~]'

# rvm configuration
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# JAVA_HOME 
if [ ! -z "$JAVA_HOME" ]; then
  return
fi
expected_java_home="
/opt/jdk
/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home
/usr/java/default
/usr/java/current
/usr/local/java
"
for dir in $expected_java_home; do
  if [ -x $dir/bin/java ]; then
    JAVA_HOME=$dir
    break
  fi
done

# User specific aliases and functions

case "${OSTYPE}" in
freebsd*|darwin*)
alias ls="ls -G -w"
;;
linux*)
alias ls="ls --color"
;;
esac

alias ll='ls -l'
alias la='ls -a'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias h=history
alias diff=colordiff
alias grep='grep --color=auto'
alias info='info --vi-keys'
alias scala='scala -Dfile.encoding=UTF-8'
alias zsrc='source ~/.zshrc'

export PYTHONPATH=/usr/local/mercurial/lib/python2.6/site-packages/

export RUBY_HOME=/usr/local/ruby
export M2_HOME=/usr/local/maven
export M2_REPO=$HOME/.m2/repository
export MAVEN_OPTS="-Dfile.encoding=UTF-8"
export EDITOR=vim

export PATH=/opt/local/bin:/opt/local/sbin:$PATH  #macports requirements

export PATH=~/dotfiles/usr/bin:$PATH
export PATH=/usr/local/vim/bin:$PATH
export PATH=/usr/local/ctags/bin:$PATH
export PATH=/usr/local/screen/bin:$PATH
export PATH=/usr/local/maven/bin:$PATH
export PATH=/usr/local/memcached/bin:$PATH
export PATH=$RUBY_HOME/bin:$PATH
export PATH=$JAVA_HOME/bin:$PATH
export PATH=$PATH:/usr/local/zeromq/bin/
export PATH=$PATH:/usr/local/bind/sbin
export PATH=$PATH:/usr/local/mysql/bin
export PATH=$PATH:/usr/local/apache/bin
export PATH=$PATH:/usr/local/scala/bin
export PATH=$PATH:/usr/local/git/bin
export PATH=$PATH:/usr/local/openvpn/sbin
export PATH=$PATH:/usr/local/clamXav/bin
export PATH=$PATH:/usr/local/play
export PATH=$PATH:/usr/local/mercurial/bin
export PATH=$PATH:/usr/local/sbt/bin
export PATH=$PATH:/usr/local/tig/bin
export PATH=$PATH:/usr/local/jmeter/bin
export PATH=$PATH:/usr/local/mongodb/bin
export PATH=$PATH:/usr/local/erlang/bin/
export PATH=$PATH:/usr/local/rabbitmq/sbin/
export PATH=$PATH:/usr/local/p4/bin/
export PATH=$PATH:/usr/local/Gauche/bin/
export PATH=$PATH:/usr/local/redis/bin/
export PATH=$PATH:/usr/local/thrift/bin


export MANPATH=~/dotfiles/usr/share/man:$MANPATH
export MANPATH=/usr/local/zeromq/share:$MANPATH
export MANPATH=/usr/local/git/share:$MANPATH
export MANPATH=/usr/local/mysql/share:$MANPATH
export MANPATH=/opt/local/share/man:$MANPATH
export MANPATH=/usr/local/rabbitmq/share/man:$MANPATH
export MANPATH=/usr/local/screen/share/man:$MANPATH

