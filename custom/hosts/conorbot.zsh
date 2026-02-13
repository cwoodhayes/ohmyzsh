# ros stuff
## for autocomplete
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

# easy aliases for stuff i do often
alias backup="sudo rdiff-backup --api-version 201 --new backup /home/conor /media/conor/writable/conorbot-backups"
alias vimrc="vim ~/.oh-my-zsh/custom/hosts/conorbot.zsh"
alias vimi3="vim ~/.config/i3/config"

# cd aliases
alias cdw="cd /home/conor/Documents/W2026"
alias cdslam="cd /home/conor/Documents/W2026/elwin_me495/slam"

# miscellaneous tools
## install ruby gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

## display shenanigans
alias monup="xrandr --output HDMI-1 --above eDP-1 --auto"
alias monoff="xrandr --output HDMI-1 --off"
nighty() {
	arg="${1:-.}"
	if [ "$arg" = "night" ]; then
		redshift -O 4500K
	elif [ "$arg" = "day" ]; then
		redshift -O 6350K
	else:
		redshift -l 42.2:87.40 -b 0.8:0.6 &
	fi
}

# random helpful functions
update-deb-from-downloads() {
	# args: app name, regex
	if (( $# != 2 )); then
		echo "Usage: update-deb-from-downloads <app-name> <regex>"
		return 1
	fi

	local app_name="$1"
	local regex="$2"
	local matches=()
	local file

	while IFS= read -r file; do
		matches+=("$HOME/Downloads/$file")
	done < <(find "$HOME/Downloads" -maxdepth 1 -type f -printf '%f\n' | grep -E "$regex")

	if (( ${#matches[@]} == 0 )); then
		echo "Error: No $app_name packages found in ~/Downloads"
		return 1
	elif (( ${#matches[@]} > 1 )); then
		echo "Error: Multiple $app_name packages found:"
		printf '  %s\n' "${matches[@]}"
		return 1
	else
		local package="${matches[1]}"
		echo "Found package: $package"
		echo "Installing..."

		if sudo apt install "$package"; then
			echo "Installation successful. Deleting package..."
			rm "$package"
			echo "Done!"
		else
			echo "Installation failed. Package not deleted."
			return 1
		fi
	fi
}

update-discord() {
	update-deb-from-downloads "discord" '^discord-.*\.deb$'
}

update-vscode() {
	update-deb-from-downloads "vscode" '^code_.*\.deb$'
}

pyinit() {
	# first arg is directory, or "." by default. all other args ignored
	dir="${1:-.}"
	uv init "$dir"
	uv venv "$dir/.venv"
	cp -r ~/Templates/python-repo/. "$dir"
}

rosinit() {
	# first arg is directory, or "." by default. all other args ignored
	dir="${1:-.}"
	cp -r ~/Templates/python-repo/. "$dir"
}

ziprepo() {
	# first arg is directory, or "." by default. all other args ignored
	dir="${1:-.}"
	out="$dir.zip"
	echo "Writing repo at $dir to $out..."
	zip -r "$out" "$dir" -x '**/__pycache__/*' '**/.pytest_cache/*' '**/.venv/*' '**/.vscode/*' '**/.git/**'
}

alias screenshot-cp="maim --select | xclip -selection clipboard -t image/png"

# uv is here, among maybe other things
PATH="$PATH:$HOME/.local/bin"

## helpful random ros tools
source "/usr/share/colcon_cd/function/colcon_cd.sh"

## ROBOTS/workspaces
# top-level ros source. must be done before all else:
alias source-ros="source /opt/ros/kilted/setup.zsh"
# interbotix Pincher X100
alias source-pincher="source ~/ws/interbotix/install/setup.zsh"

alias source-hw1="source-ros; source ~/Documents/elwin_ME495/hw1-ros-ws/install/setup.zsh"
alias source-hw2="source-ros; source ~/Documents/elwin_ME495/hw2/install/setup.zsh"
alias source-hw3="source-ros; source ~/Documents/elwin_ME495/hw3/install/setup.zsh"
alias source-hw3p2="source-ros; source ~/Documents/elwin_ME495/hw3p2/install/setup.zsh"
alias source-franka="source-ros; source ~/ws/franka/install/setup.zsh"
alias source-penpal="source-franka; source ~/Documents/elwin_ME495/penpal/install/setup.zsh"
alias source-slam="source ~/Documents/W2026/elwin_me495/slam/install/setup.zsh"
alias cdslam="cd ~/Documents/W2026/elwin_me495/slam/"

source-ros

# ROS DOMAIN ID FOR MY PROJECTS
export ROS_DOMAIN_ID=63

# turtlebot access
ros2-xcompile-turtlebot() {
	# first arg is "raphael" or others
	if (( $# != 1 )); then
		echo "Error: rsync-turtlebot requires exactly 1 argument"
		return 1
	fi
	./aarch64 colcon_aarch64
	rsync -av --delete aarch64_install/ $1:/home/msr/install
}

# argcomplete for ros2 & colcon
eval "$(register-python-argcomplete ros2)"
eval "$(register-python-argcomplete colcon)"
