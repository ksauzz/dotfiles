# based on cloud.zsh-theme
# vim:ft=sh
function cached_env_prompt {
  if which $1 &> /dev/null; then
    cache_dir=/tmp/prompt_cache
    mkdir -p $cache_dir
    cache_file=$cache_dir/$1 
    if [ $(find $cache_dir -name $1 -mmin -5 | wc -l) -eq 0 ]; then
      $1 version | sed -e 's/ (.*)//' | xargs > $cache_file
    fi
    cat $cache_file
  else
    echo ""
  fi
}

function rbenv_prompt_info {
  echo "💎  $(cached_env_prompt rbenv) "
}

function pyenv_prompt_info {
  echo "🐍  $(cached_env_prompt pyenv) "
}

function kube_prompt_info {
  type kubectl >/dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo "(☸ $(kubectl config current-context 2>/dev/null): $(kubectl config view --minify -o jsonpath='{..namespace}' 2>/dev/null))"
  fi
}

function erlenv_prompt_info {
  if which _erlenv_current &> /dev/null; then
    echo "$(_erlenv_current | sed -e 's/current: //')"
  else if
    echo ""
  fi
}

function gopath_prompt_info {
  if [ "$GOPATH" != "" ]; then
    echo "<$GOPATH>" | sed "s|$HOME|~|"
  fi
}

PROMPT='\
%{$fg_bold[blue]%}%n@%m%{$fg_bold[cyan]%}☁ %{$fg_bold[green]%}%p%{$fg[green]%}%~ \
$(pyenv_prompt_info)%{$fg[green]%}\
%{$fg_bold[magenta]%}$(kube_prompt_info) \
%{$fg_bold[cyan]%}$(git_prompt_info)\
'$'\n''\
%{$fg_bold[blue]%}%% %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}[%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}] %{$fg[yellow]%}⚡%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}]"
