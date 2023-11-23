#!/bin/bash
pgrep glxgears > /dev/null
PGREP_GLXGEARS=$?
if [ $PGREP_GLXGEARS == 1 ]; then
  DISPLAY=:0 sleep 5 && pgrep glxgears || nohup glxgears -geometry 10x10+0+0 > /dev/null &
  nohup sleep 10 && wmctrl -r "glxgears" -b add,above &
fi
