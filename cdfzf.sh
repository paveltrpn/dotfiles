#/usr/bin/bash

cd $(find $1 -type d -print | fzf)
