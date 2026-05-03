# Plots Directory

This directory contains Python scripts that generate PDF plots using matplotlib.

## Python Script Format

Each `plot-*.py` script must follow this pattern:

### Required Structure

```python
#!/usr/bin/env python3
import os
import sys
import matplotlib.pyplot as plt

def main():
    # Read input file from command line argument
    input_file = sys.argv[1]

    # Get output file from environment variable
    output_file = os.environ.get("OUT")

    # Generate plot using matplotlib
    fig, ax = plt.subplots()
    # ... plotting code ...

    # Save to PDF
    if output_file:
        plt.savefig(output_file, bbox_inches='tight')
    plt.close()

if __name__ == "__main__":
    main()

# ARGS: input-data.csv
```

### Critical Requirements

1. **ARGS comment**: The final line must be `# ARGS: <input-file>` specifying the input file(s)
   - The Makefile extracts this to pass as command line arguments
   - Example: `# ARGS: example-data.csv`

2. **OUT environment variable**: Write output to `os.environ.get("OUT")`
   - The Makefile sets this to the target `.pdf` filename

3. **Input via sys.argv**: Read input files from `sys.argv[1]`, `sys.argv[2]`, etc.

4. **PDF output**: Use `plt.savefig()` to write PDF directly
   - Set `bbox_inches='tight'` to avoid extra whitespace

## Build Command

Generate a plot with:

```bash
make plots/plot-<name>.pdf
```

This runs `plot-<name>.py` with arguments from its `# ARGS:` line and writes to `plot-<name>.pdf`.

## Plot Style Tips

- Use appropriate figure size: `plt.subplots(figsize=(6, 4))`
- Set clear labels: `ax.set_xlabel()`, `ax.set_ylabel()`, `ax.set_title()`
- Use tight layout: `bbox_inches='tight'` in savefig
- Close figures after saving: `plt.close()` to free memory
