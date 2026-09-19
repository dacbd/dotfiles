#! /bin/bash

brew tap hashicorp/tap
brew install stow \
    starship \
    font-hack-nerd-font \
    wget \
    gum \
    jq \
    neovim \
    luarocks \
    tmux \
    gnupg \
    sops \
    pinentry-mac \
    cmake \
    kind \
    derailed/k9s/k9s \
    argocd \
    podman \
    hashicorp/tap/terraform \
    azure-cli \
    helm \
    cmctl \
    pyenv \
    btop \
    ripgrep
brew install --cask zedbrew install --cask zed
brew install --cask ghostty

# Install pup (datadog)
brew trust datadog-labs/pack
brew tap datadog-labs/pack
brew install datadog-labs/pack/pup

