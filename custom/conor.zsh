alias reload='source ~/.zshrc'
unsetopt autocd

# pyenv stuff
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# convenience
# from https://apple.stackexchange.com/questions/15318/how-to-use-terminal-to-copy-a-file-to-the-clipboard
file-to-clipboard() {
    osascript \
        -e 'on run args' \
        -e 'set the clipboard to POSIX file (first item of args)' \
        -e end \
        "$@"
}

alias song-dl="youtube-dl -x --audio-format m4a "
alias vinterp="/Users/conorhayes/usr/local/cain-ncnn-vulkan-20220728-macos/cain-ncnn-vulkan"
alias update-cli="pip install /Users/conorhayes/project/clitools"
alias clis="/Users/conorhayes/project/clitools/venv/bin/python /Users/conorhayes/project/clitools/clitools/main.py"

alias project="pushd /Users/conorhayes/project"

# gpg setup
export GPG_TTY=$(tty)

# manual path thing cuz docker desktop install didnt do the thing
export PATH=$PATH:/Applications/Docker.app/Contents/Resources/bin
