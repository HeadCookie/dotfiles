# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# if [ -z "$TMUX" ]; then
#   exec tmux new-session -A
# fi
#
# SET directory for zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# If zinit is not already install we install it
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone git@github.com:zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Load/source zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Mac or linux homebrew install
if [[ "$(uname)" != "Darwin" ]]; then
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [ -f $(brew --prefix)/etc/brew-wrap ];then
  source $(brew --prefix)/etc/brew-wrap
fi

export EDITOR=nvim

# Add in zsh plugins
if [[ "$(uname)" != "Darwin" ]]; then
	zinit light zsh-users/zsh-syntax-highlighting
	zinit light zsh-users/zsh-completions
else
	zinit ice proto=ssh; zinit light zsh-users/zsh-syntax-highlighting
	zinit ice proto=ssh; zinit light zsh-users/zsh-completions
fi
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions

# Add sippets
zinit snippet OMZP::brew
zinit snippet OMZP::composer
zinit snippet OMZP::git
zinit snippet OMZP::golang
zinit snippet OMZP::npm
zinit snippet OMZP::nvm

# Load completions
autoload -U compinit && compinit
zinit cdreplay -q
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Key bindings
bindkey -v
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^I' fzf-tab-complete

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color -lh'
alias lzd='lazydocker'
alias lg='lazygit'
alias c='clear'
alias dotnet64=/usr/local/share/dotnet/x64/dotnet
alias shrug="echo '¯\\_(ツ)_/¯' && echo '¯\\_(ツ)_/¯' | pbcopy"
alias vim="nvim"
alias dot="cd ~/dotfiles && vim ."
alias config='/usr/bin/git --git-dir=/Users/jorgenjensen/.cfg/ --work-tree=/Users/jorgenjensen'
alias lgc='lazygit --git-dir=$HOME/.cfg --work-tree=$HOME'
alias dc='docker compose'
# alias cat="bat"

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(thefuck --alias)"
eval "$(direnv hook zsh)"
eval "$(jenv init -)"

# Manually enable-fzf-tab on Ubuntu
enable-fzf-tab

# Exports
export CLASSPATH="</Users/jorgenjensen/repos/cs61b/library-sp24>:$CLASSPATH"
export PATH="$HOME/bin:$PATH"
export PATH=$PATH:/Users/jorgenjensen/Library/Python/3.9/bin
export NVM_LAZY=1

export XDG_CONFIG_HOME="$HOME/.config"
export PATH="/opt/homebrew/opt/php@8.1/bin:$PATH"
export PATH="/opt/homebrew/opt/php@8.1/sbin:$PATH"
export PATH=$PATH:/opt/homebrew/Cellar/pcre2/10.42/include
export VISUAL=nvim
export EDITOR="$VISUAL"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin
export PENNEO_DOCKER_HOST_IP=10.254.254.254
export PATH="$HOME/.local/bin:$PATH"
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk@21/include"
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$DOTNET_ROOT:$PATH
export GPG_TTY=$(tty)
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="$PATH:/opt/homebrew/lib/ruby/gems/3.3.0/bin"

vv() {
  # Assumes all configs exist in directories named ~/.config/nvim-*
  local config=$(fd --max-depth 1 --glob 'nvim*' ~/.config | fzf --prompt="Neovim Configs > " --height=~50% --layout=reverse --border --exit-0)
 
  # If I exit fzf without selecting a config, don't open Neovim
  [[ -z $config ]] && echo "No config selected" && return
 
  # Open Neovim with the selected config
  NVIM_APPNAME=$(basename $config) nvim $@
}
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  tmux attach-session -t default || tmux new-session -s default
fi


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
