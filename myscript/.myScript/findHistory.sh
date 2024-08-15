#!/bin/bash

selectHistory=$(cat /home/aman/.zsh_history | fzf )
print=$(echo $selectHistory | (sed 's/.*;//'))
echo "$print"
