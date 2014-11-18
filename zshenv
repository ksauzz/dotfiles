## rbenv configuration
export PATH=~/.rbenv/bin:$PATH
eval "$(rbenv init - zsh)"
## phpenv configuration
export PATH=~/.phpenv/bin:$PATH
eval "$(phpenv init - zsh)"

# LANG
export LANG=ja_JP.UTF-8

# oracle SQL*Plus setting
export NLS_LANG='Japanese_Japan.UTF8'

REPORTTIME=3

# JAVA_HOME
expected_java_home=(
`/usr/libexec/java_home 2>&1`
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

export PYTHONPATH=/usr/local/mercurial/lib/python2.6/site-packages/

export PERLBREW_ROOT=~/.perlbrew

# Macports
export PORTS_HOME=/usr/local/macports
export PATH=$PORTS_HOME/bin:$PORTS_HOME/sbin:$PATH
export MANPATH=$PORTS_HOME/share/man:$MANPATH

# LUA
export LUA_CPATH="/usr/local/lib/luarocks/lib/lua/5.1//?.so;$LUA_PATH"
export LUA_PATH="/usr/local/lib/luarocks/share/lua/5.1//?.lua;$LUA_PATH"
export LUA_INIT="require 'luarocks.require'"

# autojump
export AUTOJUMP_KEEP_SYMLINKS=1

export PGDATA=/var/lib/postgres/

export RUBY_HOME=/usr/local/ruby
export ORA_HOME=/usr/local/sqlplus
export M2_HOME=/usr/local/maven
export M2_REPO=$HOME/.m2/repository
export MAVEN_OPTS="-Dfile.encoding=UTF-8"
export EDITOR=vim
export MANPAGER="less"

export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/opt/local/bin:$PATH

export PATH=~/bin:$PATH
export PATH=~/dotfiles/usr/bin:$PATH
export PATH=/usr/local/vim/bin:$PATH
export PATH=/usr/local/ctags/bin:$PATH
export PATH=/usr/local/screen/bin:$PATH
export PATH=/usr/local/maven/bin:$PATH
export PATH=/usr/local/memcached/bin:$PATH
export PATH=/usr/local/Cellar/ccache/3.1.8/libexec:$PATH
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
export PATH=/usr/local/sbt/bin:$PATH
export PATH=/usr/local/sbt7/bin:$PATH
export PATH=$PATH:/usr/local/tig/bin
export PATH=$PATH:/usr/local/jmeter/bin
export PATH=$PATH:/usr/local/mongodb/bin
export PATH=$PATH:/usr/local/erlang/current/bin/
export PATH=$PATH:/usr/local/rabbitmq/sbin/
export PATH=$PATH:/usr/local/p4/bin/
export PATH=$PATH:/usr/local/Gauche/bin/
export PATH=$PATH:/usr/local/redis/bin/
export PATH=$PATH:/usr/local/thrift/bin
export PATH=$PATH:/usr/local/hadoop/bin
export PATH=$PATH:/usr/local/kyototycoon/bin
export PATH=$PATH:/usr/local/riak/bin
export PATH=$PATH:/usr/local/gtags/bin
export PATH=$PATH:/usr/local/ejabberd/sbin/
export PATH=$PATH:/usr/local/zeromq/share
export PATH=$PATH:/usr/local/homebrew/bin
export PATH=$PATH:/usr/local/share/npm/bin
export PATH=$PATH:/usr/local/haproxy/sbin
export PATH=$PATH:/usr/local/nginx/sbin
export PATH=$PATH:/usr/local/mongo/bin
export PATH=/usr/local/heroku/bin:$PATH
export PATH=$PATH:/usr/local/s3fs/bin

export ERL_LIBS=$ERL_LIBS:/usr/local/eqc/
export ERL_LIBS=$ERL_LIBS:/usr/local/sync/

export PATH=$PATH:$ORA_HOME/bin

# Setting C_INCLUDE_PATH cauases Ruby build issue.
#export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$ORA_HOME/lib
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/zmq/lib
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/libs3-2.0/lib/
#export C_INCLUDE_PATH=$C_INCLUDE_PATH:/usr/local/libs3-2.0/include/

export MANPATH=/usr/share/man:$MANPATH
export MANPATH=/opt/local/share/man:$MANPATH
export MANPATH=/usr/local/share/man:$MANPATH
export MANPATH=~/dotfiles/usr/share/man:$MANPATH
export MANPATH=/usr/local/zeromq/share:$MANPATH
export MANPATH=/usr/local/git/share:$MANPATH
export MANPATH=/usr/local/mysql/share:$MANPATH
export MANPATH=/usr/local/rabbitmq/share/man:$MANPATH
export MANPATH=/usr/local/screen/share/man:$MANPATH
export MANPATH=/usr/local/erlang/current/share/man:$MANPATH
export MANPATH=/usr/local/gtags/share/man:$MANPATH
export MANPATH=/usr/local/tig/share/man:$MANPATH
export MANPATH=/usr/local/zmq/share/man:$MANPATH
export MANPATH=/usr/local/haproxy/share/man:$MANPATH

