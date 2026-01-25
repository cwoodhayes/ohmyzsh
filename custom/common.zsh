# Shared across all platforms
alias reload='source ~/.zshrc'
unsetopt autocd

# General aliases
alias song-dl="youtube-dl -x --audio-format m4a "
alias vimrc-linux="vim ~/.oh-my-zsh/custom/linux.zsh" 
alias vimrc-common="vim ~/.oh-my-zsh/custom/common.zsh" 

# Convert Google Drive file links or IDs to raw image URL (or Markdown).
# Usage:
#   gdimg <url-or-id> [-d] [-c]
#     -d : use download URL (default is view URL)
#     -c : copy result to clipboard if available
#   gdmd <url-or-id> "Alt text" [-d] [-c]
#     -d : use download URL
#     -c : copy Markdown to clipboard
gdimg() {
	local input mode="view" copy=0 id url
	local -a args=()

	# Extract flags and positional arguments
	while [[ $# -gt 0 ]]; do
		case "$1" in
			-d|--download) mode="download" ;;
			-c|--copy) copy=1 ;;
			*) args+=("$1") ;;
		esac
		shift
	done

	if [[ ${#args[@]} -eq 0 ]]; then
		echo "Usage: gdimg <url-or-id> [-d] [-c]" >&2
		return 1
	fi
	input="${args[1]}"

	# Reject folder links (cannot resolve contents without Drive API)
	if echo "$input" | grep -Eq '/drive(/u/[0-9]+)?/folders/'; then
		echo "Error: folder links are not supported. Provide a file link or ID." >&2
		return 1
	fi

	# Extract file ID from common URL shapes, otherwise treat input as ID
	id=$(echo "$input" |
		sed -nE \
			-e 's#.*file/d/([^/]+).*#\1#p' \
			-e 's#.*[?&]id=([^&?]+).*#\1#p')

	if [[ -z "$id" ]]; then
		# If the input looks like a bare ID, accept it; else fail
		if echo "$input" | grep -Eq '^[A-Za-z0-9_-]+$'; then
			id="$input"
		else
			echo "Error: could not extract a file ID from input." >&2
			return 1
		fi
	fi

	url="https://drive.google.com/uc?export=${mode}&id=${id}"
	printf "%s\n" "$url"

	if (( copy )); then
		if command -v pbcopy >/dev/null 2>&1; then
			printf "%s" "$url" | pbcopy
		elif command -v xclip >/dev/null 2>&1; then
			printf "%s" "$url" | xclip -selection clipboard
		elif command -v xsel >/dev/null 2>&1; then
			printf "%s" "$url" | xsel --clipboard --input
		else
			echo "Note: no clipboard tool found (pbcopy/xclip/xsel)." >&2
		fi
	fi
}

gdmd() {
	local input alt mode="view" copy=0 url extra=""
	local -a args=()

	# Extract flags and positional arguments
	while [[ $# -gt 0 ]]; do
		case "$1" in
			-d|--download) mode="download" ;;
			-c|--copy) copy=1 ;;
			*) args+=("$1") ;;
		esac
		shift
	done

	if [[ ${#args[@]} -lt 2 ]]; then
		echo "Usage: gdmd <url-or-id> \"Alt text\" [-d] [-c]" >&2
		return 1
	fi
	input="${args[1]}"
	alt="${args[2]}"

	# Reuse gdimg to compute the URL (without copying)
	if [[ "$mode" == "download" ]]; then
		extra="-d"
	fi
	url=$(gdimg "$input" $extra 2>/dev/null) || return 1
	local md="![${alt}](${url})"
	printf "%s\n" "$md"

	if (( copy )); then
		if command -v pbcopy >/dev/null 2>&1; then
			printf "%s" "$md" | pbcopy
		elif command -v xclip >/dev/null 2>&1; then
			printf "%s" "$md" | xclip -selection clipboard
		elif command -v xsel >/dev/null 2>&1; then
			printf "%s" "$md" | xsel --clipboard --input
		else
			echo "Note: no clipboard tool found (pbcopy/xclip/xsel)." >&2
		fi
	fi
}
