#!/bin/sh
# Preview script built for use with lf and fzf


case "$1" in
    *.png|*.jpg|*.jpeg|*.mkv|*.mp4|*.m4v) exiv2 "$1";;
    # *.png|*.jpg|*.jpeg) icat "$1";;
    *.md) /usr/bin/bat --style plain "$1";;
    *.sh|*.) /usr/bin/bat --style plain "$1";;
    # *.pdf) pdftotext "$1" ;;
    *.zip) zipinfo "$1";;
    *.tar.gz) tar -ztvf "$1";;
    *.tar.bz2) tar -jtvf "$1";;
    *.tar) tar -tvf "$1";;
    *.rar) unrar l "$1";;
    *.7z) 7z l "$1";;
    *) /usr/bin/bat --style plain "$1";; 
    *.html|*.xml) /usr/bin/bat --style plain "$1";;
    *.zsh*|*.bash*|*.git*) /usr/bin/bat --style plain "$1";;
    *.pdf|*.PDF) /usr/bin/impressive "$1";;
    *) "$1" ;;
esac

