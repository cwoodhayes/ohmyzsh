# macOS-specific configuration. Guard to avoid running on other platforms.
[[ "$(uname -s)" != "Darwin" ]] && return

# Copy a file to the macOS clipboard using AppleScript
file-to-clipboard() {
  osascript \
    -e 'on run args' \
    -e 'set the clipboard to POSIX file (first item of args)' \
    -e end \
    "$@"
}
