
# Скрипт пробегается по вложенным директориям (только первого уровня), 
# и запускает в каждой $git status --porcelain

import os
import subprocess

gitPorcelainCodes: dict[str, str] = {" M": "updated in index",
                                     " T": "type changed in index",
                                     "A ": "added to index",
                                     " D": "deleted from index",
                                     " R": "renamed in index",
                                     " C": "copied in index",
                                     "??": "untracked",
                                     "!!": "ignored"}


def checkStatusWithPorcelain(input: list[str]) -> str:
    """
    Function recieve a output of $git status --porcelain command
    and replace a symbols to human readable description of it.
    @return: Return a single string which describe a status of repository.
    """
    rt: list[str] = []
    
    input = list(filter(lambda x: x != "", input))

    if len(input) == 0: 
        return "Therse nothing to commit!"

    for line in input:
        prefix = line[0:2]
        porcelainCode = gitPorcelainCodes.get(prefix)
        if porcelainCode != None:
            rt.append("{} - {}".format(porcelainCode, line[3:]))
        else: 
            rt.append("{} - {}".format("Unknow code with file", line[3:]))  
    
    return "\n".join(rt)


def main() -> None:
    wd = os.getcwd()
    tree = os.listdir(wd)
    for i in tree:
        if os.path.isdir(i):
            os.chdir(i)
            print("---=== {} ===---".format(i))
            out = subprocess.run(["git", "status", "--porcelain"], capture_output=True)
            if out.returncode == 128:
                print("Directory - {} has not contain a git repo!".format(i))
            outStrList = out.stdout.decode("utf-8").split("\n")

            print("{}\n".format(checkStatusWithPorcelain(outStrList)))

            os.chdir(wd) 

if __name__ == "__main__":
    main()
