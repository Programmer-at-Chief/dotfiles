#
# ~/.bashrc
# 2#

[[ $- != *i* ]] && return

colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		;;
esac

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]] ; then
		PS1='\[\033[01;31m\][\[\033[01;36m\] \W\[\033[01;31m\]] ~~>\[\033[00m\] '
	else
		PS1='\[\033[01;32m\][\u\[\033[01;37m\] \W\[\033[01;32m\]] ~~>\[\033[00m\] '
	fi

	alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

unset use_color safe_term match_lhs sh

alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -h'                      # show sizes in MB
alias clamscanall="sudo clamscan -irz --detect-pua "
alias clamscan="clamscan -iarz"
alias la="lsd -al"
alias v="nvim"
alias sv="sudoedit"
alias tmux="tmux -u"
alias btop="btop --utf-force"
alias vdiff="nvim -d"
alias du="du -hsc"
alias sql="mariadb -u aman -p "
alias icat="kitty +kitten icat"
alias p="python3"
alias bluetooth="sudo systemctl start bluetooth"
alias stop-bluetooth="sudo systemctl stop bluetooth"
alias syncthing="sudo systemctl start syncthing@aman"
alias stop-syncthing="sudo systemctl stop syncthing@aman"
alias speedtest="speedtest-cli"
alias aafire="aafire -driver curses"
alias gcpp="g++"
alias ls="lsd"
alias fuck="sl -Fa && clear"
alias sex="fortune -as| cowsay -r | lolcat"
alias devil="emacsclient -c -a 'emacs'"
alias lucifer="ssh lucifer@192.168.122.224"
alias piped="pipes -r 0 -p 2"
alias db="docker build --no-cache -t"
alias impressive="impressive --darkness 75 --spot-radius 128 --fade "
alias get="wget  --content-disposition"
alias activate="source ./bin/activate"
alias cacafire="DISPLAY= cacafire"
alias light="brightnessctl --device='dell::kbd_backlight' set"
alias caffeine="xset -dpms && xset s off"
alias audio="yt-dlp --extract-audio --ignore-config"
alias yank="xclip -selection clipboard"
alias put="xclip -o -selection clipboard"
alias way="sudo mount --bind ~/Waydroid/ ~/.local/share/waydroid/data/media/0/Shared"
alias qr="qrencode -o qr.png"
alias readqr="zbarimg -q --raw"
# alias rm="trash-put"
alias pince="sudo -E ~/BlackCTF/Programs/PINCE-x86_64.AppImage"
alias search='cd `fzf --height=~70% --border=rounded --walker=dir -d2`'
alias fd="fd -HIu"

# location alias
alias cpp="cd ~/Desktop/'Cpp Programming'"
alias jav="cd ~/Desktop/Java/"
alias drive="cd /media/Data_Drive/"
# alias trash="cd ~/.local/share/Trash/files/"
alias C="cd ~/Desktop/'C Programming'"
alias forces="cd ~/Desktop/Forces/"
alias py="cd ~/Desktop/Python/"
alias pico="cd ~/BlackCTF/PicoCTF/"
alias ctf='cd ~/BlackCTF/ && cd `fzf --height=~70% --border=rounded --walker=dir -n1`'

# Unused alias
# alias bare="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME"
# alias send="read && scp $REPLY lucifer@192.168.122.224:/home/lucifer/CTF "
# alias senddir="read outfile && scp -r $outfile lucifer@192.168.122.224:/home/lucifer/CTF"

xhost +local:root > /dev/null 2>&1


complete -cf sudo

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# export QT_SELECT=4

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}


#fzf
#source /home/aman/.config/fzf/completion.bash && source /home/aman/.config/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash && source /usr/share/fzf/key-bindings.bash
export FZF_DEFAULT_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null ||
cat {} || tree -C {}) 2> /dev/null | head -200'"


# Custom Environment 
export EDITOR=/usr/bin/nvim
export TERM=screen-256color
export PATH="$HOME/bin/:$HOME/.emacs.d/bin:$PATH:/home/aman/.local/bin:/home/aman/.cargo/bin:/home/aman/go/bin/" # adding doom emacs to path
# export DOCKER_HOST=unix:///run/user/1000/docker.sock
export HISTSIZE=5000
export HISTFILESIZE=5000
export HISTCONTROL=ignorespace:erasedups
export HISTIGNORE=yy:cd:exit:man:poweroff:bat:clear:gcc:nmcli:nmtui:run:gcpp:

# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION


# copy files from there to here
here() {
    local loc
    if [ "$#" -eq 1 ]; then
        loc=$(realpath "$1")
    else
        loc=$(realpath ".")
    fi
    ln -sfn "${loc}" "$HOME/.shell.here"
    echo "here -> $(readlink $HOME/.shell.here)"
}

there="$HOME/.shell.here"

there() {
    cd "$(readlink "${there}")"
}
# write here in a directory from where to paste 
# write cp {filename} $there from where to copy

_mariadb() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts=$(mariadb --help | grep 'Options:' | sed -e 's/[^a-zA-Z0-9]//g')

    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    return 0
}
complete -F _mariadb mariadb 

function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

#afetch
# fortune -as| cowsay -r | lolcat
if [[ -f ~/.env ]] ; then
  source ~/.env
else
  echo .env file not found at $HOME/
fi

colorscript random | tail -n +2

