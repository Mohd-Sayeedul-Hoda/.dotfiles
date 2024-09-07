#!/bin/bash

if [ "$1" == "r" ]; then
    cd "$HOME/Obsidian /"
    nvim
else
    cd "$HOME/Obsidian /organiseFuture"
    nvim 
fi

