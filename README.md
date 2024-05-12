# dotfiles
not much to see here...

## Stow usage

### install

- macos: `brew install stow`

### usage

Only execute `stow` in the root dir of the repo: `~/dotfiles`
It will symlink the contents to the parent dir `~/`


When using `stow --adopt .` it will:
- move conflicting files into the repo.
- symlink files back to the parent dir(`~/`)
- it will overwrite the files present in the repo (so commit before hand)



# Notes

## SSH/GPG/yubikey things

be sure to import the public keys:
```bash
# download
wget https://github.com/dacbd.gpg
# import
gpg --import dacbd.gpg
# verify
gpg -k
```
