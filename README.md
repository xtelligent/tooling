# Tooling
Tooling for code repositories.

## Patterns

* The conditional execution pattern can be utilized during builds or in local tooling during development.
It relies on `gitx-matchchanges` and `x-whenhasdata` to evaluate if applicable code changes have taken
place. If so, the parameters to `x-whenhasdata` are executed as a command line, similar to `xargs`, but
with only one execution. See the command reference below for details and examples.

## GitX commands

Utilities to wrap the git CLI.

### Installation
``` bash
git clone https://github.com/xtelligent/tooling.git
tooling/install.sh git
```

---

Lets assume you have a project `myapp`, and your terminal's current directory is at or under the root
for that project.

### Commands

``` bash
$ gitx-curbranch
main
```
The command returns the current branch for the repository.

---

``` bash
$ gitx-matchchanges
gitx-matchchanges PATHS [FLAGS] [COMMITNUMBER]
        Prints any matching changes under any of the paths.
        PATHS: Paths to files or directories in the repository to check for any changes, delimited by |.
        FLAGS: Flags passed directly to gix-modlist command (-d|-n|-r).
        COMMITNUMBER: Commit passed directly to gix-modlist command.
$ gitx-matchchanges 'src/changedfile.txt|src/otherfiles' -r
src/changedfile.txt
$ gitx-matchchanges 'src/otherfiles' -dnr
# Pattern for build scripts to conditionally run a script.
$ gitx-matchchanges package.json | x-whenhasdata npm install
```
Command to determine if there are any changes under the supplied paths. Note: when you use the | in
the PATHS parameter, please quote the parameter! The shell will otherwise treat the character as
a pipe operator.

---

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

---

``` bash
$ gitx-root
/usr/local/code/myapp
```
Returns the git root for the working directory.

---

## General utilities

Utilities to wrap the git CLI.

### Installation
``` bash
git clone https://github.com/xtelligent/tooling.git
tooling/install.sh utilities
```

---

### Commands

``` bash
$ x-whenhasdata COMMAND [ARGs] 
        When data is piped in, it runs the command line.
# Pattern for build scripts to conditionally run a script.
$ gitx-matchchanges package.json | x-whenhasdata npm install
```
The command is similar to `xargs`, but it will only one runs when
it sees any data in the `/dev/stdin` pipe. Running the command without
a pipe causes undefined behavior.

---
