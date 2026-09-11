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
    starship \
    font-hack-nerd-font \
    wget \
    gum \
    jq \
    neovim \
    tree-sitter-cli \
    luarocks \
    tmux \
    gnupg \
    sops \
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
brew install --cask ghostty

# https://github.com/robscott/kube-capacity
brew tap robscott/tap
brew install robscott/tap/kube-capacity
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


## SOPS with PGP and YubiKey

Install with `brew install sops gnupg pinentry-mac` (also included in the
bootstrap script). Import the public keys on each machine:

```bash
curl -fsSL https://github.com/dacbd.gpg -o /tmp/dacbd-public.gpg
gpg --import /tmp/dacbd-public.gpg
gpg --fingerprint
```

The repo's `.sops.yaml` encrypts `*.sops.yaml`, `*.sops.yml`, `*.sops.json`,
`*.sops.env`, `*.sops.ini`, and `*.sops.txt` files to these primary fingerprints
from GitHub (2026-09-10). GnuPG selects their encryption subkeys:

- `BD21EB682F56D1465A59484866D6BAAC0D9ADEE0`
- `5961843D4E1BE41DAE82244F760B1BB84FB56E9E`
- `7F6CD1E06202132DA96A7275D9AC08EFCA88669E`

Any one matching encryption private key can decrypt. For a YubiKey, insert the
card and run `gpg --card-status` to register its keys with GnuPG. SOPS uses GnuPG
and gpg-agent to decrypt with the card; enter the PIN and touch the key if
requested. The card must contain one of the matching **encryption** subkeys;
an SSH authentication key alone is insufficient. The existing dotfiles configure
`pinentry-mac`, gpg-agent, and `GPG_TTY`.

Run from the repo root:

```bash
# Create or edit an encrypted file (requires a matching private key/YubiKey).
sops edit secrets.sops.yaml

# Decrypt to stdout.
sops decrypt secrets.sops.yaml

# Encrypt an existing plaintext file using only the public keys.
sops encrypt --filename-override secrets.sops.yaml \
    --output secrets.sops.yaml /path/outside/repo/secrets.yaml
```

Keep plaintext secrets and private keys outside this repository, and commit only
encrypted files. The filename convention selects recipients; it does not
implicitly encrypt files when saved or committed.

Recipients are pinned in `.sops.yaml`; GitHub changes are not fetched during
encryption. To change recipients, download and import the updated public keys,
review their fingerprints, update the `pgp` list, then run
`sops updatekeys path/to/file.sops.yaml` for each encrypted file with an existing
matching private key available. This also migrates existing age-encrypted files,
but requires their original age/SSH private key to decrypt first. If removing a
recipient, also run `sops rotate --in-place path/to/file.sops.yaml` afterward to
replace the data key. Old versions in Git history remain decryptable by old
recipients.

See the [SOPS documentation](https://getsops.io/docs/) for more usage details.

# CLI tools
todo auto install/bootstrap

- https://helm.sh/docs/intro/install/
- https://docs.astral.sh/uv/getting-started/installation/
- https://viteplus.dev/guide/#install-vp

# nvim
- https://lazy.folke.io/installation
- https://github.com/nvim-treesitter/nvim-treesitter
- https://github.com/neovim/nvim-lspconfig
- https://github.com/folke/tokyonight.nvim
- https://github.com/echasnovski/mini.nvim
- https://github.com/tpope/vim-sleuth
