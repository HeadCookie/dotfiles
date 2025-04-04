# My dotfiles

This directory contains the dotfiles for my system

## Requirements

Ensure you have the following installed on your system

### Git

```bash
brew install git
```

### Stow

```bash
brew install stow
```

## Installation

First, check out the dotfiles repo in your $HOME directory using git

```bash
git clone git@github.com/headcookie/dotfiles.git
cd dotfiles
```

then use GNU stow to create symlinks

```bash
stow .
```

in case of conflict you can use

```bash
stow --adopt .
```

For reference checkout [this youtube video](https://www.youtube.com/watch?v=y6XCebnB9gs) from youtuber Dreams of Autonomy/Code

## Some of the tools I use

### Desktop

- [Sketchybar](github.com/FelixKratz/Sketchybar)
  - Custom toolbar to replace the default in MacOS.
- [Aerospace](https://github.com/nikitabobko/AeroSpace)
  - Tiling window manager for MacOS

  [Reference](https://github.com/forteleaf/sketkchybar-with-aerospace)

### Terminal

- [ghostty](https://github.com/ghostty-org/ghostty)
  - terminal emulator
- [tmux](https://github.com/tmux/tmux)
  - terminal multiplexer
- [neovim](https://github.com/neovim/neovim)
  - Text editor more specifically the [LazyVim](lazyvim.org) distribution
