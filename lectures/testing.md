## Testing your code
- you run an experiment and the results of the analysis don’t make sense. what will you check?

[...]


- Testing can help you maintain your sanity by decreasing the surface of things that might be wrong with your experiment
- Good code yells loudly when something goes wrong.


### Unit testing
- Unit testing is the practice of testing a unit of code, typically a single function. The easiest way to understand what that means is to illustrate it with a specific example.
- What to test
  - correctness for typical inputs
  - edge cases
  - errors with bad inputs
  - Functional goals are achieved, e.g. that the function works for large numbers
- A good idea is to write an additional test when you find a bug in your code


#### Lightweight formal tests with assert
- You can use `@assert` within the script coding for your functions

```python
assert 1 == 0
```

```julia
@assert 1==0
```

- How to use assert

```python
def fib(x):
    if x <= 2:
        return 1
    else:
        return fib(x - 1) + fib(x - 2)

assert fib(0) == 0
assert fib(1) == 1
assert fib(2) == 1
```

- In Julia or Python, you could directly place the `assert` statement after your functions
- In python, you could do it cleaner with
```python
def fib(x):
    if x <= 2:
        return 1
    else:
        return fib(x - 1) + fib(x - 2)

if __name__ == '__main__':
    assert fib(0) == 0
    assert fib(1) == 1
    assert fib(2) == 1
    assert fib(6) == 8
    assert fib(40) == 102334155
    print("Tests passed")
```

- consider using `assert_allclose`, or `approx` for floating points

#### Testing with a test suite
- once you have a lot of tests, it starts to make sense to group them into a test suite and run them with a test runner. 
- Writing a test suite is a matter of taking our previous unit tests and putting them in a separate file, wrapping them in unit test functions, and wrap those unit test functions in a file which runs all tests


##### Python
- There are two main frameworks to run unit tests in Python, `pytest` and `unittest`. `pytest` is the more popular of the two

```python
from src.fib import fib
import pytest

def test_typical():
    assert fib(1) == 1
    assert fib(2) == 1
    assert fib(6) == 8
    assert fib(40) == 102334155

def test_edge_case():
    assert fib(0) == 0

def test_raises():
    with pytest.raises(NotImplementedError):
        fib(-1)

    with pytest.raises(NotImplementedError):
        fib(1.5)
```

```shell
pytest test_fib.py
```

#### Testing non-pure functions and classes
- For a nondeterministic function, you can usually give the random seed or random variables needed by the function as arguments, turning the nondeterministic function into a deterministic one. 
- For a stateful function, we need to additionally test that postconditions are met, that is, the internal state of the function or object is changed in the expected way by the code
- For a function with I/O side effects, need to create mock files to check whether inputs are read properly and outputs are as expected.

```python
def file_to_upper(in_file, out_file):
    fout = open(out_file, 'w')
    with open(in_file, 'r') as f:
        for line in f:
            fout.write(line.upper())
    fout.close()

import tempfile
import os

def test_upper():
    in_file = tempfile.NamedTemporaryFile(delete=False, mode='w')
    out_file = tempfile.NamedTemporaryFile(delete=False)
    out_file.close()
    in_file.write("test123\nthetest")
    in_file.close()
    file_to_upper(in_file.name, out_file.name)
    with open(out_file.name, 'r') as f:
        data = f.read()
        assert data == "TEST123\nTHETEST"
    os.unlink(in_file.name)
    os.unlink(out_file.name)

```
- You want to keep the runtime of those tests very short
  - create mock-up data if it takes too long to test real data / simulations
### Continuous integration
The automated testing we’ve done so far only takes into account the state of the repository we have on our own machines. In a software project involving multiple developers working and pushing changes on a repository, it would be great to know holistically how all these changes are affecting our codebase without everyone having to pull down all the changes and test them. If we also take into account the testing required on different target user platforms for our software and the changes being made to many repository branches, the effort required to conduct testing at this scale can quickly become intractable for a research project to sustain.

Continuous Integration (CI) aims to reduce this burden by further automation, and automation - wherever possible - helps us to reduce errors and makes predictable processes more efficient. The idea is that when a new change is committed to a repository, CI clones the repository, builds it if necessary, and runs any tests. Once complete, it presents a report to let you see what happened.

There are many CI infrastructures and services, free and paid for, and subject to change as they evolve their features. We’ll be looking at GitHub Actions - which unsurprisingly is available as part of GitHub.



- With GitHub Actions we can automatically run test on each proposed change.
- We can also build documentation, check for code coverage, etc...

Workflow:
- Start a runner
- Clone our repository
- Install Julia/Python/R
- Deploy our environment dependencies (including testing dependencies)
- Run tests, or deploy documentation...

To make our workflow we need to create a new file called `.github/workflows/ci.yaml`. All YAML files in the `.github/workflows` directory will be picked up by GitHub Actions and executed.

##### julia test

```yaml
name: Run tests

on:
  push:
    branches:
      - master
      - main
  pull_request:

# needed to allow julia-actions/cache to delete old caches that it has created
permissions:
  actions: write
  contents: read

jobs:
  test:
    runs-on: ${{ matrix.os }}
    strategy:
      matrix:
        julia-version: ['1.6', '1', 'nightly']
        julia-arch: [x64, x86]
        os: [ubuntu-latest, windows-latest, macOS-latest]
        exclude:
          - os: macOS-latest
            julia-arch: x86

    steps:
      - uses: actions/checkout@v4
      - uses: julia-actions/setup-julia@v1
        with:
          version: ${{ matrix.julia-version }}
          arch: ${{ matrix.julia-arch }}
      - uses: julia-actions/cache@v1
      - uses: julia-actions/julia-buildpkg@v1
      - uses: julia-actions/julia-runtest@v1
        # with:
        #   annotate: true
```

- Notice that this uses build matrices
  - Suppose the intended users of our software use either Ubuntu, Mac OS, or Windows, and either have Python version 3.10 or 3.11 installed, and we want to support all of these. Assuming we have a suitable test suite, it would take a considerable amount of time to set up testing platforms to run our tests across all these platform combinations. Fortunately, CI can do the hard work for us very easily.
  - Using a build matrix we can specify testing environments and parameters (such as operating system, Python version, etc.) and new jobs will be created that run our tests for each permutation of these.


- [see all Julia deploy actions here](https://github.com/julia-actions)
- This file can be generated by templaters, such as `PkgTemplates.jl`

#### Python test
```yaml

name: CI

# We can specify which Github events will trigger a CI build
on: push

# now define a single job 'build' (but could define more)
jobs:

  build:

    # we can also specify the OS to run tests on
    runs-on: ubuntu-latest

    # a job is a seq of steps
    steps:

    # Next we need to checkout out repository, and set up Python
    # A 'name' is just an optional label shown in the log - helpful to clarify progress - and can be anything
    - name: Checkout repository
      uses: actions/checkout@v2

    - name: Set up Python 3.11
      uses: actions/setup-python@v2
      with:
        python-version: "3.11"

    - name: Install Python dependencies
      run: |
        python3 -m pip install --upgrade pip
        python3 -m pip install -r requirements.txt

    - name: Test with PyTest
      run: |
        python3 -m pytest --cov=catchment.models tests/test_models.py
```

- [see more details here](https://carpentries-incubator.github.io/python-intermediate-development-earth-sciences/23-continuous-integration-automated-testing/index.html)
- Note that this example uses `pip`. [See here](https://autobencoder.com/2020-08-24-conda-actions/) for how to use `miniconda`

### Other kind of tests
- _Docstring tests_: unit tests embedded in docstrings
- _Integration tests_: test whether multiple functions work correctly together. Rather than assuming that the test author knows what the expected result should be, regression tests look to the past for the expected behavior. The expected result is taken as what was previously computed for the same inputs.
- _Regression tests_: tests whether your code is producing the same outputs that it used to in previous versions. Integration tests are the class of tests that verify that multiple moving pieces and gears inside the clock work well together. Where unit tests investigate the gears, integration tests look at the position of the hands to determine if the clock can tell time correctly. They look at the system as a whole or at its subsystems. Integration tests typically function at a higher level conceptually than unit tests. Thus, writing integration tests also happens at a higher level.


The point is not to overwhelm you with the possibilities, but to give you a glossary of testing so you know what to look for when you’re ready to dig deeper.


### Resources
- [Official github doc on how to build and test Python project](https://docs.github.com/en/actions/automating-builds-and-tests/building-and-testing-python)
- [CI with github action and Docker for Python](https://blog.allenai.org/ci-with-github-actions-for-research-code-a8460c21c6ba)
- https://goodresearch.dev/testing.html
- Main package for testing is `pytest`
- [https://carpentries-incubator.github.io/python-testing/](https://carpentries-incubator.github.io/python-testing/)   


### Take-home messages
- Some people start writing tests before writing the actual function (it's called [Test-Driven Development](https://en.wikipedia.org/wiki/Test-driven_development))
  - This design philosophy was most strongly put forth by Kent Beck in his book Test-Driven Development: By Example.
   - The central claim to TDD is that at the end of the process you have an implementation that is well tested for your use case, and the process itself is more efficient. You stop when your tests pass and you do not need any more features. You do not spend any time implementing options and features on the off chance that they will prove helpful later. You get what you need when you need it, and no more. TDD is a very powerful idea, though it can be hard to follow religiously.
