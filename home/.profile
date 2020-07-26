# Load machine-specific settings
# It should specify the variable 'PROJ' at least
source ~/.machine_profile

# Make tab completion not have the 'exe' suffix
shopt -s completion_strip_exe

# Jump to the machine's projects directory ($PROJ) and optionally a project
# inside it.
function proj() {
	cd "$PROJ/$1"
}

function _proj_complete() {
	COMPREPLY=( $(compgen -W "$(ls -1 $PROJ | grep /)" "${COMP_WORDS[1]}") )
	return 0
}
complete -F _proj_complete proj

# Runs Magic School Bus (A TUI file browser), capturing stderr and using it to
# change the current working directory on close
function brw() {
	{ error=$(msb --pwd "$@" 2>&1 1>&$out); } {out}>&1

	if [ "$?" -eq 0 ]; then
		cd "$error"
	fi
}

_prompt() {
	local EXITSTATUS="$?"

	# Show a newline if this isn't the first prompt of the session
	if [[ -z "${PS1_NEWLINE_LOGIN}" ]]; then
		PS1_NEWLINE_LOGIN=true
	else
		printf '\n'
	fi

	local RESET="\033[m"
	local GREEN="\033[32m"
	local YELLOW="\033[33m"
	local RED="\033[31m"
	local BLUE="\033[36m"

	if [ ! "${EXITSTATUS}" -eq 0 ]; then
		printf "${RED}error: ${EXITSTATUS}${RESET}\n"
	fi

	PS1="${GREEN}\u ${YELLOW}\w${BLUE}$(__git_ps1)${RESET}\n\$ "
	PS2="${BOLD}>${RESET} "
}

PROMPT_COMMAND=_prompt

export EDITOR="subl --wait"

# On Windows, make sure we're using the UTF-8 codepage
/c/Windows/System32/chcp.com 65001
clear
