# Load machine-specific settings
source ~/.machine_profile

complete -d cd

# Jump to the machine's projects directory ($PROJ) and optionally a project
# inside it.
function proj() {
	cd "$PROJ"

	if [ ! -z "$1" ]; then
		cd "$1"
	fi
}
export -f proj

function _proj_complete() {
	COMPREPLY=( $(compgen -W "$(ls -1 $PROJ)" "${COMP_WORDS[1]}") )
	return 0
}
complete -F _proj_complete proj

brw() {
	{ error=$(msb --pwd "$@" 2>&1 1>&$out); } {out}>&1

	if [ "$?" -eq 0 ]
	then
		cd "$error"
	fi
}

function _prompt {
	local EXITSTATUS="$?"
	local OFF="\[\033[m\]"

	local GREEN="\[\033[32m\]"
	local YELLOW="\[\033[33m\]"
	local RED="\[\033[31m\]"
	local BLUE="\[\033[36m\]"

	local PROMPT="\n${GREEN}\u ${YELLOW}\w${OFF}${BLUE}`__git_ps1`${OFF}\n"

	if [ "${EXITSTATUS}" -eq 0 ]
	then
		PS1="${PROMPT}\$ "
	else
		PS1="${PROMPT}${RED}\$${OFF} "
	fi

	PS2="${BOLD}>${OFF} "
}

PROMPT_COMMAND=_prompt

# On Windows, make sure we're using the UTF-8 codepage
/c/Windows/System32/chcp.com 65001
clear