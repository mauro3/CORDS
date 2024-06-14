# Workshops on reproducible research, data pipelines and scientific computing

This repository holds the teaching material for two workshops we held at [WSL](https://www.wsl.ch/en/projects/cords/) in June 2024 (maybe there will be future editions too).  They were conducted in the framework of the [CORDS](https://www.wsl.ch/en/projects/cords/) project.

![image](https://github.com/mauro3/CORDS/assets/4098145/cec1e0be-5581-4b47-bd1e-e9a7fbbe64b6) ![image](https://github.com/mauro3/CORDS/assets/4098145/afb17ae9-d1f2-4388-80a7-9d3a1c171fa8)


The two workshops were:

- [Reproducible Research](https://github.com/mauro3/CORDS/tree/master/Workshop-Reproducible-Research) (2 days, by Mauro Werder @mauro3 & Victor Boussange @vboussange)
- [Geodata Processing in Python](https://github.com/mauro3/CORDS/tree/master/Workshop-Geodata-Processing) (1/2 day, by Mylène Jacquemart @mjacqu)

We also planned to run a workshop on GPU computing but in the end we didn't.  However, if interested we refer you to other workshops and resources of ours (by Ludovic Räss @luraess & Ivan Utkin @utkinis), on that topic[^gpu-resources].

The resources here are intended to be sufficient to self-study the material.  Indeed, we intend to let our future PhD students work through them when they start. The material consists of:
- lecture slides
- lecture recordings
- hands-on tasks such as coding projects and Jupyter notebooks
- example solutions to hands-on tasks

## How to self study

There are (at least) two ways to self study this material:
1. detailed study: watching the lectures and reading the material and working through the hands-on exercises
2. cursory study: looking through the lecture slides and the solutions to the hands-on exercises

The Reproducible Research material will take about 1.5 to 3 days using approach (1) or about 1/2 day using (2).

The Geodata Processing material will take about 1/2 to 1 day using approach (1) or about 3 hours using (2)

## Reproducible Research

This workshop/material is intended for students and scientists handling data and/or running simulations aiming to make their programming and data workflow reproducible.

Contents:
- Coding project management and version control using Git
- Software dependency management through virtual environments/package managers/git
- Input/output data handling
  - Automated data download and storage
- Fully automated production of all project outputs
- course material in Python, Julia and (partially) R; but the course can be followed in any programming language

[Get started](https://github.com/mauro3/CORDS/tree/master/Workshop-Reproducible-Research)

Note that the taught approach deliberately favors a straightforward, minimalistic and low-tech strategy for achieving reproducible research.
It is based on only essential tools: the programming language, a dependency management tool, and version control with Git.
We feel that once the concepts are mastered and if the researcher's work warrants it (very large or very many data dependencies, very many processing steps), then more advanced and integrated tools are easily learned.

## Geodata Processing in Python

This workshop/material is intended for scientists and students wanting to move their interactive GIS work to fully scripted workflows.

Contents:
- introduction to useful Python packages for handling geospatial data
- performing typical GIS-tasks in a reproducible, script based form in Python (e.g. modifying and working with vector and raster data, geostatistical taks, map-making etc.)
- course materials in Python

[Get started](https://github.com/mauro3/CORDS/tree/master/Workshop-Geodata-Processing)

[^gpu-resources]: Some resources of ours on GPU computing:  our master level course on solving PDEs on GPUs at ETH ["Solving PDEs on GPUs"](https://pde-on-gpu.vaw.ethz.ch/); talk and workshop about GPU, Autodiff and inversions ([talk](https://live.juliacon.org/talk/YKUD8Q), [workshop](https://live.juliacon.org/talk/GTKJZL)).
