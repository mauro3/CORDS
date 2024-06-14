
# Git version control

ChatGPT says (correctly):

Git is a distributed version control system designed to handle everything from small to very large projects with speed and efficiency. It allows multiple developers to work on a codebase concurrently, track changes, and collaborate through branches and merges. Git's decentralized architecture enables users to maintain a complete repository with full history on their local machines, facilitating offline work and robust version tracking.



# The git-demo steps

Here is a recording of the demo done during the presentation [link](git_slides.md#a-brief-git-demo-session).  It should be mostly like the one done during the workshop.  The `$` signifies the shell prompt.  Pre-pended to it is the currently active branch.

Get help

    $ git help
    usage: git [-v | --version] [-h | --help] [-C <path>] [-c <name>=<value>]
               [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
               [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--bare]
               [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
               [--config-env=<name>=<envvar>] <command> [<args>]
    ...

or

    $ git help init

(but as usual for man-pages, its pretty terse)

Create a directory/folder and initialize repository

    $ mkdir DemoGitRepo
    $ cd DemoGitRepo
    $ git init .
    Initialized empty Git repository in /home/mauro/teaching/2023-CORDS-WSL/tmp/DemoGitRepo/.git/

Add some content (`echo "Some text" > text-file.txt` puts "Some text" into the file)

    $ echo "Some text" > text-file.txt

Check with `status` the current state (use it often)

    $ git status
    On branch master

    No commits yet

    Untracked files:
      (use "git add <file>..." to include in what will be committed)
            text-file.txt

    nothing added to commit but untracked files present (use "git add" to track)

We do as we are told by git:

    $ git add text-file.txt
    $ git commit -am "My first git commit"
    [master (root-commit) 0beeefb] My first git commit
     1 file changed, 1 insertion(+)
     create mode 100644 text-file.txt

Make some more changes to that file

    (master) $ echo "\nsome more text" >> text-file.txt
    (master) $ git status
    On branch master
    Changes not staged for commit:
      (use "git add <file>..." to update what will be committed)
      (use "git restore <file>..." to discard changes in working directory)
            modified:   text-file.txt

    no changes added to commit (use "git add" and/or "git commit -a")

Use `diff` to show changes.  The lines with the `+` are new (a `-` would show removals)

    (master) $ git diff
    diff --git a/text-file.txt b/text-file.txt
    index 01b51e6..456027e 100644
    --- a/text-file.txt
    +++ b/text-file.txt
    @@ -1 +1,3 @@
     Some text
    +
    +some more text

and commit (the `-a` means commit all changed files, the `-m` allows to add a commit message; but that can also be entered via editor [if you get dropped into vi-editor, esc and :wq to quit...])

    (master) $ git commit -a -m "Added some more text"
    [master be8dc47] Added some more text
     1 file changed, 2 insertions(+)

Make some more files

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

First need to `add` them

    (master) $ git add code.py subdir/ttt
    (master) $ git commit -am "More more more"
    [master 4d95572] More more more
     2 files changed, 2 insertions(+)
     create mode 100644 code.py
     create mode 100644 subdir/ttt

Look at the history with `log` (showing most recent commit at the top).  Note the long hexa-decimal number, that is the SHA1 hash of the commit (a number which uniquely identifies it).

    (master) $ git log
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

Make a branch, which is a new strand in the history.  Typically used for a task and then merged into the master branch once completed.  The `-c` in `switch` first creates the branch and then switches to it.  Often on Github people will prepend their branchname with a short version of their username, thus I usually use `m3/` as I am `mauro3` there; note that `/` is no directory-something, just part of the name.

    (master) $ git switch -c m3/a-branch
    Switched to a new branch 'm3/a-branch'

Do some work on the branch

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

Finished with the work on the branch.  Go back to the master branch (side note, these days it main branch is often called `main`)

    (m3/a-branch) $ git switch master
    Switched to branch 'master'

Compare the master branch with `m3/a-branch` branch

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

By the way, one can also setup graphical diff-tools.  For me, on Linux, I use `meld`:

    (master) $ git difftool m3/a-branch

Do some work on master

    (master) $ echo "TTT" >> subdir/ttt
    (master) $ git commit -am "stuff"
    [master c603696] stuff
     1 file changed, 1 insertion(+)

Go back to the other branch.  We now want to get the work into master.  Typically one first merges master into the feature branch:

    (master) $ git switch m3/a-branch
    Switched to branch 'm3/a-branch'
    (m3/a-branch) $ git merge master -m "getting latest changes from master"
    Merge made by the 'ort' strategy.
     subdir/ttt | 1 +
     1 file changed, 1 insertion(+)

We see that we now have the changes done on master also on this branch

    (m3/a-branch) $ cat subdir/ttt
    Text text
    TTT

Now switch back to master and merge the feature branch into it.  This will now be a so-called "fast-forward" which is a trivial merge.

    (m3/a-branch) $ git switch master
    Switched to branch 'master'
    (master) $ git merge m3/a-branch
    Updating c603696..140a841
    Fast-forward
     text-file.txt | 4 +---
     1 file changed, 1 insertion(+), 3 deletions(-)

# Get repo onto Github

Just follow the instructions for pushing an existing repo to Github.  Initialize the repo without readme and license as that would create a non-empty repo to which we cannot just push.  Probably choose the "HTTPS" and you should get instructions something like

    git remote add origin https://github.com/mauro3/GitDemoRepo.git
    git branch -M main
    git push -u origin main

I will also need to change `main` -> `master` as my default branch is called `master`.  But you may not have to do that.

This will look something like

    (master) $ git push -u origin master
    Enumerating objects: 20, done.
    Counting objects: 100% (20/20), done.
    Delta compression using up to 16 threads
    Compressing objects: 100% (11/11), done.
    Writing objects: 100% (20/20), 1.54 KiB | 790.00 KiB/s, done.
    Total 20 (delta 3), reused 0 (delta 0), pack-reused 0 (from 0)
    remote: Resolving deltas: 100% (3/3), done.
    To github.com:mauro3/GitDemoRepo.git
     * [new branch]      master -> master
    branch 'master' set up to track 'origin/master'.

Reloading/visiting the webpage will now show the content.

Note that the default remote is by convention called `origin`, but you could choose something else as well.  One can have several remotes (advanced).  Remotes can be shown with

    (master) $ git remote -v
    origin  git@github.com:mauro3/GitDemoRepo.git (fetch)
    origin  git@github.com:mauro3/GitDemoRepo.git (push)

(note that I use the ssh-connection, yours will probably show `https` something).

# The merge conflict demo

Merge conflicts occur when changes overlap, e.g. in both branches the same function is changed.  Then git does not know how to unify them.  But git will notice the situation and manual intervention is needed.


This is a record of a demo session illustrating merge conflicts, where Alice and Bob edit the same file.  Left hand column is Alice's terminal session, right hand side is Bob's.
Notes:
- `zile` is an editor,
- there is also a recording of this which will show some extra stuff, like the edits done with `zile`
- further reading [Git book](https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging).

```
| Alice                                               | Bob                                                    |
|-----------------------------------------------------|--------------------------------------------------------|
| State: empty repo cloned to A/ and B/               |                                                        |
|-----------------------------------------------------|--------------------------------------------------------|
| merge-demo/A(master)  >> zile fns.jl                |                                                        |
| merge-demo/A(master)  >> git add fns.jl             |                                                        |
| merge-demo/A(master)  >> git commit -m "A: fns.jl"  |                                                        |
| merge-demo/A(master)  >> git push                   |                                                        |
| Enumerating objects: 3, done.                       |                                                        |
| Counting objects: 100% (3/3), done.                 |                                                        |
| Delta compression using up to 16 threads            |                                                        |
| Compressing objects: 100% (2/2), done.              |                                                        |
| Writing objects: 100% (3/3), 284 bytes              |                                                        |
| Total 3 (delta 0), reused 0 (delta 0)...            |                                                        |
| To merge-demo/repo                                  |                                                        |
| * [new branch]      master -> master                |                                                        |
|                                                     |                                                        |
|                                                     |                                                        |
|                                                     | merge-demo/B >> git pull                               |
|                                                     | remote: Enumerating objects: 3, done.                  |
|                                                     | remote: Counting objects: 100% (3/3), done.            |
|                                                     | remote: Compressing objects: 100% (2/2), done.         |
|                                                     | remote: Total 3 (delta 0), reused 0 (delta 0), ...     |
|                                                     | Unpacking objects: 100% (3/3), 264 bytes ...           |
|                                                     | From merge-demo/repo                                   |
|                                                     | * [new branch]      master     -> origin/master        |
|                                                     | merge-demo/B(master)  >> ls                            |
|                                                     | fns.jl                                                 |
|                                                     |                                                        |
|-----------------------------------------------------|--------------------------------------------------------|
| Both have fns.jl                                    |                                                        |
| Action: both edit fns.jl at the same time at the    |                                                        |
| same location                                       |                                                        |
|-----------------------------------------------------|--------------------------------------------------------|
|                                                     |                                                        |
| merge-demo/A(master)  >> zile fns.jl                | merge-demo/B(master)  >> zile fns.jl                   |
| merge-demo/A(master)  >> git commit -am "A: d arg"  | merge-demo/B(master)  >> git commit -am "B: kwarg"     |
| [master e8255c8] A: d arg                           | [master 5c4c061] B: d kwarg                            |
| 1 file changed, 3 insertions(+), 3 deletions(-)     | 1 file changed, 3 insertions(+), 3 deletions(-)        |
|                                                     |                                                        |
|-----------------------------------------------------|--------------------------------------------------------|
| Alice pushes first                                  |                                                        |
|-----------------------------------------------------|--------------------------------------------------------|
|                                                     |                                                        |
| merge-demo/A(master)  >> git push                   |                                                        |
| Enumerating objects: 5, done.                       |                                                        |
| Counting objects: 100% (5/5), done.                 |                                                        |
| Delta compression using up to 16 threads            |                                                        |
| Compressing objects: 100% (2/2), done.              |                                                        |
| Writing objects: 100% (3/3), ..., done.             |                                                        |
| Total 3 (delta 0), reused 0 (delta 0)...            |                                                        |
| To merge-demo/repo                                  |                                                        |
| 65f7f3a..e8255c8  master -> master                  |                                                        |
|                                                     |                                                        |
|-----------------------------------------------------|--------------------------------------------------------|
| Now Bob cannot push because there are               |                                                        |
| commits on the repo which he doesn't have.          |                                                        |
|-----------------------------------------------------|--------------------------------------------------------|
|                                                     |                                                        |
|                                                     | merge-demo/B(master)  >> git push                      |
|                                                     | To merge-demo/repo                                     |
|                                                     | ! [rejected]        master -> master (fetch first)     |
|                                                     | error: failed to push some refs to                     |
|                                                     | '~/teaching/2023-CORDS-WSL/tmp/merge-demo/repo'        |
|                                                     | hint: Updates were rejected because the remote         |
|                                                     | hint: contains work that you do not have locally.      |
|                                                     | hint: This is usually caused by another repository     |
|                                                     | hint: pushing to the same ref. If you want to          |
|                                                     | hint: integrate the remote changes, use                |
|                                                     | hint: 'git pull' before pushing again.                 |
|                                                     | hint: See the 'Note about fast-forwards'               |
|                                                     | hint: in 'git push --help'                             |
|                                                     |                                                        |
|-----------------------------------------------------|--------------------------------------------------------|
| Bob now pulls first.  In the best case this         |                                                        |
| just works (when there are no trivial changes,      |                                                        |
| this would be a "fast-forward" merge)               |                                                        |
|-----------------------------------------------------|--------------------------------------------------------|
|                                                     | Merge-demo/B(master)  >> git pull                      |
|                                                     | remote: Enumerating objects: 5, done.                  |
|                                                     | remote: Counting objects: 100% (5/5), done.            |
|                                                     | remote: Compressing objects: 100% (2/2), done.         |
|                                                     | remote: Total 3 (delta 0), reused 0 (delta 0)          |
|                                                     | Unpacking objects: 100% (3/3), 290 bytes ...           |
|                                                     | From merge-demo/repo                                   |
|                                                     | 65f7f3a..e8255c8  master     -> origin/master          |
|                                                     | hint: Diverging branches can't be fast-forwarded       |
|                                                     | hint: you need to either:                              |
|                                                     | hint:                                                  |
|                                                     | hint: 	git merge --no-ff                            |
|                                                     | hint:                                                  |
|                                                     | hint: or:                                              |
|                                                     | hint:                                                  |
|                                                     | hint: 	git rebase                                   |
|                                                     | hint:                                                  |
|                                                     | hint: Disable this message with                        |
|                                                     | hint: "git config advice.diverging false"              |
|                                                     |                                                        |
|                                                     | fatal: Not possible to fast-forward, aborting.         |
|-----------------------------------------------------|--------------------------------------------------------|
| There are some changes which are non-trivial        |                                                        |
| so they need to be merged somehow.                  |                                                        |
| Start with looking at the `diff`, if ok `merge`.    |                                                        |
|-----------------------------------------------------|--------------------------------------------------------|
|                                                     | merge-demo/B(master)  >> git diff origin/master        |
|                                                     |                                                        |
|                                                     |                                                        |
|                                                     | merge-demo/B(master)  >> git merge origin/master       |
|                                                     | Auto-merging fns.jl                                    |
|                                                     | CONFLICT (content): Merge conflict in fns.jl           |
|                                                     | Automatic merge failed; fix conflicts and              |
|                                                     | then commit the result.                                |
|-----------------------------------------------------|--------------------------------------------------------|
| If there are no conflicting changes, i.e. no        |                                                        |
| changes touched the same lines of the code.         |                                                        |
| Then the merge will just succeed and you are        |                                                        |
| prompted to enter a merge-commit message.           |                                                        |
| (NOTE: just because there are no conflicting lines  |                                                        |
| does not guarantee that there is no conflict in     |                                                        |
| logic!  But this you need to be sure and that is    |                                                        |
| why we did the `git diff` in the previous step).    |                                                        |
|                                                     |                                                        |
| However, there are conflicts, so we need to merge   |                                                        |
| them manually. Always good start with `status`:     |                                                        |
|-----------------------------------------------------|--------------------------------------------------------|
|                                                     | merge-demo/B(master)  >> git status                    |
|                                                     | On branch master                                       |
|                                                     | Your branch and 'origin/master' have diverged,         |
|                                                     | and have 1 and 1 different commits each,               |
|                                                     | respectively.                                          |
|                                                     | (use "git pull" if you want to integrate               |
|                                                     | the remote branch with yours)                          |
|                                                     |                                                        |
|                                                     | You have unmerged paths.                               |
|                                                     | (fix conflicts and run "git commit")                   |
|                                                     | (use "git merge --abort" to abort the merge)           |
|                                                     |                                                        |
|                                                     | Unmerged paths:                                        |
|                                                     | (use "git add <file>..." to mark resolution)           |
|                                                     | both modified:   fns.jl                                |
|                                                     |                                                        |
|                                                     | no changes added to commit                             |
|                                                     | (use "git add" and/or "git commit -a")                 |
|-----------------------------------------------------|--------------------------------------------------------|
| Now Bob needs to edit his file.  The locations      |                                                        |
| where there are merge conflicts will be marked with |                                                        |
| <<<<<<<< ===== and >>>>>>.  Edit them like any text |                                                        |
| to make a merged version.  Remember, there might    |                                                        |
| be logical merge-issues (even in other files) as    |                                                        |
| well, fix those too.  Do as git says, mark the      |                                                        |
| resolution with `add` then commit                   |                                                        |
|-----------------------------------------------------|--------------------------------------------------------|
|                                                     | merge-demo/B(master)  >> zile fns.jl                   |
|                                                     | merge-demo/B(master)  >> git add fns.jl                |
|                                                     | merge-demo/B(master)  >> git commit -m "merged: use B" |
|                                                     | [master 772bc95] B: better                             |
|                                                     | merge-demo/B(master)  >> git push                      |
|                                                     | Enumerating objects: 8, done.                          |
|                                                     | Counting objects: 100% (8/8), done.                    |
|                                                     | Delta compression using up to 16 threads               |
|                                                     | Compressing objects: 100% (3/3), done.                 |
|                                                     | Writing objects: 100% (4/4), 442 bytes ...             |
|                                                     | Total 4 (delta 1), reused 0 (delta 0), ...             |
|                                                     | To merge-demo/repo                                     |
|                                                     | e8255c8..772bc95  master -> master                     |
|-----------------------------------------------------|--------------------------------------------------------|
| If Alice pulls now, it works fine and she gets      |                                                        |
| Bob's changes                                       |                                                        |
|-----------------------------------------------------|--------------------------------------------------------|
|                                                     |                                                        |
| merge-demo/A(master)  >> git pull                   |                                                        |
| remote: Enumerating objects: 8, done.               |                                                        |
| remote: Counting objects: 100% (8/8), done.         |                                                        |
| remote: Compressing objects: 100% (3/3), done.      |                                                        |
| remote: Total 4 (delta 1), reused 0 (delta 0)       |                                                        |
| Unpacking objects: 100% (4/4), 422 bytes  done.     |                                                        |
| From merge-demo/repo                                |                                                        |
| e8255c8..772bc95  master     -> origin/master       |                                                        |
|                                                     |                                                        |
| Updating e8255c8..772bc95                           |                                                        |
| Fast-forward                                        |                                                        |
| fns.jl \| 4 ++--                                    |                                                        |
| 1 file changed, 2 insertions(+), 2 deletions(-)     |                                                        |
| merge-demo/A(master)  >> git log                    |                                                        |
| merge-demo/A(master)  >>                            |                                                        |
|                                                     |                                                        |
|-----------------------------------------------------|--------------------------------------------------------|
| If Alice pulls now, it works fine and she gets      |                                                        |
| Bob's changes                                       |                                                        |
|-----------------------------------------------------|--------------------------------------------------------|
```

Looking at the graph of the history now with `git log --graph` we see that the history is now non-linear with a divergence which then gets merged:
```
merge-demo/B(master)  >> git log --graph

*   commit 6619f0e0498628d9ce39845c7bb26351b8ce5f90 (HEAD -> master)
|\  Merge: 5a13367 643c456
| | Author: Mauro Werder <mauro3@runbox.com>
| | Date:   2024-06-14 14:14:57 +0200
| |
| |     merged: use B
| |
| * commit 643c456fcff3f46e0f5e99c92f8cfd914b289a5a (origin/master)
| | Author: Mauro Werder <mauro3@runbox.com>
| | Date:   2024-06-14 14:13:32 +0200
| |
| |     A: d arg
| |
* | commit 5a13367b46ac029f5329fb5ec757741d0acfad96
|/  Author: Mauro Werder <mauro3@runbox.com>
|   Date:   2024-06-14 14:13:43 +0200
|
|       B: kwarg
|
* commit 5abb8254adbcd6e7fc94da27d5756465988fddc5
  Author: Mauro Werder <mauro3@runbox.com>
  Date:   2024-06-14 14:12:58 +0200

      A: fns.jl
```
Note that commits `5a13` and `643c` are parallel and commit `6619` then merges the two strands again.
