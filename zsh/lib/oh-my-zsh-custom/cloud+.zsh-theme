# based on cloud.zsh-theme
# vim:ft=sh
function rbenv_prompt_info {
  if which rbenv &> /dev/null; then
    echo "$(rbenv version | sed -e 's/ (.*)//') "
  else if
    echo ""
  fi
}

PROMPT='%{$fg_bold[blue]%}%n@%m%{$fg_bold[cyan]%}☁ %{$fg_bold[green]%}%p%{$fg[green]%}%~ %{$fg_bold[blue]%}$(rbenv_prompt_info)%{$fg_bold[cyan]%}$(git_prompt_info)'$'\n''%{$fg_bold[blue]%}%% %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}[%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}] %{$fg[yellow]%}⚡%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}]"
