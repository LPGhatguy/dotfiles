# Load machine-specific settings
source ~/.machine_profile

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

# On Windows, make sure we're using the UTF-8 codepage
/c/Windows/System32/chcp.com 65001
clear