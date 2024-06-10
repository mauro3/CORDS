## Testing for reproducible research

### Why testing

During the development process, it
- Allows to detect potential bugs early.
- Ensures code reliability over time.

From a scientific perspective, it
- Helps to build up confidence on you results
- Confirms the stability of your experiments.

---

## Best Practices for Testing

### Test-Driven Development (TDD)

- **Definition:** Writing tests before the actual code.
- **Benefits:** 
  - Ensures well-tested implementation.
  - Avoids unnecessary features.
  - Efficient coding process.

---

## Unit Testing

### Key Aspects

- **Correctness:** Test with typical inputs.
- **Edge Cases:** Check boundary conditions.
- **Error Handling:** Test for invalid inputs.

### Example (Python)

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

---

## Advanced Unit Testing

### Using Test Suites

- **Frameworks:** `pytest`, `unittest`
- **Benefits:** 
  - Groups tests for comprehensive coverage.
  - Detailed test results and error reporting.

### Example (pytest)

```python
import pytest
from src.fib import fib

def test_typical():
    assert fib(1) == 1
    assert fib(2) == 1
    assert fib(6) == 8

def test_edge_case():
    assert fib(0) == 0

def test_raises():
    with pytest.raises(NotImplementedError):
        fib(-1)
```

---

## Testing Non-Pure Functions

### Approach

- **Randomness:** Provide seeds to ensure reproducibility.
- **Stateful Functions:** Test postconditions for expected state changes.
- **I/O Functions:** Use mock files for input/output verification.

### Example (Python)

```python
def file_to_upper(in_file, out_file):
    with open(in_file, 'r') as fin, open(out_file, 'w') as fout:
        for line in fin:
            fout.write(line.upper())

import tempfile

def test_file_to_upper():
    with tempfile.NamedTemporaryFile(delete=False, mode='w') as in_file:
        in_file.write("test123\nthetest")
    with tempfile.NamedTemporaryFile(delete=False) as out_file:
        file_to_upper(in_file.name, out_file.name)
        with open(out_file.name, 'r') as f:
            assert f.read() == "TEST123\nTHETEST"
```

---

## Continuous Integration (CI)

### Importance

- **Automated Testing:** Runs tests on each commit, for possibly many environments
- **Multi-Developer Projects:** Ensures consistency across environments.
- **Tools:** GitHub Actions, Jenkins, etc.

### Example (GitHub Actions for Python)

```yaml
name: CI

on: push

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v2
    - uses: actions/setup-python@v2
      with:
        python-version: "3.11"
    - run: |
        pip install -r requirements.txt
        pytest --cov=catchment.models tests/
```

---

## Other Types of Tests

- **Docstring Tests:** Tests embedded in function docstrings.
- **Integration Tests:** Ensure multiple functions work together.
- **Regression Tests:** Verify new code does not break existing functionality.

---

## Take-Home Messages

- Systematically implementing testing allows you to effortlessly check for the sanity of your code
- The overhead cost is usually well balanced by the reduced time spent downstream in identifying bugs
- Good code loudly indicates when something goes wrong.