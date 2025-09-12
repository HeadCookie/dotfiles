# ------------------------------------------------------------------------------
# 1. POWERLEVEL10K INSTANT PROMPT
# ------------------------------------------------------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ------------------------------------------------------------------------------
# 2. ZINIT PLUGIN MANAGER
# ------------------------------------------------------------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# ------------------------------------------------------------------------------
# 3. EXPORTS & ENVIRONMENT
# ------------------------------------------------------------------------------
export EDITOR='nvim'
export MANPAGER="nvim +Man!"
export VISUAL="$EDITOR"
export GPG_TTY=$(tty)
export TERM=xterm-256color

export PATH="$HOME/.jenv/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH="$HOME/go/bin/:$PATH"
export PATH="$HOME/Library/Python/3.9/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"
export PATH=$PATH:/opt/homebrew/Cellar/pcre2/10.42/include
export PATH="$DOTNET_ROOT:$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="$PATH:/opt/homebrew/lib/ruby/gems/3.3.0/bin"
export PATH="/opt/homebrew/opt/php@8.1/bin:$PATH"
export PATH="/opt/homebrew/opt/php@8.1/sbin:$PATH"
export PENNEO_DOCKER_HOST_IP=10.254.254.254

# Tool-specific exports
export PYENV_ROOT="$HOME/.pyenv"
export ANDROID_HOME=$HOME/Library/Android/sdk
export DOTNET_ROOT=$HOME/.dotnet
export TMS_CONFIG_FILE=$HOME/.config/tms/config.toml
export PATH="$PATH:/Users/jorgenjensen/.lmstudio/bin"


# ------------------------------------------------------------------------------
# 4. PLUGINS
# ------------------------------------------------------------------------------
# Theme
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions
function zvm_after_init() {
  zvm_bindkey viins '^Y' autosuggest-accept
  ZVM_KEYTIMEOUT=0
}
zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode

# Snippets
zinit snippet OMZP::brew
zinit snippet OMZP::composer
zinit snippet OMZP::git
zinit snippet OMZP::golang
zinit snippet OMZP::npm
zinit snippet OMZP::nvm
zinit snippet OMZP::node
zinit snippet OMZP::direnv

# ------------------------------------------------------------------------------
autoload -U compinit

local zcomp_cache="${ZDOTDIR:-$HOME}/.zcompdump"

if [[ -f "$zcomp_cache" ]]; then
  local mod_time=$(stat -f %m "$zcomp_cache")
  local now=$(date +%s)
  if (( (now - mod_time) > 86400 )); then
    compinit
  else
    compinit -C
  fi
else
  compinit
fi

zinit cdreplay -q

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
enable-fzf-tab

# ------------------------------------------------------------------------------
# 6. SHELL HOOKS & LAZY LOADING
# ------------------------------------------------------------------------------
# NVM (Lazy Loaded)
export NVM_DIR="$HOME/.nvm"
nvm() { unset -f nvm node npm; [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"; nvm "$@"; }
node() { nvm use --lts &>/dev/null; node "$@"; }
npm() { nvm use --lts &>/dev/null; npm "$@"; }

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
if [ -f $(brew --prefix)/etc/brew-wrap ];then
  source $(brew --prefix)/etc/brew-wrap
fi

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(thefuck --alias)"
export DIRENV_LOG_FORMAT=""
eval "$(direnv hook zsh)"
eval "$(jenv init -)"

# ------------------------------------------------------------------------------
# 7. ALIASES & FUNCTIONS
# ------------------------------------------------------------------------------
alias ls='ls --color=auto -lh'
alias lzd='lazydocker'
alias lg='lazygit'
alias c='clear'
alias dot="cd ~/dotfiles && nvim ."
alias dotnet64=/usr/local/share/dotnet/x64/dotnet
alias shrug="echo '¯\\_(ツ)_/¯' && echo '¯\\_(ツ)_/¯' | pbcopy"
alias config='/usr/bin/git --git-dir=/Users/jorgenjensen/.cfg/ --work-tree=/Users/jorgenjensen'
alias lgc='lazygit --git-dir=$HOME/.cfg --work-tree=$HOME'
alias dc='docker compose'

vv() {
  local config=$(fd --max-depth 1 --glob 'nvim*' ~/.config | fzf --prompt="Neovim Configs > " --height=~50% --layout=reverse --border --exit-0)
  [[ -z $config ]] && echo "No config selected" && return
  NVIM_APPNAME=$(basename $config) nvim "$@"
}

# Fixing the root cause has failed. Let's patch the fat finger issue instead
vim() {
  if [[ "$1" == "," && "$#" -eq 1 ]]; then
    command nvim .
  else
    command nvim "$@"
  fi
}

# ------------------------------------------------------------------------------
# 8. KEYBINDINGS & HISTORY
# ------------------------------------------------------------------------------
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^I' fzf-tab-complete
KEYTIMEOUT=1

HISTSIZE=5000
SAVEHIST=5000
HISTDUP=erase
HISTFILE=~/.zsh_history
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups hist_save_no_dups hist_ignore_dups hist_find_no_dups

# ------------------------------------------------------------------------------
# 9. POWERLEVEL10K CONFIG & TMUX
# ------------------------------------------------------------------------------
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Auto-start tmux
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  tmux attach-session || tmux new-session -s dotfiles
fi


