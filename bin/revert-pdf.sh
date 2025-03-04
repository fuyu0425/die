#!/bin/bash

# Check if a file path is provided as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 path/to/your/file.pdf"
    exit 1
fi

# Resolve the absolute path of the PDF file
PDF_PATH=$(realpath "$1")

# Check if the file exists
if [ ! -f "$PDF_PATH" ]; then
    # echo "Error: File '$PDF_PATH' not found."
    exit 1
fi

# Check if Emacs server is running
if ! emacsclient -q -a false --eval "nil" &>/dev/null; then
    # echo "Error: Emacs server is not running. Please start Emacs with --daemon or ensure the server is running."
    exit 1
fi

# Command to revert the PDF buffer in Emacs with error handling
emacsclient --eval "(ignore-errors (with-current-buffer (get-file-buffer \"$PDF_PATH\") (revert-buffer t t t)))" 2>&1 >/dev/null
