# Tooling
Tooling for code repositories.

## GitX commands

Utilities to wrap the git CLI.

### Installation
``` bash
git clone https://github.com/xtelligent/tooling.git
tooling/install.sh git
```

Lets assume you have a project `myapp`, and your terminal's current directory is at or under the root
for that project.

### Commands

``` bash
$ gitx-curbranch
main
```
The command returns the current branch for the repository.

``` bash
$ git-modlist -h
script usage: $0 [-d] [-n] [-r] [COMMITNUMBER]
        d: exclude dirty files (tracked files with changes) from output
        n: exclude new/untracked files from output
        r: exclude recent commit changes from output; show only new/dirty files
        COMMITNUMBER: optional commit to use as the start of history.

$ git-modlist origin/HEAD
README.md
.gitignore
```
Returns a list of files that have changed or been created since the optional commit
argument. If the `COMMITNUMBER` is omitted, the script finds the last commit on the
branch `main`.

``` bash
$ gitx-root
/usr/local/code/myapp
```
Returns the git root for the working directory.
