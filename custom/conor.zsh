## Custom entrypoint: load common, platform, then host-specific config.

# Helper to source files only when they exist.
_omz_custom_source_if_exists() {
    # echo "Attempting to source $1..."
    [[ -f "$1" ]] && source "$1"
}

# Custom files live in the root of $ZSH_CUSTOM and are already auto-sourced by OMZ.
# Host-specific files are namespaced under $ZSH_CUSTOM/hosts and loaded manually here.
_omz_custom_source_if_exists "$ZSH_CUSTOM/hosts/${SHORT_HOST:-$(hostname -s)}.zsh"

unset -f _omz_custom_source_if_exists
