# Reproducible Research Workshop

This is a hands-on workshop on reproducible research.  Here we provide the lectured content and the instructions for the hands-on project which will be coded as we advance through the workshop.

## Schedule
**Day 1 (10.6.2024)**

| Time          | Program             |
|---------------|---------------------|
| 8:30  - 8:45  | Arrival, name badge |
| 8:45  - 10:15 | Making a model      |
| 10:15 - 10:30 | Coffee break        |
| 10:30 - 12:15 | ???                 |
| 12:15 - 13:15 | Lunch at the mensa  |
| 13:15 - 15:00 | ???                 |
| 15:00 - 15:15 | Coffee break        |
| 15:15 - 17:00 |                     |
| 17:00         | Apero               |


**Day 2 (11.6.2024)**

| Time          | Program            |
|---------------|--------------------|
| 8:30  - 10:15 | ?                  |
| 10:15 - 10:30 | Coffee break       |
| 10:30 - 12:15 | ???                |
| 12:15 - 13:15 | Lunch at the mensa |
| 13:15 - 15:00 | ???                |
| 15:00 - 15:15 | Coffee break       |
| 15:15 - 17:00 |                    |
| 17:00 - 17:15 | wrap-up            |

## Further materials

- [Other Resources](resources.md)


## Table of Contents
L1 == Lecture 1
T3 == Task 3


| Topic                      | Lecture                                                                                          | Hands-on                                                                                                                                           |
|:---------------------------|:-------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------|
| Intro                      | L1: Why, what, how<br>  What we cover<br>  F(inputs) -> outputs<br>                              |                                                                                                                                                    |
|                            |                                                                                                  |                                                                                                                                                    |
| Get hands dirty            |                                                                                                  | T1: Start coding a glacier mass balance model: the melt function                                                                                   |
|                            |                                                                                                  |                                                                                                                                                    |
| Version control with Git   | L2: What is version control<br> Why use it <br>Short intro to git <br>How to collaborate on code | T2: team up someone, create a git repository on GitHub<br> give access to the other person<br> add melt function                                   |
|                            | As we go along: more advanced git (merge, pull request, etc)                                     |                                                                                                                                                    |
|                            |                                                                                                  |                                                                                                                                                    |
|                            |                                                                                                  | T3: work separately on precipitation function and lapse rate function.  Merge to code with git                                                     |
|                            |                                                                                                  |                                                                                                                                                    |
| Testing code               | L3: Why testing code is a good idea<br>Unit tests, integration tests<br>examples                 | T4: test the mel, precipitation and lapse function with "assertions"                                                                               |
|                            |                                                                                                  |                                                                                                                                                    |
|                            |                                                                                                  | T5: review, correct and accept Pull Request for integrated mass balance functions                                                                  |
|                            |                                                                                                  |                                                                                                                                                    |
|                            |                                                                                                  | T6: make an example, including a plot of the synthetic temperature                                                                                 |
|                            |                                                                                                  |                                                                                                                                                    |
| Reproducible model runs I  | L4: Storing information about the current repo state with results                                | T7: make a function which returns a file-name containing the Git-hash of the current commit.<br>Store the temperature plot using such a file name. |
|                            |                                                                                                  |                                                                                                                                                    |
| Reproducible model runs II | L4: Dependency management: how to install and keep track of code dependencies                    | T8: make a project environment (with conda, renv or Pkg); Add the plotting library as dependency                                                   |
|                            |                                                                                                  |                                                                                                                                                    |
| Doing a science project    | L5: How to do science with our model? Keeping track of things.  Folder structure.                | T9: setup a suitable folder structure.  Move the code git repository to `code/`                                                                    |
|                            |                                                                                                  |                                                                                                                                                    |
|                            |                                                                                                  |                                                                                                                                                    |
|                            |                                                                                                  |                                                                                                                                                    |
|                            |                                                                                                  |                                                                                                                                                    |
|                            |                                                                                                  |                                                                                                                                                    |
|                            |                                                                                                  |                                                                                                                                                    |
|                            |                                                                                                  |                                                                                                                                                    |
|                            |                                                                                                  |                                                                                                                                                    |
|                            |                                                                                                  |                                                                                                                                                    |
|                            |                                                                                                  |                                                                                                                                                    |
|                            |                                                                                                  |                                                                                                                                                    |
|                            |                                                                                                  |                                                                                                                                                    |
|                            |                                                                                                  |                                                                                                                                                    |
|                            |                                                                                                  |                                                                                                                                                    |
|                            |                                                                                                  |                                                                                                                                                    |
|                            |                                                                                                  |                                                                                                                                                    |
|                            |                                                                                                  |                                                                                                                                                    |
|                            |                                                                                                  |                                                                                                                                                    |
|                            |                                                                                                  |                                                                                                                                                    |
|                            |                                                                                                  |                                                                                                                                                    |
|                            |                                                                                                  |                                                                                                                                                    |
|                            |                                                                                                  |                                                                                                                                                    |
|                            |                                                                                                  |                                                                                                                                                    |
|                            |                                                                                                  |                                                                                                                                                    |
|                            |                                                                                                  |                                                                                                                                                    |
|                            |                                                                                                  |                                                                                                                                                    |
|                            |                                                                                                  |                                                                                                                                                    |
