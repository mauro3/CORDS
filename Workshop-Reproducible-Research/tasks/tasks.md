# The toy-project tasks

For the high-level overview, see [The toy research problem](the-toy-research-project.md).

For detail on the model, see [The mass balance model](the-mass-balance-model.md).

## T01: Start coding a glacier mass balance model: the melt function

- make a folder `CORDS` somewhere, where all the material of this course will end up
- make a file `CORDS/melt.*` in your favourite programming language and program the melt function
  - see [The mass balance model: melt function](the-mass-balance-model.md)
  - be sure to follow the function naming and API (application programming interface, here just a fancy way of saying make the function take the suggested arguments in the right order)

## T02: Team up with someone, create a git repository on GitHub and add the melt function to the repo

- make teams of two, programming the same language (the spreadsheet with the infos should help)
- on one person's Github account make a (empty) repository named `breithorn-toy-project-CORDS`
- give write access to the other person and also to @mauro3 and @vboussange (so it's easier for us to help)
  - "Settings" -> "Collaborators"
- make a clone of the repo
- move the `melt.*` file to the repo, `git add`, `git commit` and `git push` it.

## T03: Accumulation and lapse rate function.  Merge to code with git

- work on separately on the precipitation-function and lapse-rate-function; add them both to the `melt.*` file
- coordinate to get it into the git repo without conflicts:
  - agree who commits and pushes first
  - second person
    - do not commit yet
    - try `git pull` --> error
	- `git stash` this puts your changes somewhere away (in a stash); now your repo is clean
	- `git pull` now works
	- `git stash pop` get your stuff back from the stash
	- then git commit and push
  - first person pulls to get the changes
  - -> there are other ways of doing this but this works ok


## T04: Basic testing with assertions

- test the melt, accumulate and lapse function with "assertions"
  - test that melt is zero for T<0
  - test that accumulation is zero above threshold temp and nonzero below
  - etc

## T05: Review, correct and accept Pull Request (PR)

- we will try to make a PR against your repository to add
  - a total mass balance function
  - a total, glacier-wide mass balance function
- review the code of the PR by looking at the "diff"
- test it:
  - `git fetch` will get the latest changes from the repo
  - `git switch ...` where ... is the branch of the PR
  - run the `melt.*` file

--> this concludes the model

## T06: Make an example
To actually run the model and also for illustration and testing it is good to have an example.  Put the code into the file `simple.*`.  A example file with the basic structure is provided [simple-template.jl](simple-template.jl) (it's in Julia but should be adaptable quickly to other languages).

This is probably done best together (pair programming), i.e. working at one computer together.

To make an example, we need example input
- measurement times [d]: `t = 0:1/24:365` (this is a range from 0 to 365 with step 1.24)
- synthetic temperature [C] time series (this is at elevation 0m)\
  `T(t) = -10*cos(2pi/365 * t) - 8*cos(2pi* t) + 5`
- synthetic precipitation [m/d], just use a constant mean precipitation\
  `P(t) = 8e-3`
- an elevation at which to calculate the mass balance
  - single point at elevation 1500m
  - a glacier with
    - horizontal extent `x = 0:500:5000`
    - elevation `z(x) = x/5  + 1400`

Parameters
```
lapse_rate = -0.6/100
melt_factor = 0.005
T_threshold = 4
```

Do the following:
- Plot the `T` time series
- Run the model for one year at a point (no output to be further processed)
- Run the model for one year for the whole glacier and plot
- Run the glacier-wide model for temperature offsets `-4:1:4` and store the total balance in a variable `out`

Commit and push.

Phew, that was a lot!

## T07: Update folder structure of code

In [Lecture 04](L04_code_folders.md) we saw one way of having a folder layout for models.  Implement this (or a variation thereof suitable for your programming language) for your mass-balance model.

- this type of reorganisation is best done in just one repo whilst the other person waits
- if you move the files, you may have to re-add them to git.  Alternatively, you can use `git mv a b` to move them so git knows automatically
- once reorganised, commit.  Other person pulls

## T08: Dependency and environment setup

So far, probably the only dependency (apart from the programming language) is the plotting package.  This you probably also have in your global installation, so, that probably just worked.

- Create an environment for your code, for this follow the instructions in [Lecture 05](lectures/dependencies.md) for your programming language.
- add all dependencies to it.  Probably just the plotting package.

## T09: Tooling for reproducible model runs: a function which returns a file name with git commit hash

A simple way to store results in a reproducible way, is to add the git-hash (the thing you see in `git log`) to the file name.  If you ever want to reproduce it, you know where to go back to.

- make a file `src/utils.*` and include/load it in your main model script
- make a function `(basename, ext) -> "basename-xxxxxxxxxx[-dirty].ext" where xxxxxxxxxx is the git hash shortened to 10 digits.  It should append "-dirty" if there are not committed changes in the repository.
- use this in `simple.*` to store tables and plots

--> the tasks in `utils.*` and `simple.*` can be done concurrently!

Here a Julia version of this function:
```julia
using LibGit2
function make_sha_filename(basename, ext)
    # Open the git-repository in the current directory
    repo = LibGit2.GitRepoExt(".")

    # Get the object ID of the HEAD commit
    head_commit_id = LibGit2.head_oid(repo)
    # Convert the object ID to a hexadecimal string and take the first 10 characters
    short_hash = string(head_commit_id)[1:10]

    # check if there are uncommitted changes
    if LibGit2.isdirty(repo)
        postfix = short_hash * "-dirty"
    else
        postfix = short_hash
    end

    return basename * "-" * postfix * ext
end
```

Try to re-implement it in your language.  You will probably need a package to interact with git, add that to your environment:
- Python: probably use `GitPython` package
- R: probably use `gert` package

--> if you struggle, ask ChatGPT for a translation.

Commit & push

In the `simple.*` example use this to store a plot (as a png-file) and the temperature table (as a csv file).

Commit & push

## T10: Documentation

Add documentation to your model:
- add docstrings to the functions
- add code comments where needed
- add a README to explain the package at a high level.  Link to the example

--> ChatGPT is pretty good at writing documentation, if a bit verbose.  Try it.

## T11: License file

- Pick a license suitable for your project (probably dictated by standards of the used programming language)
- add the LICENSE file (grab it from https://opensource.org/licenses)
- commit and push

## T12: Now running the model for a real glacier: get organised with those folders

- make a folder `research-project-breithorn`
- setup the folder structure within that as discussed in  [Lecture 05](lectures/project-structure.md), or as deemed suitable by yourself
- just move your code repository into that folder structure, if needed (git does not care if its parent folder is moved or renamed).  Recommended to place it in `research-project-breithorn/code`.

## T13: Tooling for reproducible data handling: make a download function

Place this in the `src/utils.*` file.

Make a data download function such that you can script the data downloads easily
- for Python add the `requets` library to the env https://docs.python-requests.org/en/latest/index.html
- for R, add `httr` package

A Julia example is this:
```julia
function download_file(url, destination_file)
    # make sure the directory exists
    mkpath(splitdir(destination_file)[1])

    if isfile(destination_file)
        # do nothing
        println("Already downloaded $destination_file")
    else
        # download
        print("Downloading $destination_file ... ")
        Downloads.download(url, destination_file)
        println("done.")
    end
    return
end
```
Note that the functions you use, should support the `.netrc` file, which is a way to store credentials.  For instance I use it to get stuff from NASA's servers (on `urs.earthdata.nasa.gov`).

Make a post processing function for unziping (could be other stuff too)
- Julia: install `ZipFile`
- Python: nothing (`zipfile` is part of the stdlib)
- R: probably just use the built-in functions

My Julia version is
```julia
using ZipFile
function unzip_one_file(zipfile, filename, destination_file)
    # make sure the directory exists
    mkpath(splitdir(destination_file)[1])

    r = ZipFile.Reader(zipfile)
    for f in r.files
        if f.name == filename
            write(destination_file, read(f, String))
        end
    end
    return nothing
end
```

## T14: Get the data and set model parameters (could be worked on concurrently with T15)

The real model runs, I like to keep in a folder called `code/scripts/`; there create a file which will contain the data-downloading codes, say `breithorn-get-data.*`.  This should
- setup the folders for the data and results
- download and pre-process the data files
- specify extra data (elevation of weather station 2650m, mean precipitation rate 0.005m/d)

A template would be
```

```julia
# This script prepares data for Breithorngletscher near Zermatt, Switzerland

## Setup project folder
... make paths

## Download data
# weather

# glacier mask

# digital elevation model (DEM)


## Some extra data, manually entered
z_weather_station = 2650 # elevation of weather station [m]
Ps0 = 0.005 # mean (and constant) precipitation rate [m/d]
```

Set model parameters in a separate file `breithorn-model-paras.*` (for larger projects, it's nice to have those separate from both the data and the model run script).  Contents:
```julia
## Set model parameters
lapse_rate = -0.6/100
melt_factor = 0.005
T_threshold = 4
```

Test both of the scripts.

## T15: Run the model for Breithorngletscher and generate outputs

Now it's time to run our fabulous mass balance model for Breithorngletscher!  Do this in a script.

To load the DEMs and mask you will need a asii-grid file reader:
- `rasterio` for Python
- `raster` for R

A template based on Julia for you to adapt:
```julia
## Read data
t, Ts = read_campbell(weather_fl)
dem = ??? here use an ascii-grid reader
mask = ???
Ps = Ps0 .+ Ts*0; # make precipitation a vector of same length as Ts

## Visualize input data
plot(t, Ts ...)
savefig(make_sha_filename(joinpath(results_dir, "breithorn_T"), ".png"))
heatmap(mask) # or some other 2D plot
savefig(make_sha_filename(joinpath(results_dir, "breithorn_mask"), ".png"))
heatmap(dem)
savefig(make_sha_filename(joinpath(results_dir, "breithorn_dem"), ".png"))

## Run the model for the whole Breithorn glacier
zs = dem[mask.==1] .- z_weather_station # selcet glacier points and use elevation of weather station as datum
dt = t[2] - t[1]
total_massbalance, point_massbalance = glacier_balance(zs, dt, Ts, Ps, melt_factor, T_threshold, lapse_rate)
# make a map again
point_massbalance_map = dem.*NaN
point_massbalance_map[mask.==1] .= point_massbalance
heatmap(point_massbalance_map)
savefig(make_sha_filename(joinpath(results_dir, "breithorn_massbalance_field"), ".png"))

## Generate output table
# make a table for massbalance of different temperature offsets and store it
out = []
for dT = -4:4
    Ts_ = Ts .+ dT
    massbalance_, _ = glacier_balance(zs, dt, Ts_, Ps, melt_factor, T_threshold, lapse_rate)
    push!(out, [dT, massbalance_])
end
writedlm(make_sha_filename(joinpath(results_dir, "deltaT_impact"), ".csv"), out, ',')
```

## T16: Share the code with another team and hope they can reproduce your results

- create a `main` script which runs the whole pipeline (download->parameters->model run)
- Make sure the README describes how the code is installed and run.

Find another team using the same programming language and let them try to reproduce your results.
