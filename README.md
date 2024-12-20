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

- [SKHD](https://github.com/koekeishiya/skhd)
  - Hotkey daemon i.e. let's you do custom keymaps - highly neccessary to get the most out of yabai.
- [Sketchybar](github.com/FelixKratz/Sketchybar)
  - Custom toolbar to replace the default in MacOS. Works nicely with Yabai. The configuration is more less copied directly from the creator's own [dotfiles](https://github.com/FelixKratz/dotfiles/tree/b098d399f45f4d6209fdfaa4324919560d4f555e)
- [Yabai](https://github.com/koekeishiya/yabai)

  - Window manager for MacOS

### Terminal

- [alacritty](https://github.com/alacritty/alacritty)
  - terminal emulator
- [tmux](https://github.com/tmux/tmux)
  - terminal multiplexer
- [neovim](https://github.com/neovim/neovim)
  - Text editor more specifically the [LazyVim](lazyvim.org) distribution
