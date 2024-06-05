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

### Continuous integration


### Other kind of tests
- _Docstring tests_: unit tests embedded in docstrings
- _Integration tests_: test whether multiple functions work correctly together
- _Regression tests_: tests whether your code is producing the same outputs that it used to in previous versions

The point is not to overwhelm you with the possibilities, but to give you a glossary of testing so you know what to look for when you’re ready to dig deeper.


- https://goodresearch.dev/testing.html
- Main package for testing is `pytest`
- [https://carpentries-incubator.github.io/python-testing/](https://carpentries-incubator.github.io/python-testing/)   


### Take-home messages
- Some people start writing tests before writing the actual function (it's called [Test-Driven Development](https://en.wikipedia.org/wiki/Test-driven_development))
  - This helps you focus imagining what you actually want your function to output