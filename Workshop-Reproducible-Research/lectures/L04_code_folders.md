# How to structure a code project

Our toy-project is growing, we now have model code, testing code, an synthetic example.  Currently they are all in the same folder, some of it even in the same file.  It's time to structure it more systematically.

## Folder structure

Programming languages typically have their own conventions, but often the folders follow this scheme
- a README.md file at the top level
- the "package" code, e.g. `src/`
- example usages, e.g. `examples/`
- scripts to run models, evaluation, etc., e.g. `scripts/`
- documentation (often generated), e.g. `docs/`

Note that we will get to where to put data and results a bit later, so far we're only developing the model.

<details>
<summary>Python Folder structure</summary>

```
|-- src/            # package code
|-- scripts/        # Custom analysis or processing scripts
|-- tests/
|-- examples/       # Example scripts using the package
|-- docs/           # documentation
 -- environment.yml # to handle project dependencies
 -- README.md
```

</details>

<details>
<summary>R Folder structure</summary>

```
|-- R/               # R scripts and functions (package code)
|-- scripts/         # Custom analysis or processing scripts
|-- man/             # Documentation files
|-- tests/
|-- examples/        # Example scripts using the package
|-- vignettes/       # Long-form documentation
 -- DESCRIPTION      # Package description and metadata
 -- NAMESPACE        # Namespace file for package
 -- README.md        # Project overview and details
```

</details>

<details>
<summary>Julia Folder structure</summary>

```
|-- src/            # package code
|-- scripts/        # Custom analysis or processing scripts
|-- test/
|-- examples/       # Example scripts using the package
|-- docs/           # documentation
 -- Project.toml    # to handle project dependencies
 -- README.md
```

</details>


## Turn the code into a "package"

There are typically ways to turn a code-project into an installable package.  This is in particular useful for code which other people (or yourself) use for different projects.  If our mass-balance model takes off, we can think of turning it into a package!  Again this differs from language to language and we will not look into it further.

Further reading for
- [Python](https://goodresearch.dev/setup#create-a-pip-installable-package-recommended)
- [R](https://statisticsglobe.com/create-package-r) (this one I cannot vouch for)
- [Julia](https://pkgdocs.julialang.org/v1/creating-packages/)
