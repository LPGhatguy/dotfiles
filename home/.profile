# if running bash
if [ -n "$BASH_VERSION" ]; then
	# include .bashrc if it exists
	if [ -f "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
	fi
fi

export PATH="$HOME/bin:$PATH:$HOME/.npm-global/bin:$HOME/.cargo/bin"