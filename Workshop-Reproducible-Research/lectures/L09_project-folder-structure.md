# L09
### How to organise a research project

There is certainly many aspects of how to organise a research project, here we'll look into possible ways of laying out the folders.

This folder structure is certainly less set in stone than the code-folder structure we looked at in [L04](L04_code_folders.md), where the language communities usually have pretty strong guidelines.

---

### My biased view

I quite like this project folder structure

```
|-- code/
|-- data/
     |-- own
	 |-- foreign
|-- results
|-- publications
     |-- talks
	 |-- posters
	 |-- papers
|-- admin
|-- meetings
|-- more-folders
 -- README.md
```

---

where `code/` then contains the code folder as discussed in L04, e.g. for Python
```
|-- src/            # package code
|-- scripts/        # Custom analysis or processing scripts
|-- tests/
|-- examples/       # Example scripts using the package
|-- docs/           # documentation
 -- environment.yml # to handle project dependencies
 -- README.md
```

---
Advantages:
- stuff which also belongs to a project is not buried with code specifics, such as `environment.yml`
- it feels to me that raw data may should be elsewhere than in a code-folder
- submission to a data-repository of a folder containing `data`, `results` and `code` seems nice
- typically I want to have a different git repo for the paper than for the code (but there opinions may also differ)

Disadvantages
- code will write results into it parent directory, which is not so nice
- stuff such as admin, etc., will still need to be weeded out before submission

### Other folder structures

The [Good Research Code Handbook](https://goodresearch.dev/setup#create-a-project-skeleton) suggests
```
|-- data
|-- docs
|-- results
|-- scripts
|-- src
|-- tests
 -- .gitignore
 -- environment.yml
 -- README.md
```

---

One good one could be to put all processing and data stuff into `analysis`
```
MyScientificProject/
|-- README.md             # Project overview and instructions
|-- admin/                # Administrative documents (e.g., project proposals, budgets)
|-- personnel/            # Information regarding team members, CVs, roles
|-- publications/         # Publications, drafts, and submission information
|-- analysis/             # Analytical components (code, data, notebooks, results, scripts, tests)
|   |-- README.md         # Analysis overview and instructions
|   |-- src/              # Source code (scripts, functions)
|   |-- data/
|   |   |-- raw/          # Raw data (never modify)
|   |   |-- processed/    # Processed/cleaned data
|   |-- docs/             # Project documentation (reports, manuscripts, etc.)
|   |-- notebooks/        # Jupyter/R Markdown notebooks
|   |-- results/          # Results of analyses (figures, tables, outputs)
|   |-- scripts/          # Analysis scripts
|   |-- tests/            # Unit tests or validation scripts
|   |-- environment.yml   # Environment configuration file (e.g., for Conda)
|   |-- requirements.txt  # Python (pip) dependencies
```
The data-submission would then be the `analysis` folder.
