# L06
### Making model runs reproducible

Apart from the input data needed to run a model, there are other things which need to be kept track of to make model runs reproducible.  For instance our `simple.*` example may well produce different results as we continue to develop the code (new features, bug fixes, etc.).

---

### What can change?  What needs to be kept track of?

1. the computer's software stack
2. dependencies
3. the code itself
4. model parameters
5. ???

Point 1 is important but this we will not cover as the tools needed for this are reasonably complicated (virtual machines and docker come to mind, see caveats [L05](L05_dependencies.md#caveats-of-virtual-environments)).

---

### How can we store the information to make runs reproducible?

The easiest solution, I find, is

- keep all information related to points 2.-4. in the git repository of the project.
- store the git hash of the current commit with the produced results (this assumes that it is clear/can be found out which script produced the results)
- if we were to, say, publish a paper or report, state what version (commit hash, tag, release) of the code was used

---

### This may not be good enough for large project with lots of model runs or complicated pipelines

If there are **many model runs** with many different parameters, things can get out of hand...

- main-script to collect all runs?
- make a save-function which stores model runs in a table
- often this is encountered during the exploratory phase of research
- use tools ranging from
  - pretty simple, e.g. [DrWatson.jl](https://github.com/JuliaDynamics/DrWatson.jl)
  - vast, e.g. [Renku](https://renkulab.io/)
  - vaster, e.g. [OpenBIS](https://sis.id.ethz.ch/services/rdm/openbis.html)

---

If there is a **complicated pipeline** with different and long-running jobs, then a pipeline tool might be needed.  Such a tool takes care the right part of a pipeline are re-run if something changes somewhere.

- GNU make, the classic, [link](https://goodresearch.dev/pipelines#document-pipelines-with-make) to a description in our context
- more modern variants (un-tested by me):
  - "The {targets} R package user manual" https://books.ropensci.org/targets/
  - "Python pipline" https://pydoit.org/
  - "Julia pipeline" https://github.com/cihga39871/Pipelines.jl
  - [Renku](https://renkulab.io/) has "workflows" which look like this
- List of pipeline softwares https://github.com/pditommaso/awesome-pipeline

---

However, in the end, i.e. for the publication, the approach advertised here --using a main-script to produce it all-- should work again.  And that is certainly a good way to submit it.
