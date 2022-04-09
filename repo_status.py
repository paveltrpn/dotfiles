
# Скрипт пробегается по вложенным директориям (только первого уровня), 
# и запускает в каждой git status

import os
import subprocess

def checkNew(input: list[str]) -> str:
    rt: list[str]
    rt = []

    for i, line in enumerate(input):
        if line.find("Неотслеживаемые файлы:") != -1:
            rt.append("Untracked files:")
            for val in input[i+2:-4]:
                rt.append(val)

    if len(rt) == 0: 
        return "Repo has no untracked files."
    else:
        return "\n".join(rt)

def checkErased(input: list[str]) -> str:
    return "Mock for check repo for erased files"

def checkChanges(input: list[str]) -> str:
    rt: list[str] = []

    for line in input:
        if line.find("изменено:") != -1:
            rt.append(line.strip("\t"))

    if len(rt) == 0: 
        return "Repo has no changes in files."
    else:
        return "\n".join(rt)


gitPorcelainCodes: dict[str, str] = {" M": "updated in index",
                                     " T": "type changed in index",
                                     " A": "added to index",
                                     " D": "deleted from index",
                                     " R": "renamed in index",
                                     " C": "copied in index",
                                     "??": "untracked",
                                     "!!": "ignored"}


def checkStatusWithPorcelain(input: list[str]) -> str:
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

            # changedFilesStr = checkChanges(outStrList)
            # print(changedFilesStr)
            # newFilesStr = checkNew(outStrList)
            # print(newFilesStr)
            # erasedFilesStr = checkErased(outStrList)
            # print(erasedFilesStr)

            os.chdir(wd) 

if __name__ == "__main__":
    main()