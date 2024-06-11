## A multi-language overview on how to handle dependencies within a research project

Reproducibility in research projects requires that others (and future you) can recreate the minimal environment to run your scripts. This is best achieved using **package managers**  and **virtual environments**.


### What is a dependency
A **dependency**  is an external package that a project requires to run.

### What is a package manager?

A **package manager** like `conda`, `Pkg` or `renv` **automates the process of installing, upgrading, configuring, and managing dependencies**. It usually relies on a **package repository**, which is a central location that stores in one place the source code of packages or where to find it. 

### What is a virtual environment?

A **virtual environment** is an isolated environment where you can install and manage dependencies separately from the system-wide installation. This isolation ensures that different projects can have different dependencies and versions of packages without causing conflicts. Why use a virtual environment?

- For yourself, to best deal with multiple projects and to prevent your code from breaking down overtime. 
    - Without specifying a virtual environment, you install packages in your base environment, which is shared across all your projects. 
    - Imagine you are working with Project A and Project B, which both depend on Package1 (currently @v1.1).  
    - You leave aside Project A for a few months, and focus on Project B. 
    - A new feature in Package1 motivate you to upgrade to v1.2, which modifies the API or the behavior of one function used in both projects. 
    - You then want to come back to Project A, but now everything is broken! Because your code has been formatted to work with Package1@v1.1.
    - Hence, you want to make sure to compartmentalize environments.
- To share your environment with others individuals and machines. 
  - A virtual environement tracks the minimum dependencies, which can easily be shared and installed on other machines (e.g., a HPC).

### Multilanguage overview

|  | Python | R | Julia |
| --- | --- | --- | --- |
| **Package Manager** | `pip`, `conda` (see also `mamba`), `poetry` | `install.packages()` (base R) | `Pkg` |
| **Package Repository** | PyPI (Python Package Index), `conda-forge` | CRAN (Comprehensive R Archive Network) | General registry |
| **Distribution Format** | `.whl` (wheel, incl binaries) or `tar.gz` (source) | `.tar.gz` (source and/or binary) | `Pkg` will git clone from source, and download (binary) artifacts |
| **Virtual Environment** | `venv`, `virtualenv`, `conda env` | `renv` | Built-in in the `Pkg` module |
| **Dependency Management** | `requirements.txt` or `Pipfile` (`pip`), or `environment.yml` (`conda env`) or `pyproject.toml` (`poetry`) | `DESCRIPTION`, `NAMESPACE` | `Project.toml`, `Manifest.toml`, `Artifacts.toml` |

This table is very much inspired by [The Scientific Coder article](https://scientificcoder.com/comparing-package-management-in-python-r-julia-and-rust) on package managers.

Julia or R have built-in package managers which can be called within the REPL but Python package managers are called from outside the language.

### Package managers


#### `conda`
`conda` is a very appropriate package manager for scientific projects in Python. Over its older concurrent `pip`, it can handle python versions and all sorts non-python dependencies artifacts. With two lines of code, it allows someone to quickly install the virtual environment, without any pre-requiste python installation.

Here are some essential `conda` commands.

```bash
conda create --name myenv # creates new virtual environment
conda activate myenv # activate the environment
conda install numpy -c conda-forge # install a package
conda deactivate
```

Note that not using `-c conda-forge` will do just fine, but what is it? `conda-forge` is a community-driven **channel** (repository in the python jargon) that often has more up-to-date packages and a broader selection than the default Anaconda repository. You should use for several reasons, but mostly because `conda-forge` generally has the largest volume of packages and the most up-to-date versions

Note that some packages are only available through PyPi (`pip`). But you are covered for that: You can install `pip` packages within a `conda env`, by first activating the `conda env` and then normally using `pip`. `pip` should be part of your dependencies though. Always try to install packages using `conda` first.

We highly recommend using [`mamba`](https://mamba.readthedocs.io/en/latest/) as a drop-in replacement for `conda`, for much faster use.


**Some useful resources**
- [A good resource for better understanding difference between `mamba` and `conda`, and their lightweights alternatives](https://earth-env-data-science.github.io/lectures/environment/python_environments.html)

- [Advanced tutorial on using `conda` environments for a scientific project](https://carpentries-incubator.github.io/introduction-to-conda-for-data-scientists/04-sharing-environments/index.html) 

- [Tutorial on how to install a package directly from github repository](https://medium.com/i-want-to-be-the-very-best/installing-packages-from-github-with-conda-commands-ebf10de396f4)


#### `renv`

Here are some basics on how to use `renv`, but see the [renv vignette](https://rstudio.github.io/renv/articles/renv.html) and documentation for more advanced usage.

```r
# Initialize renv in your project
renv::init(project = "path/to/environment")

# Install a package and snapshot the environment
install.packages("dplyr")
renv::snapshot()
```

```r
# Load the renv environment for the project
renv::activate()

# Restore the project's dependencies
renv::restore()

renv::update()
```

```
renv::history()
renv::revert()
```

#### `Pkg`

```julia
using Pkg

# Create a new project environment
Pkg.activate("path/to/MyProject")

# Add packages to the project environment
Pkg.add("DataFrames")
```

You can also use the Julia REPL by typing `]`

```
(@v1.10) pkg> add DataFrames
```
or string macros ```pkg"add DataFrames"```


Not that in Julia, the global shared environment is inherited in custom environment. This can be useful!
It is a good idea to install utility packages that you will use for development but that are not mandatory to run your code in the global environment. For instance, the macro `@btime` from `BenchmarkTools` is very handy to profile code. But you may not want to have `BenchmarkTools` in your dependencies. Just install it in base, and then you will be able to call 
    ```julia 
    using BenchmarkTools
    ```
    within your custom environment.
Other utility packages to consider having in your global environments are
- `Test`,
- [`TestEnv`](https://github.com/JuliaTesting/TestEnv.jl),
- `Revise`
- `LocalRegistry`


### Environment files
Environment files specify the exact versions of the dependencies in your virtual environment, and are used by package managers to instantiate the environment. They are usually `.txt`, `.toml` or `.yml` files.

Always version control your environment files!


#### Julia
In Julia, the environment is defined using two files: the `Project.toml` and `Manifest.toml`. The `Project.toml` file lists the direct dependencies, while the `Manifest.toml` file captures the full dependency graph, including all transitive dependencies. The `Manifest.toml` file may not be tracked in a project, and will be reconstructed if missing. It specifies the exact version of the environment. For reproducibility, you want to include `Manifest.toml` in your git repo.
`Artifacts.toml` is used to handle non-Julia package dependencies.

##### Example `Project.toml`:

```toml
authors = ["Some One <someone@email.com>",
           "Foo Bar <foo@bar.com>"]
name = "MyEnv"
uuid = "7876af07-990d-54b4-ab0e-23690620f79a" # mandatory for packages
version = "1.2.5"

[deps]
DataFrames = "7876af07-990d-54b4-ab0e-23690620f79a"
Plots = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[compat]
CUDA = "4.4, 5"
julia = "1.10"
```

When you are located within the project root folder containing the `.toml` file, start julia with 

```bash
$ julia --project=.
```
This will load the environment. If it is the first time that you use it, you need to instantiate it with

```julia-repl
(Example) pkg> instantiate
```

**Some useful resources**
- [see here for more info on Julia `.toml` files here](https://pkgdocs.julialang.org/v1/toml-files/)


#### Python
`conda env` reads `.yml`, which can take any names. `.yml` files are not created automatically! Create `environment.yml` with
```bash
conda env export --name machine-learning-env --from-history --file environment.yml
```
This creates 
```yaml
name: machine-learning-env

channels:
  - pytorch
  - conda-forge

dependencies:
  - pytorch=1.1
```
Not using `--from-history` will result in listing **all** dependencies, those installed explicitly AND implicitly. This may be a bit messier. 

To specify `pip` packages, just insert in the `.toml`
  ```yml
    - pip=19.1
    - pip:
      - kaggle==1.5
      - yellowbrick==0.9
  ```

Note the double ‘==’ instead of ‘=’ for the pip installation and that you should include pip itself as a dependency and then a subsection denoting those packages to be installed via pip. Also, note that `--from-history` won't catch the pip dependencies. So the best way to proceed is to specify the dependencies by hand.

**Installing from `environment.yml`**
```bash
mamba env create --prefix ./.env --file environment.yml
```

**Some additional resources**
- [Good resource on managing packages with pip](https://note.nkmk.me/en/python-pip-install-requirements/)

#### R
`renv.lock`
```json
{
  "R": {
    "Version": "4.3.3",
    "Repositories": [
      {
        "Name": "CRAN",
        "URL": "https://cloud.r-project.org"
      }
    ]
  },
  "Packages": {
    "markdown": {
      "Package": "markdown",
      "Version": "1.0",
      "Source": "Repository",
      "Repository": "CRAN",
      "Hash": "4584a57f565dd7987d59dda3a02cfb41"
    },
    "mime": {
      "Package": "mime",
      "Version": "0.12.1",
      "Source": "GitHub",
      "RemoteType": "github",
      "RemoteHost": "api.github.com",
      "RemoteUsername": "yihui",
      "RemoteRepo": "mime",
      "RemoteRef": "main",
      "RemoteSha": "1763e0dcb72fb58d97bab97bb834fc71f1e012bc",
      "Requirements": [
        "tools"
      ],
      "Hash": "c2772b6269924dad6784aaa1d99dbb86"
    }
  }
}
```

As you can see the json file has two main components: R and Packages. The R component contains the version of R used, and a list of repositories where packages were installed from. The Packages contains one record for each package used by the project, including all the details needed to re-install that exact version. The fields written into each package record are derived from the installed package’s DESCRIPTION file, and include the data required to recreate installation, regardless of whether the package was installed from CRAN, Bioconductor, GitHub, Gitlab, Bitbucket, or elsewhere. You can learn more about the sources renv supports in vignette("package-sources").



### Interactive environments
Jupyter notebooks can use `Pkg`, `conda` and `renv` environments, but you may need some extra steps
  - see [Making Jupyter aware of your Conda environments](https://carpentries-incubator.github.io/introduction-to-conda-for-data-scientists/04-sharing-environments/index.html#making-jupyter-aware-of-your-conda-environments)
  - [see also this resource](https://medium.com/@nrk25693/how-to-add-your-conda-environment-to-your-jupyter-notebook-in-just-4-steps-abeab8b8d084)
  - Note that you do not need to follow these steps if you are using Visual Studio Code.

Other interactive notebooks solutions store directly the environemnts in the files, which is great for reproducibility purposes. This is the case of `Pluto` notebooks, which are designed to be reproducible. Under the hood they contain the package environment inside them `Binder` notebooks also ship with a virtual environment, but using `Docker` (see below and [a tutorial here](https://earth-env-data-science.github.io/lectures/environment/binder.html)).

I personally do not like notebooks, and prefer using scripts in Visual Studio Code, executing them line by line for development with whether the `Julia` extension or the Jupyter extension with `"jupyter.interactiveWindow.textEditor.executeSelection": true`. With such an approach, you can specify which virtual environment should be used at login, and never worry again with that later.

### Caveats of virtual environments
Some packages/libraries rely on system libraries and utilities; for instance `pytorch` relies on CUDA drivers, which are specific to a certain machine ([see how you can deal with CUDA drivers with `conda` here](https://carpentries-incubator.github.io/introduction-to-conda-for-data-scientists/05-managing-cuda-dependencies/index.html)), or the behavior of the packages my be dependent on system environmental variables. As such, by replicating a virtual environment, you won't necessarily reproduce the same exact computing environment. 
To reproduce more closely a computing environment, **containers** may be used. Containers virtualize layers of the operating system, replicating to a deeper lever your environment and making it more reproducible. [Docker](https://docs.docker.com/get-started/) or Singularity are popular solutions. Unfortunately, building containers may be difficult, and the virtualization may add a layer of complexity to your pipeline...
But see [Using singularity as a development environment](https://rscdata_science.gitlab.io/rsc_data_science_blog/post/singularity_as_devel_env/) and [How to remote dev with vscode and singularity](https://github.com/microsoft/vscode-remote-release/issues/3066#issuecomment-1019500216). Note that you could use both a container and a virtual environment... See [here a tutorial with `renv`](https://rstudio.github.io/renv/articles/docker.html).

**Some additional resources**
For more information, check [Reproducible Computational Environments Using Containers: Introduction to Docker](https://carpentries-incubator.github.io/docker-introduction/).


## Advanced topic: package development

It can make sense for research projects to distinguish between scripts placed in `scripts/` and reused functions, models, etc., placed in `src`. We'll cover that more broadly in another post. In such case, it is best to compartmentalize dependencies so as to have a minimal working environment for the `src/` functions and classes, independent of that for your `scripts`. One practical approach for this is to specify the `src` folder as a package. This has a few advantages, including

- not having to deal with relative position of files to call the functions in `src/`
- maximizing your productivity by creating a generic package additionally to your main research project.

You can achieve this easily with development tools.

For Python, tools like `setuptools` and `poetry` facilitate package development. If you're working in R, `devtools` is the go-to tool for developing packages. In Julia, the `Pkg` tool serves a similar purpose.

Package templates can be useful to simplify the creation of packages by generating package skeletons. In Python, checkout out `cookiecutter`. In R, check `usethis`. For Julia, use the `Pkg.generate()` built-in functionality, or the more advanced `PkgTemplates.jl` package.

Note that you may want at some point to locate your `src/` (and associated `tests`, `docs`, etc...) in a separate git repo.

**Some additional resources**
- [goodresearch tutorial](https://goodresearch.dev/setup#install-a-project-package) on how to install a project package
- the [Python Packages book](https://py-pkgs.org/) offers comprehensive guidance using `poetry`.
- the [R Packages book](https://r-pkgs.org/) covers all aspects of package development.
- the [Pkg documentation](https://pkgdocs.julialang.org/v1/) and this [how-to guide](https://julialang.org/contribute/developing_package/) for detailed instructions.


## Take-home messages
- Make sure you understand what are package managers, virtual environments, and dependencies both within your project scripts and at the system level.
- Clearly document all dependencies and environment setup instructions in project repositories.
- Provide instructions in an **Installation** section in the `readme.md` on how to set up the virtual environment.
- Check out these two toy research project repositories [in Julia]() and [Python](https://github.com/vboussange/rere), that implement what I believe good examples of research projects!