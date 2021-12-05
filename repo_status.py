
import os
import subprocess

def main() -> None:
    tree = os.listdir(".")
    wd = os.getcwd()
    for i in tree:
        if os.path.isdir(i):
            os.chdir(i)
            print("Status of repository - {}".format(i))
            print(subprocess.run(["git", "status"]).stdout)
            print("")
            os.chdir(wd)

if __name__ == "__main__":
    main()