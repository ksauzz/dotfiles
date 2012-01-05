# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="dst"

# Set to this to use case-sensitive completion
export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git svn git-flow gem osx ruby github brew macports)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
if [ -f ~/.profile ]; then
	. ~/.profile
fi

## Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8

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

# rvm configuration
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

#rbenv configuration
export PATH=~/.rbenv/bin:$PATH
eval "$(rbenv init -)"

# JAVA_HOME 
expected_java_home=(
/opt/jdk
/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home
/usr/java/default
/usr/java/current
/usr/local/java
)
for dir in $expected_java_home; do
  if [ -x $dir/bin/java ]; then
    export JAVA_HOME=$dir
    break
  fi
done

# User specific aliases and functions

case "${OSTYPE}" in
freebsd*|darwin*)
alias ls="ls -G -w"
alias top="top -o cpu"
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
alias v=vim
alias h=history
alias diff=colordiff
alias grep='grep --color=auto'
alias info='info --vi-keys'
alias scala='scala -Dfile.encoding=UTF-8'
alias zsrc='source ~/.zshrc'
alias javac='javac -J-Dfile.encoding=UTF-8'
alias java='java -Dfile.encoding=UTF-8'
#alias jar='jar -Dfile.encoding=UTF-8'
alias ipgrep="grep -E '[0-9]{1,3}(\.[0-9]{1,3}){3}'"

export PYTHONPATH=/usr/local/mercurial/lib/python2.6/site-packages/

export LUA_CPATH="/usr/local/lib/luarocks/lib/lua/5.1//?.so;$LUA_PATH"
export LUA_PATH="/usr/local/lib/luarocks/share/lua/5.1//?.lua;$LUA_PATH"
export LUA_INIT="require 'luarocks.require'"

export RUBY_HOME=/usr/local/ruby
export ORA_HOME=/usr/local/sqlplus
export M2_HOME=/usr/local/maven
export M2_REPO=$HOME/.m2/repository
export MAVEN_OPTS="-Dfile.encoding=UTF-8"
export EDITOR=vim
export MANPAGER="less"

export PATH=/usr/local/bin:$PATH
export PATH=/opt/local/bin:/opt/local/sbin:$PATH  #macports requirements

export PATH=~/dotfiles/usr/bin:$PATH
export PATH=/usr/local/vim/bin:$PATH
export PATH=/usr/local/ctags/bin:$PATH
export PATH=/usr/local/screen/bin:$PATH
export PATH=/usr/local/maven/bin:$PATH
export PATH=/usr/local/memcached/bin:$PATH
export PATH=$RUBY_HOME/bin:$PATH
export PATH=$JAVA_HOME/bin:$PATH
export PATH=$PATH:~/.cabal/bin/
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
export PATH=$PATH:/usr/local/hadoop/bin
export PATH=$PATH:/usr/local/kyototycoon/bin
export PATH=$PATH:/usr/local/riak/bin
export PATH=$PATH:/usr/local/gtags/bin
export PATH=$PATH:/usr/local/ruby-build/bin

export PATH=$PATH:$ORA_HOME/bin

export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$ORA_HOME/lib

export MANPATH=~/dotfiles/usr/share/man:$MANPATH
export MANPATH=/usr/local/zeromq/share:$MANPATH
export MANPATH=/usr/local/git/share:$MANPATH
export MANPATH=/usr/local/mysql/share:$MANPATH
export MANPATH=/opt/local/share/man:$MANPATH
export MANPATH=/usr/local/rabbitmq/share/man:$MANPATH
export MANPATH=/usr/local/screen/share/man:$MANPATH
export MANPATH=/usr/local/erlang/share/man:$MANPATH
export MANPATH=/usr/local/gtags/share/man:$MANPATH
export MANPATH=/usr/local/tig/share/man:$MANPATH

# zaw https://github.com/zsh-users/zaw
source ~/dotfiles/zsh/lib/zaw/zaw.zsh

# oracle SQL*Plus setting
export NLS_LANG='Japanese_Japan.UTF8'
