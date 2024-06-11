# L11
## Publish your open science

Once you've written the publication, or maybe before, it is time to publish your results including how to reproduce them.

- re-clone your code-repository, ideally onto a new computer
- run the master script, this will populate
  - data
  - results
- go through data
  - probably delete the foreign-data
  - probably delete intermediate results (cached stuff)
  - in the own-data, check that this data can all be published
- check that you got the ok from all copyright holders that the publication under this license is okey
- the own-data downloads are not necessary anymore, remove them/comment them out
- double check that the project-README is in a state which makes sense for a data-repository
- double check that you include a LICENSE
- zip it
- re-check: unzip, move `results/` folder to `results-old` and run the scripts.  This should produce a new `results/` which is identical to the old one.
- send the zip-file off the repository

---

## Where?

- WSL has the [EnviDat](https://www.envidat.ch/) data repository
- ETH has the [Research Collection](https://www.research-collection.ethz.ch/)
- there are many large repositories:
  - [Dryad](https://datadryad.org)
  - [Figshare](https://figshare.com/)
  - [Zenodo](https://zenodo.org/)
