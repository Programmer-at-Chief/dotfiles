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
# alias clamscanall="sudo clamscan -irz --detect-pua --scan-archive --scan-html --scan-xmldocs --scan-pdf --scan-ole2 --scan-elf --heuristic-alerts"
alias la="lsd -al"
alias v="nvim"
# alias sv="sudo -E -s nvim"
alias sv="sudoedit"
alias tmux="tmux -u"
alias btop="btop --utf-force"
alias vdiff="nvim -d"
alias du="du -hsc"
alias sql="mycli -u root -p aman2004"
alias icat="kitty +kitten icat"
# alias kitty="kitty --start-as fullscreen"
alias p="python3"
alias bluetooth="sudo systemctl start bluetooth"
alias stop-bluetooth="sudo systemctl stop bluetooth"
# alias syncthing="sudo systemctl start syncthing@aman"
# alias stop-syncthing="sudo systemctl stop syncthing@aman"
alias speedtest="speedtest-cli"
alias dnfs="dnf search -C"
alias aafire="aafire -driver curses"
alias gccp="g++"
alias ls="lsd"
alias fuck="sl -Fa && clear"
alias bare="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME"
alias sex="fortune -as| cowsay -r | lolcat"
# alias tar="tar -cvf"
# alias run="bash /home/aman/Desktop2/Forces/run.sh"
alias devil="emacsclient -c -a 'emacs'"
# alias j="bash /home/aman/Run/javarun.sh"
alias login="python ~/login.py 23124005 Aman1729!"
alias ctf="cd ~/BlackCTF/"
alias lucifer="ssh lucifer@192.168.122.69"
alias piped="pipes -r 0 -p 2"
alias lazy="lazydocker"
alias db="docker build --no-cache -t"
alias impressive="impressive --darkness 75 --spot-radius 128 --fade "

# location alias
alias cpp="cd ~/Desktop2/'Cpp Programming'"
alias jav="cd ~/Desktop2/Java/"
alias drive="cd /media/Data_Drive/"
alias trash="cd ~/.local/share/Trash/files/"
alias C="cd ~/Desktop2/'C Programming'"
alias forces="cd ~/Desktop2/Forces/"
# alias send="read && scp $REPLY lucifer@192.168.122.69:/home/lucifer/CTF "
# alias senddir="read outfile && scp -r $outfile lucifer@192.168.122.69:/home/lucifer/CTF"
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
# alias copy="scp lucifer@192.168.122.69:/home/lucifer/clipboard.txt /home/aman/Desktop2/CTF/clipboard.txt"
alias way="sudo mount --bind ~/Waydroid/ ~/.local/share/waydroid/data/media/0/Shared"
alias clip="bat ~/BlackCTF/clipboard.txt"
alias copied="xargs copyq copy"

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


# Custom Environment 
export EDITOR=/usr/bin/nvim
export TERM=screen-256color
export PATH="$HOME/bin/:$HOME/.emacs.d/bin:$PATH:/home/aman/.local/bin:/home/aman/.cargo/bin:/home/aman/go/bin/" # adding doom emacs to path
export DOCKER_HOST=unix:///run/user/1000/docker.sock
export HISTSIZE=5000
export HISTFILESIZE=5000

# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION

#afetch
# fortune -as| cowsay -r | lolcat
colorscript random | tail -n +2

