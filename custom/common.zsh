# Shared across all platforms
alias reload='source ~/.zshrc'
unsetopt autocd

# pyenv initialization
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# General aliases
alias song-dl="youtube-dl -x --audio-format m4a "

# GPG needs the current tty for pinentry
export GPG_TTY=$(tty)
