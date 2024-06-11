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
|    |-- own
|    |-- foreign
|-- results
|-- publications
|    |-- talks
|    |-- posters
|    |-- papers
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
- stuff which also belongs to a project, say `admin/` is not mixed with code specifics, such as `environment.yml`
- it feels to me that raw data may should be elsewhere than in a code-folder
- submission to a data-repository of a folder containing `data`, `results` and `code` seems to have a nice setup
- typically I want to have a different git repo for the paper than for the code (but there opinions may also differ)

Disadvantages
- code will write results into its parent directory, which is not so nice
- stuff such as admin, etc., will still need to be weeded out before submission

---

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

One good option could be to put all processing and data stuff into `analysis`
```
MyScientificProject/
 -- README.md
|-- admin/
|-- personnel/
|-- publications/
|-- analysis/
|   |-- README.md
|   |-- src/
|   |-- data/
|   |   |-- raw/
|   |   |-- processed/
|   |-- results/
|   |-- docs/
|   |-- scripts/
|   |-- tests/
|   |-- environment.yml
|   |-- requirements.txt
```
The data-submission would then be the `analysis` folder.

---

### Wrapping up

- there is not one way to structure your research project folders
- a chosen structure should be suitable to both work with and to submit (parts) to a data repository

What is your preference?
