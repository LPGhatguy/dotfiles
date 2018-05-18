# Load machine-specific settings
source ~/.machine_profile

# Standard stuff
proj() {
	cd ~/projects

	if [ ! -z "$1" ]; then
		cd "$1"
	fi
}
export -f proj

function _proj_complete() {
	COMPREPLY=( $(compgen -W "$(ls -1 ~/projects)" "${COMP_WORDS[1]}") )
	return 0
}

complete -F _proj_complete proj

/c/Windows/System32/chcp.com 65001
clear