source ~/.config/fish/cachyos-config.fish
set -gx EDITOR nvim

set -gx PYENV_ROOT "$HOME/.pyenv"
set -gx QT_QPA_PLATFORMTHEME "qt6ct"
# set -gx QT_QPA_PLATFORMTHEME "kvantum"

if test -f ~/.env
    source ~/.env
end

alias reset_keyboard="setxkbmap"
alias cp="cp -i"                          # confirm before overwriting something
alias clamscanall="sudo clamscan -irz --detect-pua "
alias clamscan="clamscan -iarz"
alias la="lsd -al"
alias v="nvim"
alias sv="sudoedit"
alias tmux="tmux -u"
alias btop="btop --force-utf"
alias vdiff="nvim -d"
alias du="du -hsc"
alias sql="mariadb -u aman -p "
alias sqle="usql mysql://aman:Aman2004@localhost/test"
alias icat="kitty +kitten icat"
alias p="python3"
alias bluetooth="sudo systemctl start bluetooth"
alias stop-bluetooth="sudo systemctl stop bluetooth"
alias syncthing="sudo systemctl start syncthing@aman"
alias stop-syncthing="sudo systemctl stop syncthing@aman"
alias speedtest="speedtest-cli"
alias aafire="aafire -driver curses"
alias gcpp="g++ -std=c++23"
alias ls="lsd"
# alias fuck="sl -Fa && clear"
alias sex="$HOME/bin/panties | cowsay -r | lolcat"
# alias fuck="curl -s https://evilinsult.com/generate_insult.php | cowsay -r | lolcat"
alias devil="emacsclient -c -a 'emacs'"
alias lucifer="ssh lucifer@192.168.122.124"
alias piped="pipes -r 0 -p 2"
alias db="docker build --no-cache -t"
alias impressive="impressive --darkness 75 --spot-radius 128 --fade "
alias get="wget  --content-disposition"
alias activate="source ./bin/activate"
alias cacafire="DISPLAY = cacafire"
alias light="brightnessctl --device='dell::kbd_backlight' set"
alias caffeine="xset -dpms && xset s off"
alias audio="yt-dlp --extract-audio --ignore-config"
alias video="yt-dlp --ignore-config -f \"bestvideo[height<=1080][ext=mp4]\""
alias yank="xclip -selection clipboard"
alias put="xclip -o -selection clipboard"
alias way="sudo mount --bind ~/Waydroid/ ~/.local/share/waydroid/data/media/0/Shared"
alias qr="qrencode -o qr.png"
alias readqr="zbarimg -q --raw"
# alias rm="trash-put"
alias search='cd `fzf --height=~70% --border=rounded --walker=dir -d2`'
alias fd="fd -HIu"
alias android="aft-mtp-mount ~/droid"
alias npm="pnpm"
alias pokemon="pokemon-colorscripts -r"
alias node="nodemon"
alias pid="ps -o pid,ppid,cmd -p"
alias monkey="docker run --publish 5000:5000 themythologist/monkeytype:frontend-latest"
alias pnpx="pnpm dlx"
alias telegram='nchat -d ~/.config/nchat-telegram'
alias whatsapp='nchat -d ~/.config/nchat-whatsapp'
alias speedtest='cloudflare-speed-cli'

# location alias
# alias drive="cd /media/Data_Drive/"
# alias trash="cd ~/.local/share/Trash/files/"
alias forces="cd ~/Desktop/Forces/"
alias ctf='cd ~/BlackCTF/ && cd `fzf --height=~70% --border=rounded --walker=dir -n1`'

function yy
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	command yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
		builtin cd -- "$cwd"
	end
	command rm -f -- "$tmp"
end

set -gx PATH \
    $JAVA_HOME/bin \
    $PYENV_ROOT/bin \
    $HOME/bin \
    $PATH \
    /home/aman/.local/bin \
    /home/aman/.local/share/nvim/mason/bin/

function color
    switch $argv[1]
        case red
            printf "\e[0;31m%s\e[0m\n" "$argv[2]"
        case green
            printf "\e[0;32m%s\e[0m\n" "$argv[2]"
        case yellow
            printf "\e[0;33m%s\e[0m\n" "$argv[2]"
        case blue
            printf "\e[0;34m%s\e[0m\n" "$argv[2]"
        case magenta
            printf "\e[0;35m%s\e[0m\n" "$argv[2]"
        case cyan
            printf "\e[0;36m%s\e[0m\n" "$argv[2]"
        case white
            printf "\e[0;37m%s\e[0m\n" "$argv[2]"
    end
end

# Kitty shell integration
if test -n "$KITTY_INSTALLATION_DIR"; and test -e "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_conf.d/kitty-shell-integration.fish"
    source "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_conf.d/kitty-shell-integration.fish"
end

# Copy current (or specified) directory to ~/.shell.here
function here
    if test (count $argv) -eq 1
        set loc (realpath $argv[1])
    else
        set loc (realpath .)
    end

    ln -sfn "$loc" "$HOME/.shell.here"
    echo "here -> "(readlink "$HOME/.shell.here")
end

# Jump to the saved directory
function there
    readlink "$HOME/.shell.here"
end

pyenv init - | source
