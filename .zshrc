fpath+=${ZDOTDIR:-~}/.zsh_functions
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  fpath=($fpath ~/.zsh/completion)

  autoload -Uz compinit
  compinit
fi


# kubectl completions
if command -v kubectl &>/dev/null; then
  source <(kubectl completion zsh)
fi

# Rust things
if [[ -d "$HOME.cargo/bin" ]]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

# my custom scripts
if [[ -d "$HOME/.dacbd/bin" ]]; then
  export PATH="$HOME/.dacbd/bin:$PATH"
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


# uv is probably better for python now
# https://docs.astral.sh/uv/#highlights 
if [[ -d "$HOME/.local/bin" ]]; then
  export PATH="$HOME/.local/bin:$PATH"
  source $HOME/.local/bin/env
fi

# pyenv things
# brew install pyenv
if [[ -d "$HOME/.pyenv" && ! -x "$(command -v uv)" ]]; then
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

. "$HOME/.local/bin/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$HOME/go/bin:$PATH"
export GOARCH=arm64
export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# pnpm
export PNPM_HOME="/Users/dacbd/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
