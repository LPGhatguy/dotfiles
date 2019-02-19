# Load machine-specific settings
source ~/.machine_profile

complete -d cd

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

function brw() {
	{ error=$(msb --pwd "$@" 2>&1 1>&$out); } {out}>&1

	if [ "$?" -eq 0 ]
	then
		cd "$error"
	fi
}

_prompt() {
	local EXITSTATUS="$?"

	local OFF="\[\033[m\]"

	local GREEN="\[\033[32m\]"
	local YELLOW="\[\033[33m\]"
	local RED="\[\033[31m\]"
	local BLUE="\[\033[36m\]"

	local PROMPT="\n${GREEN}\u ${YELLOW}\w${OFF}${BLUE}`__git_ps1`${OFF}\n"

	if [ ! "${EXITSTATUS}" -eq 0 ]
	then
		printf "\033[31merror: ${EXITSTATUS}\033[m\n"
	fi

	PS1="${PROMPT}\$ "
	PS2="${BOLD}>${OFF} "
}

PROMPT_COMMAND=_prompt

# On Windows, make sure we're using the UTF-8 codepage
/c/Windows/System32/chcp.com 65001
clear