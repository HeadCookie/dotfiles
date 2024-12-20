if [[ "$(uname)" != "Darwin" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [ -s "$HOME/.nvm/nvm.sh" ]; then
    . "$HOME/.nvm/nvm.sh" # This loads nvm
fi

# Add .NET Core SDK tools
export PATH="$PATH:/Users/jorgenjensen/.dotnet/tools"
