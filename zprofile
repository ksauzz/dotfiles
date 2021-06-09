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
## pyenv configuration
if [ -d ~/.pyenv ]; then
  export PYENV_ROOT=~/.pyenv
  export PATH=$PYENV_ROOT/bin:$PATH
  eval "$(pyenv init --path)"
fi
## exenv configuration
if [ -d ~/.exenv ]; then
  export EXENV_ROOT=~/.exenv
  export PATH=$EXENV_ROOT/bin:$PATH
  eval "$(exenv init - zsh)"
fi

export PATH="$HOME/.cargo/bin:$PATH"
