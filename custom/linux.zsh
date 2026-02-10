# Linux-specific configuration. Add content when setting up on Linux.
[[ "$(uname -s)" != "Linux" ]] && return

##########################################
## helper stuff for ros2
ros-reclone() {
    # Check if URL argument is provided
    if [ -z "$1" ]; then
        echo "Error: Please provide a git URL"
        echo "Usage: ros-reclone <git-url>"
        return 1
    fi
    
    local git_url="$1"
    
    # Create temporary directory
    local temp_dir=$(mktemp -d)
    echo "Created temporary directory: $temp_dir"
    
    # Create src subdirectory
    mkdir -p "$temp_dir/src"
    
    # Determine repo directory name
    local repo_name="${git_url##*/}"
    repo_name="${repo_name%.git}"

    # Clone the repository
    echo "Cloning repository..."
    if ! git clone "$git_url" "$temp_dir/src/$repo_name"; then
        echo "Error: Failed to clone repository"
        rm -rf "$temp_dir"
        return 1
    fi

    # if one exists, run the install_dependencies.sh script in the repo root to set up the environment
    if [ -f "$temp_dir/src/$repo_name/install_dependencies.sh" ]; then
        echo "Running install_dependencies.sh from cloned repository..."
        "$temp_dir/src/$repo_name/install_dependencies.sh"
    else 
        echo "No install_dependencies.sh found in cloned repository, skipping environment setup"
    fi
    
    # Change to temp directory
    cd "$temp_dir" || return 1
    
    # Run rosdep install
    echo "Running rosdep install..."
    rosdep install --from-paths src --ignore-src -r -y
    
    # Run colcon build
    echo "Running colcon build..."
    if ! colcon build; then
        echo "Error: Build failed"
        cd - > /dev/null
        return 1
    fi
    
    # Run colcon test
    echo "Running colcon test..."
    colcon test
    
    # Show test results
    echo "Test results:"
    colcon test-result --all
    
    echo ""
    echo "Workspace location: $temp_dir"
    echo "To navigate there: cd $temp_dir"
    
    # Return to original directory
    cd - > /dev/null
}

# puts together compile_commands output for vscode
ros2-compile-commands() {
	colcon build --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
	find build -name compile_commands.json -exec cat {} \; | jq -s 'add' > build/compile_commands.json
	echo "Wrote compile_commands to build/compile_commands.json"
}

