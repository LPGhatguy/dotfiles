export ZSH=/home/lucien/.oh-my-zsh

ZSH_THEME="agnoster"
DEFAULT_USER="lucien"
DISABLE_AUTO_TITLE="true"
PR_TITLEBAR=""

plugins=(zsh-syntax-highlighting)

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:~/.npm-global/bin

source $ZSH/oh-my-zsh.sh
source ~/.aliases

set-window-title() {
	if [ -z "$1" ]; then
		EXECUTABLE="";
	else
		EXECUTABLE="(${1})";
	fi

	window_title="\e]0;term: ${PWD/#"$HOME"/~} ${EXECUTABLE}\a"
	echo -ne "$window_title"
}

set-window-title
add-zsh-hook precmd set-window-title
add-zsh-hook preexec set-window-title