import os
from re import A
import subprocess

def main() -> None:
    lsOut = subprocess.run(["tmux", "ls"], capture_output=True)
    if lsOut.returncode == 1 and str(lsOut.stderr).find("no server running") != -1:
        print("Can't find working ANY sessions!")
        print("Start one with folowing command:")
        print("     $ tmux new -s pavel")
        return
    elif lsOut.returncode == 0 and str(lsOut.stdout).find("pavel") == -1:
        print("Can't find working session with name pavel!")
        print("Start one with folowing command:")
        print("     $ tmux new -s pavel")
        return

    subprocess.run(["tmux", "attach-session", "-t", "pavel"])

if __name__ == "__main__":
    main()