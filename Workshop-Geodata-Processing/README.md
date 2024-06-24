# Programmatic Geodata Processing Workshop

## How to
The Geodata Processing workshop consists of two main notebooks: Working-with-vector-data and Working-with-raster data. Additionally, a Download-data notebook allows you to download the necessary data, and the notebook on Working-with-multispectral data contains example code for plotting multi-band images.
The main exercise notebooks do not contain complete code, some of it has been omitted, though hints are usually provided. Use the hints and the package documentation online to fill in the pieces and familiarize yourself with the code. If you get stuck the corresponding -solutions notebooks contain the complete code. Note that the rater data notebook draws on data that is created during the vector data notebook, so you need to run that first.

A [video recording](https://people.ee.ethz.ch/~werderm/rere-data/video2.html) of taught part of the workshop

## Installation

To prepare for this workshop, perform the following setup:

- Download (or clone or pull) this repository
- Set up a conda environment using the attached environment.yaml file. You can do this using the command `conda env create -f environment.yml`

Note: Conda can be excruciatingly slow to solve these environments. If you run into issues (likely), we recommend installing [mamba](https://anaconda.org/conda-forge/mamba) and running `mamba env create -f environment.yml` instead.

- Once your install is complete, run `conda activate cords-geoprocessing` to activate the environment you just created and test running `jupyter notebook`. If this works you should be all set for running the notebooks.

To finalize the setup:
- In the Workshop-Geodata-Processing directory, create a directory called `data`.
- Start by running the Download-data notebook. Before running the Working-with-vector-data or Working-with-raster-data notebooks, make sure you have the following directories with the corresponding files downloaded and unzipped: sgi_2016 (Swiss glacier inventory), glathida-3.1.0 (ice thickness measurements), RGI60-11 (ice thickness model), DEMs (digital elevation models for Silvretta glacier from 2014 and 2020), planet (multispectral image of Silvretta glacier).



## Original workshop schedule

| Time          | Program                             |
|---------------|-------------------------------------|
| 8:15 - 08:30  | Arrival  & setup                    |
| 8:30 - 9:15   | Intro & course overview, background |
| 9:15 - 10:15  | Working with vector data            |
| 10:15 - 10:30 | Coffe break                         |
| 10:30 - 11:00 | Working with vector data cont.      |
| 11:00 - 12:15 | Working with raster data            |
| 12:15         | Lunch at mensa (if desired)         |
