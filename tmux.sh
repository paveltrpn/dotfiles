#!/bin/sh 
tmux new-session -s "three-pane" -d
tmux split-window -h
tmux split-window -v
# Simply send literally a text to targe pane in current session
tmux send-keys -t "three-pane:0.2" mc Enter
tmux -2 attach-session -d 
