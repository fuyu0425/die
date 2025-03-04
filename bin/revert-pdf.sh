#!/bin/bash
# revert pdf after building
# skipping and exit gracefully if emacs is not installed


# Check if emacsclient is installed
if ! command -v emacsclient &> /dev/null; then
    # echo "Error: emacsclient is not installed. Please install Emacs."
    exit 0
fi

# Check if a file path is provided as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 path/to/your/file.pdf"
    exit 0
fi

# Resolve the absolute path of the PDF file
PDF_PATH=$(realpath "$1")

# Check if the file exists
if [ ! -f "$PDF_PATH" ]; then
    echo "Error: File '$PDF_PATH' not found."
    exit 0
fi

# Check if Emacs server is running
if ! emacsclient -q -a false --eval "nil" &>/dev/null; then
    # echo "Error: Emacs server is not running. Please start Emacs with --daemon or ensure the server is running."
    exit 0
fi

# Command to revert the PDF buffer in Emacs with error handling
emacsclient --eval "(ignore-errors (with-current-buffer (get-file-buffer \"$PDF_PATH\") (revert-buffer t t t)))" 2>&1 >/dev/null
