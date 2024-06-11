# L10
## Reproducible data handling

How can input data be handled such that it provenance and (pre)processing is clear:

**script it all**

<div class="fragment" data-fragment-index="1">

The alternative would be to download and process by-hand.  To make that reproducible it would need to be tediously documented.

</div>

---

## Own data

There, there is usually no way around carefully document how it was collected (where, sensor, logger, document with photos).

This data should then be stored somewhere safe with good backups.  Typically a server somewhere at WSL.

- download it from the server to your laptop for processing, place it into the `data/own` folder
- once you publish the data, the download function is not needed anymore as it will come stored in the `data/own` folder of that dataset.

---

## Foreign data

Your research project will likely depend on other data than just your own.  I call this "foreign data" (albeit, I'm not quite happy with that term).

Ideally, this data can be obtained from the internet somehow.

---

## Foreign data
- ideal case: there is a simple url which just points to the data (ideally of the DOI-variation).  Easy, just download it in your data-fetching script; this records the provenance and get the data.
- unfortunately, much data is behind a pay-wall or at least a login-wall.  Also sometimes behind a click-many-times wall or a tricky API.  Try to script it, otherwise document it.
- sometimes data is just super tricky because it is so humongous (climate model output data comes to mind).  ChatGPT might be able to help if it is a common data.
- sometimes data is not publicly available.  For instance, we often use discharge data from hydro-power companies.  This data is not public and probably received by email or dropbox.
  --> I would treat this, as far as the own analysis goes like own measurement data, i.e. store somewhere safe and download it from there.  Then ask whether it can be published.  If not, maybe some intermediate, derived data maybe publishable.

---

## Lotta What-Have-Yous (funny data)

- expert opinion (say for priors in a Bayesian inversion, model parameter choice)
- standard model parameters as, say, recommended in some published paper
--> these I'd store in a script or simple to parse text file.  Just make sure it's clearly seen as data and not hidden somewhere in between your model run code.

- hand produced data, say digitising from a map: treat this as "own measurements".  Again document well how you produced it in a readme/info file.

- sensible data, say personal data: there one has to be super careful; maybe not even a good idea to have it on your laptop

---

### Data pre-processing

- script it! You guessed.
- if this is expensive, some intermediate results should be cached (and if not present, re-generated).
- try to keep data mangling and model runs *very* separate.  Only pass data to the model in a well defined way (i.e. let the model have a clear API) and don't do anymore data tweaking anywhere in the model scripts and code


---

### Data tweaking

Of course data should not be tweaked with, ideally.  But sometimes it needs to be done (remove outliers, fill gamps, etc)

- again, ideally, script this tweaking.  Document the why (can be a code comment).
- if not possible or too cumbersome, document it
  - recording the diff of the file before and after might be a good solution, a so called "patch"
  - alternatively store the file in its before and after state
  - document it (how, why)


---

### Model runs

To make it reproducible

1. one run per commit (after a change of parameters re-commit)
2. all runs scripted

I find that during the exploratory phase (1) is more realistic.  But probably good to write the "keepers" into a file to slowly get towards (2).

For the production run (2) is needed.  As in the end you want to have one master script to produce everything and not some convoluted instructions like: "checkout commit 87d465ad and run script xyz.jl, then checkout..."

Note: model runs may be expensive, so a caching strategy maybe good too.

---

### Post processing

Yep, script it...

Again, I recommend during the exploratory phase to use again a "one post-proc per commit" approach but to eventually move to "all post-proc scripted"

---

### Keep reproducing it

It is good to keep reproducing your outputs.  Run the whole pipeline now and then.  Ideally on different computers.
