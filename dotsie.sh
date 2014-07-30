#/bin/bash

# import / export dotfiles

case $1 in
    "i" )
        echo "->import"
        action= "import"
        ;;
    "e" )
        echo "->export"
        action= "export"
        ;;
    * )
        echo "param 1 not valid"
        exit 1
esac

case $2 in
    "vimrc" )
        echo "->vim"
        ;;
    "zshrc" )
        echo "->zsh"
        ;;
    "gitignore" )
        echo "->git"
        ;;
    * )
        echo "param 2 not valid"
        exit 1
        ;;
esac
