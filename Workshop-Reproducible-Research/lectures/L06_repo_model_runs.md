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

### This may not be good enough for large project with lots of model runs

If there are many model runs with many different parameters, things can get out of hand...

- main-script to collect all runs?
- make a save-function which stores model runs in a table
- often this is encountered during the exploratory phase of research
- use tools ranging from
  - pretty simple, e.g. [DrWatson.jl](https://github.com/JuliaDynamics/DrWatson.jl)
  - vast, e.g. [OpenBIS](https://sis.id.ethz.ch/services/rdm/openbis.html)

However, in the end, i.e. for the publication, the approach advertised here --using a main-script to produce it all-- should work again.
<!-- .element: class="fragment" data-fragment-index="1" -->
