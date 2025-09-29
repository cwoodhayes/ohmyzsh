# easy aliases for stuff i do often
alias backup="sudo rdiff-backup --api-version 201 --new backup /home/conor /media/conor/writable/conorbot-backups"
alias reload="source ~/.zshrc"
alias vimrc="vim ~/.oh-my-zsh/custom/conorbot.zsh"

pyinit() {
	# first arg is directory, or "." by default. all other args ignored
	dir="${1:-.}"
	uv init "$dir"
	cp -r ~/Templates/python-repo/. "$dir"
}

# uv is here, among maybe other things
PATH="$PATH:$HOME/.local/bin"

# ros stuff
## for autocomplete
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
eval "$(register-python-argcomplete ros2)"


## ROBOTS/workspaces
# top-level ros source. must be done before all else:
alias source-ros="source /opt/ros/kilted/setup.zsh"
# interbotix Pincher X100
alias source-pincher="source ~/ws/interbotix/install/setup.zsh"

alias source-hw1="source ~/Documents/elwin_ME495/hw1-ros-ws/install/setup.zsh"
