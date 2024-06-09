# L04
## How to structure a code project: Folder structure

Programming languages typically have their own conventions, but often the folders follow this scheme
- a README.md file at the top level
- the "package" code, e.g. `src/`
- example usages, e.g. `examples/`
- scripts to run models, evaluation, etc., e.g. `scripts/`
- documentation (often generated), e.g. `docs/`


Note that we will get to where to put data and results a bit later, so far we're only developing the model.
<!-- .element: class="fragment" data-fragment-index="1" -->

---
## Turn the code into a "package"

- There are typically ways to turn a code-project into an installable package.
- This is in particular useful for code which is reused.
- This is not super tricky but tricky enough that we'll skip it

Further reading for
- [Python](https://goodresearch.dev/setup#create-a-pip-installable-package-recommended)
- [R](https://statisticsglobe.com/create-package-r) (this one I cannot vouch for)
- [Julia](https://pkgdocs.julialang.org/v1/creating-packages/)
