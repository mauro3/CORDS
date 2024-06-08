# Git version control

ChatGPT says (correctly):

Git is a distributed version control system designed to handle everything from small to very large projects with speed and efficiency. It allows multiple developers to work on a codebase concurrently, track changes, and collaborate through branches and merges. Git's decentralized architecture enables users to maintain a complete repository with full history on their local machines, facilitating offline work and robust version tracking.



# The git-demo steps

Create a repository

    $ mkdir DemoGitRepo
    $ cd DemoGitRepo
    $ git init .
    Initialized empty Git repository in /home/mauro/teaching/2023-CORDS-WSL/tmp/DemoGitRepo/.git/
    $ echo "Some text" > text-file.txt
    $ git status
    On branch master

    No commits yet

    Untracked files:
      (use "git add <file>..." to include in what will be committed)
            text-file.txt

    nothing added to commit but untracked files present (use "git add" to track)
    $ git add text-file.txt
    $ git commit -am "My first git commit"
    [master (root-commit) 0beeefb] My first git commit
     1 file changed, 1 insertion(+)
     create mode 100644 text-file.txt
    (master) $ nano text-file.txt
    zsh: command not found: nano
    (master) $ zile text-file.txt
    (master) $ git status
    On branch master
    nothing to commit, working tree clean
    (master) $ echo "\nsome more text" >> text-file.txt
    (master) $ git status
    On branch master
    Changes not staged for commit:
      (use "git add <file>..." to update what will be committed)
      (use "git restore <file>..." to discard changes in working directory)
            modified:   text-file.txt

    no changes added to commit (use "git add" and/or "git commit -a")
    (master) $ git diff
    (master) $ git diff --raw
    (master) $ git --no-pager diff
    diff --git a/text-file.txt b/text-file.txt
    index 01b51e6..456027e 100644
    --- a/text-file.txt
    +++ b/text-file.txt
    @@ -1 +1,3 @@
     Some text
    +
    +some more text
    (master) $ git commit -am "Added some more text"
    [master be8dc47] Added some more text
     1 file changed, 2 insertions(+)
    (master) $ echo 1+1 > code.py
    (master) $ mkdir subdir
    (master) $ echo "Text text" > subdir/ttt
    (master) $ git status
    On branch master
    Untracked files:
      (use "git add <file>..." to include in what will be committed)
            code.py
            subdir/

    nothing added to commit but untracked files present (use "git add" to track)
    (master) $ git add code.py subdir/ttt
    (master) $ git commit -am "More more more"
    [master 4d95572] More more more
     2 files changed, 2 insertions(+)
     create mode 100644 code.py
     create mode 100644 subdir/ttt
    (master) $ git log
    (master) $ git --no-pager log
    commit 4d955727f4dc6ef7254b8826e521bac9bc5e50ab (HEAD -> master)
    Author: Mauro Werder <mauro3@runbox.com>
    Date:   2024-06-08 22:53:07 +0200

        More more more

    commit be8dc4727234c0a0ba30de4e4c593a138f7af1c5
    Author: Mauro Werder <mauro3@runbox.com>
    Date:   2024-06-08 22:51:18 +0200

        Added some more text

    commit 0beeefb1b203495ee20d627431204f26576afb93
    Author: Mauro Werder <mauro3@runbox.com>
    Date:   2024-06-08 22:46:56 +0200

        My first git commit
    (master) $ git switch -c m3/a-branch
    Switched to a new branch 'm3/a-branch'
    (m3/a-branch) $ echo "more stuff which isnt quite ready yet to be on the master branch" > text-file.txt
    (m3/a-branch) $ git status
    On branch m3/a-branch
    Changes not staged for commit:
      (use "git add <file>..." to update what will be committed)
      (use "git restore <file>..." to discard changes in working directory)
            modified:   text-file.txt

    no changes added to commit (use "git add" and/or "git commit -a")
    (m3/a-branch) $ git commit -am "working on some cool text"
    [m3/a-branch 48f27ab] working on some cool text
     1 file changed, 1 insertion(+), 3 deletions(-)
    (m3/a-branch) $ git switch master
    Switched to branch 'master'
    (master) $ git diff m3/a-branch
    (master) $ git --no-pager diff m3/a-branch
    diff --git a/text-file.txt b/text-file.txt
    index 81dd954..456027e 100644
    --- a/text-file.txt
    +++ b/text-file.txt
    @@ -1 +1,3 @@
    -more stuff which isnt quite ready yet to be on the master branch
    +Some text
    +
    +some more text
    (master) $ git difftool m3/a-branch
    (master) $ echo "TTT" >> subdir/ttt
    (master) $ git commit -am "stuff"
    [master c603696] stuff
     1 file changed, 1 insertion(+)
    (master) $ git switch m3/a-branch
    Switched to branch 'm3/a-branch'
    (m3/a-branch) $ git merge master
    hint: Waiting for your editor to close the file... Waiting for Emacs...^C
    (m3/a-branch) $ git merge master -m "getting latest changes from master"
    fatal: You have not concluded your merge (MERGE_HEAD exists).
    Please, commit your changes before you merge.
    (m3/a-branch) $ git status
    On branch m3/a-branch
    All conflicts fixed but you are still merging.
      (use "git commit" to conclude merge)

    Changes to be committed:
            modified:   subdir/ttt

    (m3/a-branch) $ git reset HEAD
    Unstaged changes after reset:
    M       subdir/ttt
    (m3/a-branch) $ git status
    On branch m3/a-branch
    Changes not staged for commit:
      (use "git add <file>..." to update what will be committed)
      (use "git restore <file>..." to discard changes in working directory)
            modified:   subdir/ttt

    no changes added to commit (use "git add" and/or "git commit -a")
    (m3/a-branch) $ git restore subdir/ttt
    (m3/a-branch) $ git log
    (m3/a-branch) $ git merge master -m "getting latest changes from master"
    Merge made by the 'ort' strategy.
     subdir/ttt | 1 +
     1 file changed, 1 insertion(+)
    (m3/a-branch) $ cat subdir/ttt
    Text text
    TTT
    (m3/a-branch) $ git switch master
    Switched to branch 'master'
    (master) $ git merge m3/a-branch
    Updating c603696..140a841
    Fast-forward
     text-file.txt | 4 +---
     1 file changed, 1 insertion(+), 3 deletions(-)
