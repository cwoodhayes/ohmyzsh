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
    
    # Clone the repository
    echo "Cloning repository..."
    if ! git clone "$git_url" "$temp_dir/src"; then
        echo "Error: Failed to clone repository"
        rm -rf "$temp_dir"
        return 1
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

