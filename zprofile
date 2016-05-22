## rbenv configuration
if [ -d ~/.rbenv ]; then
  export PATH=~/.rbenv/bin:$PATH
  eval "$(rbenv init - zsh)"
fi
## phpenv configuration
if [ -d ~/.phpenv ]; then
  export PATH=~/.phpenv/bin:$PATH
  eval "$(phpenv init - zsh)"
fi
