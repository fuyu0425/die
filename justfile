# Proxy to Makefile — allows running from any subdirectory
# Usage: just <target> [args...]

set fallback

# Generate a pdf (default)
default:
    make

# Generate a pdf
all:
    make all

# Generate diff-highlighted pdf
rev:
    make rev

# Proposal function
submit:
    make submit

# Generate diff-highlighted pdf
diff DIFF="HEAD^":
    make diff DIFF={{DIFF}}

# Generate checkout pdf
checkout COMMIT NAME="":
    make checkout COMMIT={{COMMIT}} NAME={{NAME}}

# Generate pdf with a draft info
draft:
    make draft

# Generate pdf with a watermark
watermark:
    make watermark

# Run a spell check
spell:
    make spell

# Print bib used in the paper
bib:
    make bib

# Clean up
clean:
    make clean

# Clean up completely
distclean:
    make distclean

# Check weasel words, passive voice, duplicates
proof:
    make proof

# Print help
help:
    make help
