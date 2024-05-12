fpath+=${ZDOTDIR:-~}/.zsh_functions
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  fpath=($fpath ~/.zsh/completion)

  autoload -Uz compinit
  compinit
fi

# my alias setup
alias python='python3'
alias vim='nvim'
alias code='VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $*'

if [[ -d "$HOME/.local/bin" ]]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

# smart card ssh
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent


# pyenv things
if [[ -d "$HOME/.pyenv" ]]; then
  export PYENV_ROOT="$HOME/.pyenv"
  command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

