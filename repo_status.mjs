
import { execSync } from "child_process";
import { cwd, chdir } from "process";
import { promises } from "fs";

let gitPorcelainCodes = new Map([
	[" M", "updated in index"],
	[" T", "type changed in index"],
	["A ", "added to index"],
	[" D", "deleted from index"],
	[" R", "renamed in index"],
	[" C", "copied in index"],
	["??", "untracked"],
	["!!", "ignored"]
])

/**
 * 
 * @param {Array<string>} lsOut 
 */
function checkStatusPorcelain(lsOut) {
    /** @type{Array<string>} */
    let rt = []

    let filtred = lsOut.filter((value, index, arr) => {return value.length != 0})

    if (lsOut.length == 0) { 
        return "Therse nothing to commit!"
    }

    for (let line of filtred) {
        let prefix = line.slice(0,2)
        let porcelainCode = gitPorcelainCodes.get(prefix)

        if (porcelainCode !== undefined) {
            rt.push(`${porcelainCode} - ${line.slice(3)}`)
        } else {
            rt.push(`Unknow code with file - ${line.slice(3)}`)
        }
    }
    return rt.join("\n")
}

(async function main() {
    let wd = cwd()
    let tree = await promises.readdir(wd)

    for (let dir of tree) {
        if ((await promises.lstat(dir)).isDirectory()) {
            chdir(dir)
            console.log(`---=== ${dir} ===---"`)
            try {
                // Use {stdio : 'pipe'} - to supress out message Fatal...
                let foo = execSync("git status --porcelain", {stdio : 'pipe'})
                                        .toString()
                                        .split("\n")
                console.log(checkStatusPorcelain(foo))
            } catch (error) {
                if (error.status == 128) {
                    console.log(`Directory - ${dir} has not contain a git repo!\n`)
                }
            }
            chdir(wd) 
        }
    }
})()