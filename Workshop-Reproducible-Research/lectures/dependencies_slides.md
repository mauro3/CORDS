---
theme : "moon"
maxScale: "10"
minScale: "0.2"
width: 1920
height: 1080
---
<!-- -->

## Handling Dependencies
- Reproducibility means that you need anyone to recreate the minimal environment to run your scripts (to share your code)
- It is also good for yourself!
- This is best done with **package managers** and **virtual environments** 

---

- A **dependency** is a package that a given project uses and requires to be able to run 

- A **package manager** like `conda`, `Pkg` or `renv` **automates the process of installing, upgrading, configuring, and managing dependencies**.
  - Usually relies on a **package repository** that gathers in one place useful packages

- A **virtual environment** is an isolated environment where you can install and manage dependencies separately from the system-wide installation. 
  - This isolation ensures that different projects can have different dependencies and versions of packages without causing conflicts.

---

## Multilanguage overview

|  | Python | R | Julia |
| --- | --- | --- | --- |
| **Package Manager** | `pip`, `conda` (see also `mamba`), `poetry` | `install.packages()` (base R) | `Pkg` |
| **Package Repository** | PyPI (Python Package Index), `conda-forge` | CRAN (Comprehensive R Archive Network) | General registry |
| **Distribution Format** | `.whl` (wheel, incl binaries) or `tar.gz` (source) | `.tar.gz` (source and/or binary) | `Pkg` will git clone from source, and download (binary) artifacts |
| **Virtual Environment** | `venv`, `virtualenv`, `conda env` | `renv` | Built-in in the `Pkg` module |
| **Dependency Management** | `requirements.txt` or `Pipfile` (`pip`), or `environment.yml` (`conda env`) or `pyproject.toml` (`poetry`) | `DESCRIPTION`, `NAMESPACE` | `Project.toml`, `Manifest.toml`, `Artifacts.toml` |

---

## Multilanguage overview

- Julia or R have built-in package manager
```julia-repl
julia> # press ]
(@v1.8) pkg> add DataFrames
```
- but Python package managers are called from outside the language
```bash
mamba install pandas
```

---

## You need virtual environments for each independent projects!

### For yourself

- Without specifying a virtual environment, you install packages in your base environment, which is **BAD**!

  - Imagine you are working with Project A and Project B, which both depend on Package1 (currently @v1.1)
  - You leave Project A for a few months, and focus on Project B.
  - A new feature in Package1 motivated you to upgrade to v1.2, which imposes a certain syntax for the relevant function
  - You then want to come back to Project A, but now everything is broken!
    - Because your code has been formatted to work with Package1v1.1

- You want to make sure to compartmentalize environments.
  
### For sharing your code with others
- A virtual environemt tracks the minimum dependencies, which can easily be shared and installed on other machines

---

### Environment files

- Environment files specify the exact versions of the dependencies of your project, and are used by package managers to instantiate the environment
  - usually `.txt`, `.toml` or `.yml`.

#### Python 
- `conda env` reads `.yml`, which can take any names.

```yaml
name: machine-learning-env

channels:
  - pytorch
  - conda-forge

dependencies:
  - pytorch=1.1
```

- Always version control your environment.yml files!

---

### Interactive environments
- Jupyter notebooks can use `Pkg`, `conda` and `renv` environments

---

### Caveats
- Some packages/libraries rely on system libraries and utilities, for instance, 
  - `pytorch` relies on CUDA drivers, which are specific to machine
- Hence by replicating a virtual environment, you won't necessarily reproduce the same exact environment...
- Use containers!
  - containers virtualize the operating system, replicating to a deeper lever your environment and making it even more portable
    - operating system
    - environmental variables
    - drivers... 
  - [Docker](https://docs.docker.com/get-started/) or Singularity are popular solutions. 
- Caveats of containers: development is not as easy

---

##  Distinguishing between analysis dependencies and core functions dependencies
  - it may make sense to also compartmentalize the dependencies between `src` and `scripts`,
  - this is so that you have a minimal working environment to simply reuse the `src` functions and classes in other, related project. 
  - What can come handy is to specify the `src` folder as a package. You can do that easily with development tools

---

## Advanced topic: package development


|  | Python | R | Julia |
| --- | --- | --- | --- |
| **Development Tools** | `setuptools`, `poetry` | `devtools` | `Pkg` |
| **Package Template Tools** | `cookiecutter`, `pyscaffold`, `flit` | `usethis`, `devtools` | `Pkg.generate()` , `PkgTemplates.jl` |
| **Tutorial** | [Python Packages book](https://py-pkgs.org/) (uses poetry) | [R packages book](https://r-pkgs.org/) | [Pkg docs](https://pkgdocs.julialang.org/v1/) and this [howto](https://julialang.org/contribute/developing_package/) |

---

## Take-home messages
- Clearly document all dependencies and environment setup instructions in project repositories.
- Provide setup scripts to automate environment creation and setup for new users or deployment.
