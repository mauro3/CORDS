# Testing your code

Code testing is essential to identify and fix potential issues, to maintain sanity over the course of the development of the project and quickly identify bugs, and to ensure the reliability and sanity of your experiment overtime. Good code loudly indicates when something goes wrong.

Some developers start writing tests before writing the actual function, a practice known as [Test-Driven Development (TDD)](https://en.wikipedia.org/wiki/Test-driven_development). This philosophy, strongly advocated by Kent Beck in his book "Test-Driven Development: By Example," ensures that you have a well-tested implementation by the end of the process, and that your coding process is efficient. Define upstream on a piece of paper the behavior of the function, write corresponding tests, and when all tests pass, you are done. This avoids unnecessary features and focusing only on what is needed. 

## Unit testing

Unit testing involves testing a unit of code, typically a single function, to ensure its correctness. Here are some key aspects to consider:

- Test for correctness with typical inputs.
- Test edge cases.
- Test for errors with bad inputs.

A good idea is to write an additional test when you find a bug in your code

### Lightweight formal tests with `assert`

The simplest form of unit testing involves some sort of `assert` statement.

#### Python

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

#### Julia

```julia
@assert 1 == 0
```

When one test is broken, you'll get an error for the corresponding test, which you'll need to fix to check the following tests.

In Julia or Python, you could directly place the `assert` statement after your functions. This way, tests are run each time you execute the script. Here is nother pythonic approach, which can be used to decouple the test

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

Consider using `np.isclose`, `np.testing.assert_allclose` (Python) or `approx` (Julia) for floating point comparisons.

### Testing with a test suite

Once you have many tests, it makes sense to group them into a test suite and run them with a test runner. This approach will run all tests, even though some are broken, and retrieve and informative statements on those tests that passed, and those that did not. As you'll see, it also allows to automatically run the test at each commit, with continuous integration.

#### Python

Two main frameworks for unit tests in Python are `pytest` and `unittest`, with `pytest` being more popular.

Example using `pytest`:

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

Run the tests with:

```shell
pytest test_fib.py
```

#### Julia
 Built in module `Test`, relying on the macro `@test`. Consider grouping your tests with 
 
 ```julia
 julia> @testset "trigonometric identities" begin
           θ = 2/3*π
           @test sin(-θ) ≈ -sin(θ)
           @test cos(-θ) ≈ cos(θ)
           @test sin(2θ) ≈ 2*sin(θ)*cos(θ)
           @test cos(2θ) ≈ cos(θ)^2 - sin(θ)^2
       end;
```

This will nicely output
```
Test Summary:            | Pass  Total  Time
trigonometric identities |    4      4  0.2s
```
which comes handy for grouping tests applied to a single function or concept.

An additional virtual environment may be specified for tests!

#### R
[`testhat`](https://testthat.r-lib.org)

### Testing non-pure functions and classes

For nondeterministic functions, provide the random seed or variables needed by the function as arguments to make them deterministic. 
For stateful functions, test postconditions to ensure the internal state changes as expected. 
For functions with I/O side effects, create mock files to verify proper input reading and expected output.

#### Python

```python
def file_to_upper(in_file, out_file):
    fout = open(out_file, 'w')
    with open(in_file, 'r') as f:
        for line in f:
            fout.write(line.upper())
    fout.close()

import tempfile
import os

def test_file_to_upper():
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

### Continuous integration

Automated testing on local machines is useful, but for projects involving multiple developers and various target platforms, continuous integration (CI) is essential. CI clones the repository, builds it if necessary, and runs tests whenever changes are committed. GitHub Actions is a popular CI tool available within GitHub.

With GitHub Actions, you can automatically run tests on each proposed change. Additionally, Actions can also build documentation, check for code coverage, and more.

Continuous Integration is based on `.yaml` files, which specify the environment to run the script. You can use build matrices to test across different environments (e.g. Linux, Windows and MacOS, with different versino of python or Julia). Jobs will be created that run our tests for each permutation of these.

#### `.yaml` for Julia:

```yaml
name: Run tests

on:
  push:
    branches:
      - master
      - main
  pull_request:

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
```

#### `.yaml` workflow for Python:

```yaml
name: CI

on: push

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
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

### Other types of tests

- **Docstring tests**: Unit tests embedded in docstrings.
- **Integration tests**: Test whether multiple functions work correctly together. 
- **Regression tests**: Ensure your code produces the same outputs as previous versions.


### Resources

- [Official GitHub documentation on building and testing Python projects](https://docs.github.com/en/actions/automating-builds-and-tests/building-and-testing-python)
- [CI with GitHub Action and Docker for Python](https://blog.allenai.org/ci-with-github-actions-for-research-code-a8460c21c6ba)
- [Julia documentation on unit testing](https://docs.julialang.org/en/v1/stdlib/Test/)
- [Good Research Practices: Testing](https://goodresearch.dev/testing.html)
- [The Carpentries: Python Testing](https://carpentries-incubator.github.io/python-testing/)

### Take-home messages
- Systematically implementing testing allows you to effortlessly check for the sanity of your code
- The overhead cost is usually well balanced by the reduced time spent downstream in identifying bugs
- Good code loudly indicates when something goes wrong.
- While TDD is a powerful idea, it can be challenging to follow strictly.