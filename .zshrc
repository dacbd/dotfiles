fpath+=${ZDOTDIR:-~}/.zsh_functions
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  fpath=($fpath ~/.zsh/completion)

  autoload -Uz compinit
  compinit
fi

# Rust things
# brew install rust
if [[ -d "$HOME.cargo/bin" ]]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

# my alias setup
alias python='python3'
alias vim='nvim'
alias code='VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $*'

if [[ -d "$HOME/.local/bin" ]]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

# some go path stuff
if [[ -d "$HOME/go/bin" ]]; then
  export PATH="$HOME/go/bin:$PATH"
fi

# smart card ssh
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent


# fzf fuzzy findings
# brew install fzf
if [[ -x "$(command -v fzf)" ]]; then
  eval "$(fzf --zsh)"
fi


# pyenv things
# brew install pyenv
if [[ -d "$HOME/.pyenv" ]]; then
  export PYENV_ROOT="$HOME/.pyenv"
  command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

# kubctl/krew
if [[ -d "$HOME/.krew" ]]; then
  export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/dacbd/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/dacbd/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/dacbd/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/dacbd/google-cloud-sdk/completion.zsh.inc'; fi
