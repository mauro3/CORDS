# L06
## Making model runs reproducible

Apart from the input data needed to run a model, there are other things which need to be kept track of to make model runs reproducible.  For instance our `simple.*` example may well produce different results as we continue to develop the code (new features, bug fixes, etc.).

What can change?  What needs to be kept track of?

1. the computer's software stack
2. dependencies
3. the code itself
4. model parameters

Point 1 is important too but this we will not cover (virtual machines and docker come to mind, see caveats [L05](L05_dependencies.md)).

## How can we store this

The easiest solution
