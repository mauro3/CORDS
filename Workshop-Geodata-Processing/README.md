# Programmatic Geodata Processing Workshop

## Original workshop schedule


| Time | Program | 
| ---- | ---- | 
| 8:15 - 08:30 | Arrival  & setup   | 
| 8:30 - 9:15 | Intro & course overview, background |
| 9:15 - 10:15 | Working with vector data |
| 10:15 - 10:30 | Coffe break |
| 10:30 - 11:00 | Working with vector data cont. |
| 11:00 - 12:15 | Working with raster data |
| 12:15 | Lunch at mensa (if desired) |
 
## Materials

To prepare for this workshop, perform the following setup:

- Download (or clone or pull) this repository
- Set up a conda environment using the attached environment.yaml file. You can do this using the command `conda env create -f environment.yml`
​
Note: Conda can be excruciatingly slow to solve these environments. If you run into issues (likely), we recommend installing [mamba](https://anaconda.org/conda-forge/mamba) and running `mamba env create -f environment.yml` instead.

Once your install is complete, run `conda activate cords-geoprocessing` to activate the environment you just created and test running `jupyter notebook`. If this works you should be all set to go for Thursday's workshop. If you run into issues, send us an email. Remember that we won't be available to trouble-shoot after 5pm tomorrow, and we won't really have time on Thursday morning, so try to set this up as early as possible. 

- In the Workshop-Geodata-Processing directory, create a directory called `data`. 
- Start by running the Download-data notebook. Before running the Working-with-vector-data or Working-with-raster-data notebooks, make sure you have the following directories with the corresponding files downloaded and unzipped: sgi_2016 (Swiss glacier inventory), glathida-3.1.0 (ice thickness measurements), RGI60-11 (ice thickness model), DEMs (digital elevation models for Silvretta glacier from 2014 and 2020), planet (multispectral image of Silvretta glacier).
- Note that the rater data notebook draws on data that is created during the vector data notebook, so you need to run that first.