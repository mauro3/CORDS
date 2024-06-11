---
theme : "moon"
maxScale: "10"
minScale: "0.2"
width: 1920
height: 1080
---

## Best Practices for Documenting Research Code
Documentation serves multiple purposes and benefits various audiences:
- Your future self
- Collaborators
- Users
- Contributors

The best documentation starts with writing self-explanatory code with good conventions.

---

## Style Guides
Using style guides ensures consistency and readability. Here are some resources:
- [Julia Style Guide](https://docs.julialang.org/en/v1/manual/style-guide/)
- [Google Python Style Guide](https://google.github.io/styleguide/pyguide.html)

Example:
```python
# Instead of:
for l in L:
    pass

# Use:
for line in lines:
    pass
```

---

## Comments
Write self-explanatory code and use comments to provide context. Use single-line comments for brief explanations and multi-line comments for detailed information.

Example (Python):
```python
"""
This is a multi-line
comment
"""
```

---

## Literal Documentation
Literal documentation helps users understand your tool and get started with it.

---

### README
A README file is essential and should contain:
- A one-sentence description
- A longer description
- Repository structure overview
- Getting started or examples
- Installation instructions
- Citation/reference section
- Acknowledgement and license sections


Github and Gitlab render the README nicely on the landing page of the project.  Use markdown or similar for formatting.
<!-- .element: class="fragment" data-fragment-index="1" -->

---

## API Documentation
API documentation describes the usage of functions, classes, and modules. Use docstrings to document your code.

Example (Python):
```python
def add(a, b):
    """
    Adds two integers.

    Parameters:
    a: The first integer.
    b: The second integer.

    Returns:
    int: The sum of the two integers.

    Examples:
    >>> add(2, 3)
    5
    >>> add(-1, 1)
    0
    """
    return a + b
```

---

## Type annotations
Typing specifies variable and function return types, ensuring type safety and reducing runtime errors.

Example (Python):
```python
def add(a: int, b: int) -> int:
    return a + b
```


---

## Error Handling
Use assertions and error messages to handle unexpected inputs and guide users.

Example (Python):
```python
def convolve_vectors(vec1, vec2):
    if not isinstance(vec1, list) or not isinstance(vec2, list):
        raise ValueError("Both inputs must be lists.")
    # convolve the vectors
```

---

## Tutorials
Create tutorial Jupyter notebooks or R vignettes to demonstrate the usage of your code. Place them in a folder named `examples` or `tutorials`.

---

## Accessing Documentation
Documentation can be accessed directly in the code environment.

Example (Julia):
```julia
?cos
```

Example (Python):
```python
help(myfun)
```

---

## Doc Testing
Doc testing ensures that code examples in your documentation are accurate and up-to-date.

Example (Python):
```python
def add(a, b):
    """
    Add two numbers.

    >>> add(2, 3)
    5
    >>> add(-1, 1)
    0
    """
    return a + b
```

Run the doc-tests with `python -m doctest -v your_script.py`
<!-- .element: class="fragment" data-fragment-index="1" -->

---

## Take Home Messages
- Good documentation maintains the long-term memory of a project.
- Refactor code to reduce complexity.
- Unit tests are often more productive than extensive documentation.
- Types of documentation: literal, API, and tutorial/example documentation.
- Use tools like ChatGPT to assist with documenting your functions.
