# dotfiles

Personal configuration files for macOS.

## Installation

```bash
git clone git@github.com:HeadCookie/dotfiles.git ~/dotfiles
cd ~/dotfiles
brew install stow
stow .
```

If conflicts occur:
```bash
stow --adopt .
```

## Tools

- aerospace - window manager
- ghostty - terminal
- tmux - terminal multiplexer
- neovim - editor
- starship - shell prompt
