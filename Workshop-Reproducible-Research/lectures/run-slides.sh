#!/bin/bash

# Create a temporary file
TMPFILE=$(mktemp combined.XXXXXX.md)

echo $1

# Concatenate front matter and markdown content into the temporary file
cat front-matter.md $1 > $TMPFILE

# Run reveal-md with the temporary file
reveal-md "$TMPFILE" --css custom.css -w

# Cleanup the temporary file after execution
rm $TMPFILE
