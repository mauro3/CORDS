## Handling Dependencies
- Reproducibility means that you need anyone to recreate the minimal environment to run your scripts (to share your code)
- It is also good for yourself!
- This is best done with **package managers** and **virtual environments** 
- Understanding package management (and package development) is vital when you want to get good at a language.

### What is a dependency
dependency is another, independent package that a given project uses and requires to be able to run

### What is a Package Manager?

A **package manager** like `conda`, `Pkg` or `renv` automates the process of installing, upgrading, configuring, and managing software packages or libraries. It simplifies the installation of libraries and manages dependencies, ensuring that the correct versions of packages are used.


### What is a virtual environment?

A **virtual environment** is an isolated environment where you can install and manage packages and dependencies separately from the system-wide installation. This isolation ensures that different projects can have different dependencies and versions of packages without causing conflicts.

**Virtual environments** are crucial when you need to handle different versions of dependencies across your different projects. You could try to use one environment for all your projects, but that may quickly lead to conflicts in your dependencies.


An environment consists of a certain Python version and some packages. A virtual environment allows you to have multiple, independent versions of python on your system. Environments can also be saved so that you can install all of the packages and replicate the environment on a new system.

Why use one:

to deliver code and keep it the same versions
to use contribute to a package you also use
to install on servers
to share your environment with others


#### Multilanguage overview

|  | Python | R | Julia |
| --- | --- | --- | --- |
| **Package Manager** | `pip` or `conda` (see also `mamba`) | `install.packages()` (base R) | `Pkg` |
| **Package Repository** | PyPI (Python Package Index), `conda-forge` | CRAN (Comprehensive R Archive Network) | General registry |
| **Distribution Format** | `.whl` (wheel, incl binaries) or `tar.gz` (source) | `.tar.gz` (source and/or binary) | `Pkg` will git clone from source, and download (binary) artifacts |
| **Virtual Environment** | `venv`, `virtualenv`, `conda env` | `renv` | Built-in in the `Pkg` module |
| **Dependency Management** | `requirements.txt` or `Pipfile` (`pip`), or `environment.yml` (`conda env`) or `pyproject.toml` (`poetry`) | `DESCRIPTION`, `NAMESPACE` | `Project.toml`, `Manifest.toml`, `Artifacts.toml` |

An interesting difference is that some languages, like Python and Rust, have a package manager that is called from outside the language, so from your operating system's command line, while others like in Julia and R are called from inside the programming language itself.


#### `conda`
```bash
conda create --name myenv
conda activate myenv
conda install numpy
conda deactivate
```

- [Excellent tutorial](https://carpentries-incubator.github.io/introduction-to-conda-for-data-scientists/04-sharing-environments/index.html)
- [Other good resource](https://earth-env-data-science.github.io/lectures/environment/python_environments.html)
- [See how to install directly from github repository](https://medium.com/i-want-to-be-the-very-best/installing-packages-from-github-with-conda-commands-ebf10de396f4)
- lightweight alternative: `miniconda`
- lightweight and faster alternative: `minimamba`
  - In order to put together an actual python environment from your package specifications, conda has to solve a difficult puzzle. Each package specified has certain dependencies on other packages. For example, Xarray depends on Numpy, Pandas, and several others. Moreoever, each version of Xarray requires certain minimum versions of other packages (e.g. Xarray 0.19 requires Numpy >= 1.17 and Pandas >= 1.0). Other packages in your environment may have different or incompatible versions. Finding a combination of packages that are mutually compatible can be framed mathematically as a boolean satisfiability problem.
  - The default “solver” of this problem for conda can be slow It is not unheard of to spend 30 minutes or more solving large environments!
  - with `mamba` or `minimamba` you can install environments and packages as before, but using the mamba command instead of conda. Everything will be faster.


- To see all the environments on your system:
```conda info --envs```

**NOTE**
how to chose which of the main strategies to use: virtualenv and pip or conda

conda comes from Anaconda and does both package management and provides a virtual environment.

pip is the main python package installer

virtualenv creates environments and are pip install compatible.

Making your own packages pip installable requires fewer dependencies, so we’ll focus on virtualenv and pip in this workshop

##### `renv`

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
- See [`renv` vignette](https://rstudio.github.io/renv/articles/renv.html)

##### `Pkg`

```julia
using Pkg

# Create a new project environment
Pkg.activate("path/to/MyProject")

# Add packages to the project environment
Pkg.add("DataFrames")
```

- Other syntax
  - You can also use the REPL by typing `]`

  ```
  (@v1.10) pkg> add DataFrames
  ```
  - or string macro ```pkg"add DataFrames"```
- See [Pkg documentation](https://pkgdocs.julialang.org/v1/getting-started/)

###### Julia trick
- Global shared environment is inherited in custom environment!
```
               _
   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 1.10.2 (2024-03-01)
 _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
|__/                   |

(@v1.10) pkg> st
Status `~/.julia/environments/v1.10/Project.toml` (empty project)

(@v1.10) pkg>
```

- It is a good idea to install utility packages that you will use for development but that are not mandatory to run your code in the base environment
  - For instance, the macro `@btime` from `BenchmarkTools` is very handy to profile code. But you may not want to have `BenchmarkTools` in your dependencies. Just install it in base, and then you will be able to call 
    ```julia 
    using BenchmarkTools
    ```
    within your custom environment.
  - Other utility packages
    - `Test`,
    - [`TestEnv`](https://github.com/JuliaTesting/TestEnv.jl),
    - `Revise`
    - `LocalRegistry`
- **To activate the environment**
```
using Pkg
cd("path/to/MyProject")
Pkg.activate(".")
Pkg.instantiate()

# and then they can run the script
include("another_script.jl")
```
The function `Pkg.instantiate` will install all the packages exactly according to the Manifest.toml. So your colleague will use the exact same versions as you did.

That's it! Modern programming languages come with a simple package manager for the purpose of sharing reproducible code.

### Environment files
- Environment files are used to define and manage the dependencies and configurations required for a specific project. They specify the exact versions of libraries and packages needed, ensuring that the project can be replicated and run in any environment without issues. Environment files play a crucial role in creating reproducible research and development setups.

- configuration files, usually `.toml`, `.yml`.

- Always version control your environment.yml files!

#### Python
- `conda env` reads `.yml`, which can take any names.
- `.yml` file not created automatically!
- **Create `environment.yml` with**
```
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
- Not using `--from-history` will result in listing **all** dependencies, those installed explicitly AND implicitly. For reproducibility, you are better off using only explicit dependencies.
- `conda-Forge` is a community-driven channel that often has more up-to-date packages and a broader selection than the default Anaconda repository. You should use it
  - Conda Forge is always free from commercial license restrictions
  - Conda Forge generally has the largest volume of packages and the most up-to-date versions
  - You can contribute your own packages to conda forge! This is not covered by this book, but you can read about it in the Conda Forge docs.
- Conda channels are the locations where packages are stored. They serve as the base for hosting and managing packages. Conda packages are downloaded from remote channels, which are URLs to directories containing conda packages. The conda command searches a set of channels. 
- Conda-forge is a community channel made up of thousands of contributors. Conda-forge itself is analogous to PyPI but with a unified, automated build infrastructure and more peer review of recipes.
- `conda` and `pip`
  - Some packages are only available through PyPi (pip)
  - You can install pip packages within a conda env
  ```yml
    - pip=19.1
    - pip:
      - kaggle==1.5
      - yellowbrick==0.9
  ```
  - Note the double ‘==’ instead of ‘=’ for the pip installation and that you should include pip itself as a dependency and then a subsection denoting those packages to be installed via pip
  - [Good resource on managing packages with pip](https://note.nkmk.me/en/python-pip-install-requirements/)
  - Conda first approach
    - Always try to install packages using Conda first, especially for complex dependencies or those requiring compiled binaries (e.g., numpy, pandas, scipy). If a package is not available in Conda, install it using Pip within the Conda environment.


- **Installing from `environment.yml`**
```bash
conda env create --prefix ./.env --file environment.yml
```

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

#### Julia
- In Julia, the environment is defined using two files: Project.toml and Manifest.toml. The `Project.toml` file lists the direct dependencies, while the `Manifest.toml` file captures the full dependency graph, including all transitive dependencies. The `Manifest.toml` file may not be tracked in a project, and will be reconstructed if missing. `Artifacts.toml` is used to handle (binary) artifacts.
  - Julia uses a system of artifacts to handle binary dependencies, which can be declared in a package's Artifacts.toml file. The wrapper package generated by BinaryBuilder.jl will already have this Artifacts.toml file. The wrapper package will also have regular Julia functions automatically generated for all the ccall functions, which you can use in your Julia code.
- For reproducibility, include `Manifest.toml` in your git repo


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
- [see here for more info](https://pkgdocs.julialang.org/v1/toml-files/)

### Package Repository

When you install a package, the source code and all of its dependencies need to be downloaded from somewhere. Most programming languages use a central location that stores copies of the source code and/or compiled binaries, for every version of a package. Julia is slightly different, using a registry that contains links to the source code.

- Python: Packages are hosted on PyPI, the Python Package Index.
- R: CRAN is the primary repository for R packages.
- Julia: Packages are registered in the General registry. Note these are only links to the (Github) source code. Binary artifacts are built with Yggdrasil and BinaryBuilder.jl.


### Interactive environments
- Jupyter notebooks can use `Pkg`, `conda` and `renv` environments
  - see [Making Jupyter aware of your Conda environments](https://carpentries-incubator.github.io/introduction-to-conda-for-data-scientists/04-sharing-environments/index.html#making-jupyter-aware-of-your-conda-environments)
  - see also this resource https://medium.com/@nrk25693/how-to-add-your-conda-environment-to-your-jupyter-notebook-in-just-4-steps-abeab8b8d084
  - but the process is easier with VSCode
- Pluto notebooks are designed to be reproducible. Under the hood they contain the package environment inside them (check by viewing the Pluto .jl files in your favorite text editor). This can make it easier to share a Pluto notebook instead of a script or package.
- Binder
  - "Binder allows you to create custom computing environments that can be shared and used by many remote users. It is powered by BinderHub, which is an open-source tool that deploys the Binder service in the cloud. One-such deployment lives … at mybinder.org and is free to use."
  - relying on JupyterHub and Docker
  - [see tutorial here](https://earth-env-data-science.github.io/lectures/environment/binder.html)

### Caveats
The some packages/libraries rely on system libraries and utilities, for instance, 
- rmarkdwon relies on pandoc, but pandoc is not bundled with the rmarkdown package. That means restoring rmarkdown from the lockfile is insufficient to guarantee exactly the same rendering of RMarkdown documents. 
- pytorch relies on CUDA drivers, which are specific to machine
  - [See how you can deal with data with conda here](https://carpentries-incubator.github.io/introduction-to-conda-for-data-scientists/05-managing-cuda-dependencies/index.html)
- Use containers!
  - [Docker](https://docs.docker.com/get-started/) or Singularity are popular solutions. 
    - See vignette("docker", package = "renv") for recommendations on how Docker can be used together with renv.
    - see [Reproducible Computational Environments Using Containers: Introduction to Docker](https://carpentries-incubator.github.io/docker-introduction/)
    - 
- Benefits of containers
  - Containers are similar to a environment files, in the sense that it describes things that your code needs to run, but on a much larger scale.
  - For instance, you can specify what type of operating system you want your code to run on, or environment variables that should always be set for your code to work. Docker uses a file called a Dockerfile which contains a series of steps to package up your code into something that contains everything it needs to run, called an “image”.
- Caveats of containers
  - development is not as easy
    - But see [Using singularity as a development environment](https://rscdata_science.gitlab.io/rsc_data_science_blog/post/singularity_as_devel_env/)
    - and [How to remote dev with vscode and singularity](https://github.com/microsoft/vscode-remote-release/issues/3066#issuecomment-1019500216)
  - Singularity e.g. requires a Linux machine


## Advanced topic: package development

|  | Python | R | Julia |
| --- | --- | --- | --- |
| **Development Tools** | `setuptools`, `poetry` | `devtools` | `Pkg` |
| **Package Template Tools** | `cookiecutter`, `pyscaffold`, `flit` | `usethis`, `devtools` | `Pkg.generate()` , `PkgTemplates.jl` |
| **Tutorial** | [Python Packages book](https://py-pkgs.org/) (uses poetry) | [R packages book](https://r-pkgs.org/) | [Pkg docs](https://pkgdocs.julialang.org/v1/) and this [howto](https://julialang.org/contribute/developing_package/) |


## Take-home messages
- what are dependencies, package managers and virtual environments
- Clearly document all dependencies and environment setup instructions in project repositories.
- Provide setup scripts to automate environment creation and setup for new users or deployment.