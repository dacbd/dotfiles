# dotfiles
not much to see here...

Bootstraping the setup:
- Install [Brew](https://brew.sh) `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
- Install [Rust](https://doc.rust-lang.org/cargo/getting-started/installation.html) `curl https://sh.rustup.rs -sSf | sh`
- Install [Go](https://go.dev/doc/install)
- Install [Alacritty](https://alacritty.org)
    - Install [Delta](https://dandavison.github.io/delta/installation.html) `cargo install git-delta`
- Install [Node](https://nodejs.org/en/download/source-code)
- Install [Deno](https://docs.deno.com/runtime/getting_started/installation/)


Base Brew installs.
```bash
brew tap hashicorp/tap
brew install stow \
    font-hack-nerd-font \
    wget \
    gum \
    jq \
    neovim \
    luarocks \
    tmux \
    gnupg \
    pinentry-mac \
    cmake \
    kind \
    derailed/k9s/k9s \
    podman \
    hashicorp/tap/terraform \
    azure-cli \
    helm \
    cmctl
brew install --cask zedbrew install --cask zed
```

`git submodule update --init --recursive`
## Stow usage

### install

- macos: `brew install stow`

### usage

Only execute `stow` in the root dir of the repo: `~/dotfiles`
It will symlink the contents to the parent dir `~/`

So run `stow .`

When using `stow --adopt .` it will:
- move conflicting files into the repo.
- symlink files back to the parent dir(`~/`)
- it will overwrite the files present in the repo (so commit before hand)



# Notes

## SSH/GPG/yubikey things
- `brew install gnupg pinentry-mac`

be sure to import the public keys:
```bash
# download
wget https://github.com/dacbd.gpg
# import
gpg --import dacbd.gpg
# verify
gpg -k
```


# CLI tools
todo auto install/bootstrap

- https://helm.sh/docs/intro/install/

# nvim
- https://lazy.folke.io/installation
- https://github.com/nvim-treesitter/nvim-treesitter
- https://github.com/neovim/nvim-lspconfig
- https://github.com/folke/tokyonight.nvim
- https://github.com/echasnovski/mini.nvim
- https://github.com/tpope/vim-sleuth

