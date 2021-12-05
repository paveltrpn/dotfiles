
# Скрипт пробегается по вложенным директориям (только первого уровня), 
# и запускает в каждой git status

import os
import subprocess

def main() -> None:
    wd = os.getcwd()
    tree = os.listdir(wd)
    for i in tree:
        if os.path.isdir(i):
            os.chdir(i)
            print("Status of repository - {}".format(i))
            print(subprocess.run(["git", "status"]).stdout)
            print("")
            os.chdir(wd)

if __name__ == "__main__":
    main()