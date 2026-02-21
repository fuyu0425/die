# Tables Directory

This directory contains Python scripts that generate LaTeX tables.

## Python Script Format

Each `table-*.py` script must follow this pattern:

### Required Structure

```python
#!/usr/bin/env python3
import os
import sys

def main():
    # Read input file from command line argument
    input_file = sys.argv[1]

    # Get output file from environment variable
    output_file = os.environ.get("OUT")

    # Generate LaTeX table content
    latex_table = "..."

    # Print to stdout (for debugging)
    print(latex_table)

    # Write to output file
    if output_file:
        with open(output_file, "w") as f:
            f.write(latex_table)

if __name__ == "__main__":
    main()

# ARGS: input-data.csv
```

### Critical Requirements

1. **ARGS comment**: The final line must be `# ARGS: <input-file>` specifying the input file(s)
   - The Makefile extracts this to pass as command line arguments
   - Example: `# ARGS: simple-data.csv`

2. **OUT environment variable**: Write output to `os.environ.get("OUT")`
   - The Makefile sets this to the target `.tex` filename

3. **Input via sys.argv**: Read input files from `sys.argv[1]`, `sys.argv[2]`, etc.

## Build Command

Generate a table with:

```bash
make tables/table-<name>.tex
```

This runs `table-<name>.py` with arguments from its `# ARGS:` line and writes to `table-<name>.tex`.

## LaTeX Table Style

Use booktabs for professional tables:

```latex
\begin{tabular}{lrr}
    \toprule
    \textbf{Header1} & \textbf{Header2} & \textbf{Header3} \\
    \midrule
    Data1 & Data2 & Data3 \\
    \bottomrule
\end{tabular}
```
