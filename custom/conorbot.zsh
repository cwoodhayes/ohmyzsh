# easy aliases for stuff i do often
alias backup="sudo rdiff-backup --api-version 201 --new backup /home/conor /media/conor/writable/conorbot-backups"
alias reload="source ~/.zshrc"
alias gi="cp ~/Templates/.gitignore .gitignore"


# uv is here, among maybe other things
PATH="$PATH:$HOME/.local/bin"

# ros stuff
source /opt/ros/kilted/setup.zsh

## for autocomplete
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
eval "$(register-python-argcomplete ros2)"


## ROBOTS
# interbotix Pincher X100
alias source-pincher="source ~/ws/interbotix/install/setup.zsh"
