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
alias la='ls -al'
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

export ERL_LIBS=$ERL_LIBS:/usr/local/eqc/

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
