#!/bin/bash

if [ "$1" == "r" ]; then
    cd "$HOME/Obsidian /organiseFuture"
    nvim
else
    cd "$HOME/Obsidian /"
    nvim 
fi

